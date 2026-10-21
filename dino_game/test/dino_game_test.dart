import 'package:dino_game/components/dino.dart';
import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('DinoGame', () {
    testWithGame<DinoGame>(
      'starts with the dino running on the ground',
      DinoGame.new,
      (game) async {
        expect(game.state, GameState.playing);
        expect(game.dino.isOnGround, isTrue);
        expect(game.dino.current, DinoState.running);
      },
    );

    testWithGame<DinoGame>('the dino jumps and lands again', DinoGame.new, (
      game,
    ) async {
      game.onAction();
      expect(game.dino.current, DinoState.jumping);

      game.update(0.1);
      expect(game.dino.isOnGround, isFalse);
      expect(game.dino.position.y, lessThan(DinoGame.groundY));

      for (var i = 0; i < 60; i++) {
        game.update(0.02);
      }
      expect(game.dino.isOnGround, isTrue);
      expect(game.dino.current, DinoState.running);
    });

    testWithGame<DinoGame>('the dino cannot double jump', DinoGame.new, (
      game,
    ) async {
      game.onAction();
      game.update(0.2);
      final y = game.dino.position.y;
      game.dino.jump();
      game.update(0.0);
      expect(game.dino.position.y, y);
    });

    testWithGame<DinoGame>('hitting an obstacle ends the game', DinoGame.new, (
      game,
    ) async {
      await game.world.add(Obstacle(Sprites.cactusSmall)..position.x = 20);
      await game.ready();
      game.update(0.016);
      game.update(0.016);

      expect(game.state, GameState.gameOver);
      expect(game.dino.current, DinoState.dead);
    });

    testWithGame<DinoGame>(
      'an action after game over restarts it',
      DinoGame.new,
      (game) async {
        await game.world.add(Obstacle(Sprites.cactusSmall)..position.x = 20);
        await game.ready();
        game.update(0.016);
        game.update(0.016);
        expect(game.isGameOver, isTrue);

        game.onAction();
        await game.ready();
        expect(game.state, GameState.playing);
        expect(game.dino.current, DinoState.running);
        expect(game.world.children.whereType<Obstacle>(), isEmpty);
      },
    );

    testWithGame<DinoGame>(
      'obstacles leave the world on the left',
      DinoGame.new,
      (game) async {
        await game.world.add(Obstacle(Sprites.cactusSmall));
        await game.ready();
        for (var i = 0; i < 100; i++) {
          game.update(0.02);
          if (game.isGameOver) {
            game.restart();
          }
        }
        await game.ready();
        expect(
          game.world.children.whereType<Obstacle>().every(
            (o) => o.position.x + o.size.x >= 0,
          ),
          isTrue,
        );
      },
    );
  });
}
