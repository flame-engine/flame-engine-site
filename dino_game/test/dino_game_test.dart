import 'dart:math';

import 'package:dino_game/components/bird.dart';
import 'package:dino_game/components/cactus.dart';
import 'package:dino_game/components/dino.dart';
import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

DinoGame newGame() => DinoGame(random: Random(1));

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
                DinoGame.worldSize.x - (previous.position.x + previous.size.x);
            expect(gap, greaterThan(100));
          }
          previous = obstacle;
        }
      }
      expect(seen.length, greaterThan(3));
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

    test('loads the saved high score', () async {
      SharedPreferences.setMockInitialValues({'dino_high_score': 321});
      final game = newGame();
      await game.onLoad();
      expect(game.highScore, 321);
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
