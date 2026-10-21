import 'dart:math';

import 'package:dino_game/components/bird.dart';
import 'package:dino_game/components/cactus.dart';
import 'package:dino_game/components/dino.dart';
import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/host_messages.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A game that is already started, so that the tests can run without the
/// waiting screen.
class StartedGame extends DinoGame {
  StartedGame() : super(random: Random(1));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    start();
  }
}

DinoGame newGame() => StartedGame();
DinoGame newIdleGame() => DinoGame(random: Random(1));

/// Runs the game with a fixed time step, for [seconds] of game time.
void run(DinoGame game, double seconds) {
  for (var t = 0.0; t < seconds; t += 0.02) {
    game.update(0.02);
  }
}

/// Puts an obstacle on the dino and lets the collision be detected.
Future<void> crashInto(DinoGame game, Component obstacle) async {
  await game.world.add(obstacle);
  await game.ready();
  game.update(0.016);
  game.update(0.016);
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUp(() => SharedPreferences.setMockInitialValues({}));

  group('waiting screen', () {
    testWithGame<DinoGame>('waits for the start, nothing moves', newIdleGame, (
      game,
    ) async {
      expect(game.state, GameState.idle);
      expect(game.dino.current, DinoState.idle);
      run(game, 3);
      await game.ready();
      expect(game.speed, DinoGame.initialSpeed);
      expect(game.score, 0);
      expect(game.world.children.whereType<Obstacle>(), isEmpty);

      game.dino.jump();
      expect(game.dino.isOnGround, isTrue);
    });

    testWithGame<DinoGame>('tells the page when it is ready', newIdleGame, (
      game,
    ) async {
      expect(game.bridge.sent, [HostEvent.ready]);
    });

    testWithGame<DinoGame>('an action starts the game', newIdleGame, (
      game,
    ) async {
      game.onAction();
      expect(game.state, GameState.playing);
      expect(game.dino.current, DinoState.running);
    });

    testWithGame<DinoGame>('the page can start and reset it', newIdleGame, (
      game,
    ) async {
      game.bridge.onCommand!(HostCommand.start);
      expect(game.isPlaying, isTrue);

      run(game, 1);
      game.bridge.onCommand!(HostCommand.reset);
      await game.ready();
      game.update(0.02);
      await game.ready();
      expect(game.isIdle, isTrue);
      expect(game.dino.current, DinoState.idle);
      expect(game.speed, DinoGame.initialSpeed);
      expect(game.score, 0);
      expect(game.world.children.whereType<Obstacle>(), isEmpty);

      game.bridge.onCommand!(HostCommand.start);
      expect(game.isPlaying, isTrue);
    });

    testWithGame<DinoGame>(
      'the page can start a new run after a game over',
      newGame,
      (game) async {
        await crashInto(game, Cactus(Sprites.cactusSmall)..position.x = 20);
        expect(game.isGameOver, isTrue);
        game.bridge.onCommand!(HostCommand.start);
        expect(game.isPlaying, isTrue);
      },
    );

    testWithGame<DinoGame>(
      'leaving the game tells the page to close it',
      newGame,
      (game) async {
        game.exit();
        expect(game.isIdle, isTrue);
        expect(game.bridge.sent.last, HostEvent.closed);
      },
    );

    testWithGame<DinoGame>('ignores unknown commands', newGame, (game) async {
      game.bridge.onCommand!('nope');
      expect(game.isPlaying, isTrue);
    });
  });

  group('size', () {
    testWithGame<DinoGame>('always shows the same height of world', newGame, (
      game,
    ) async {
      game.onGameResize(Vector2(900, 150));
      expect(
        game.size.y / game.camera.viewfinder.zoom,
        closeTo(DinoGame.worldHeight, 0.001),
      );
      expect(game.worldWidth, closeTo(540, 0.001));
    });

    testWithGame<DinoGame>(
      'keeps a minimum width in a narrow window',
      newGame,
      (game) async {
        game.onGameResize(Vector2(300, 150));
        expect(game.worldWidth, DinoGame.minWorldWidth);
      },
    );
  });

  group('movement', () {
    testWithGame<DinoGame>('starts running on the ground', newGame, (
      game,
    ) async {
      expect(game.state, GameState.playing);
      expect(game.dino.isOnGround, isTrue);
      expect(game.dino.current, DinoState.running);
    });

    testWithGame<DinoGame>('jumps and lands again', newGame, (game) async {
      game.onAction();
      expect(game.dino.current, DinoState.jumping);
      game.update(0.1);
      expect(game.dino.position.y, lessThan(DinoGame.groundY));

      run(game, 1.2);
      expect(game.dino.isOnGround, isTrue);
      expect(game.dino.current, DinoState.running);
    });

    testWithGame<DinoGame>('cannot double jump', newGame, (game) async {
      game.onAction();
      game.update(0.2);
      final y = game.dino.position.y;
      game.dino.jump();
      game.update(0.0);
      expect(game.dino.position.y, y);
    });

    testWithGame<DinoGame>('ducks while down is held', newGame, (game) async {
      final standingHeight = game.dino.size.y;
      game.dino.duck(pressed: true);
      expect(game.dino.current, DinoState.ducking);
      expect(game.dino.size.y, lessThan(standingHeight));

      game.dino.duck(pressed: false);
      expect(game.dino.current, DinoState.running);
      expect(game.dino.size.y, standingHeight);
    });

    testWithGame<DinoGame>('falls faster while ducking in the air', newGame, (
      game,
    ) async {
      game.onAction();
      game.update(0.1);
      final slowY = game.dino.position.y;

      game.dino.reset();
      game.dino.duck(pressed: true);
      game.onAction();
      game.update(0.1);
      expect(game.dino.position.y, greaterThan(slowY));
    });
  });

  group('collisions', () {
    testWithGame<DinoGame>('a cactus ends the game', newGame, (game) async {
      await crashInto(game, Cactus(Sprites.cactusSmall)..position.x = 20);
      expect(game.state, GameState.gameOver);
      expect(game.dino.current, DinoState.dead);
    });

    testWithGame<DinoGame>('a middle bird hits a standing dino', newGame, (
      game,
    ) async {
      await crashInto(game, Bird(BirdLevel.middle)..position.x = 20);
      expect(game.isGameOver, isTrue);
    });

    testWithGame<DinoGame>('a middle bird flies over a ducking dino', newGame, (
      game,
    ) async {
      game.dino.duck(pressed: true);
      await crashInto(game, Bird(BirdLevel.middle)..position.x = 20);
      expect(game.isGameOver, isFalse);
    });

    testWithGame<DinoGame>(
      'a high bird does not touch a running dino',
      newGame,
      (game) async {
        await crashInto(game, Bird(BirdLevel.high)..position.x = 20);
        expect(game.isGameOver, isFalse);
      },
    );

    testWithGame<DinoGame>('a low bird hits a ducking dino', newGame, (
      game,
    ) async {
      game.dino.duck(pressed: true);
      await crashInto(game, Bird(BirdLevel.low)..position.x = 20);
      expect(game.isGameOver, isTrue);
    });
  });

  group('difficulty and score', () {
    testWithGame<DinoGame>(
      'speed and score increase, speed is capped',
      newGame,
      (game) async {
        run(game, 0.5);
        expect(game.speed, greaterThan(DinoGame.initialSpeed));
        expect(game.score, greaterThan(0));

        game.speed = DinoGame.maxSpeed;
        run(game, 1);
        expect(game.speed, DinoGame.maxSpeed);
      },
    );

    testWithGame<DinoGame>(
      'spawns cactus only, before birds are allowed',
      newGame,
      (game) async {
        run(game, 1.2);
        await game.ready();
        final obstacles = game.world.children.whereType<Obstacle>().toList();
        expect(obstacles, isNotEmpty);
        expect(obstacles.every((o) => o is Cactus), isTrue);
      },
    );

    testWithGame<DinoGame>('keeps a gap between two obstacles', newGame, (
      game,
    ) async {
      game.dino.position.x = -1000; // out of the way, to watch the spawner
      final seen = <Component>{};
      PositionComponent? previous;
      for (var i = 0; i < 400; i++) {
        game.update(0.02);
        await game.ready();
        for (final o in game.world.children.whereType<Obstacle>()) {
          final obstacle = o as PositionComponent;
          if (!seen.add(obstacle)) {
            continue;
          }
          if (previous != null) {
            final gap =
                game.worldWidth - (previous.position.x + previous.size.x);
            expect(gap, greaterThan(100));
          }
          previous = obstacle;
        }
      }
      expect(seen.length, greaterThan(3));
    });
  });

  group('saved high score', () {
    setUp(
      () => SharedPreferences.setMockInitialValues({'dino_high_score': 321}),
    );

    testWithGame<DinoGame>('is loaded at start', newIdleGame, (game) async {
      expect(game.highScore, 321);
    });
  });

  group('game over', () {
    testWithGame<DinoGame>('keeps and persists the high score', newGame, (
      game,
    ) async {
      run(game, 1);
      final score = game.score;
      expect(score, greaterThan(0));
      await crashInto(game, Cactus(Sprites.cactusSmall)..position.x = 20);

      expect(game.highScore, score);
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getInt('dino_high_score'), score);
    });

    testWithGame<DinoGame>(
      'an action restarts only after a short delay',
      newGame,
      (game) async {
        await crashInto(game, Cactus(Sprites.cactusSmall)..position.x = 20);
        game.onAction();
        expect(game.isGameOver, isTrue);

        run(game, DinoGame.restartDelay + 0.1);
        game.onAction();
        await game.ready();
        expect(game.state, GameState.playing);
        expect(game.speed, DinoGame.initialSpeed);
        expect(game.score, 0);
        expect(game.dino.current, DinoState.running);
        expect(game.world.children.whereType<Obstacle>(), isEmpty);
      },
    );
  });
}
