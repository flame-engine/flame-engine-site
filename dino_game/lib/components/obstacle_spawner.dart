import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';

/// Spawns an obstacle at a fixed interval.
class ObstacleSpawner extends TimerComponent with HasGameReference<DinoGame> {
  ObstacleSpawner() : super(period: 1.4, repeat: true);

  static final _kinds = [
    Sprites.cactusSmall,
    Sprites.cactusLarge,
    Sprites.cactusGroup,
  ];

  int _next = 0;

  @override
  void onTick() {
    if (game.isGameOver) {
      return;
    }
    game.world.add(Obstacle(_kinds[_next++ % _kinds.length]));
  }
}
