import 'package:dino_game/components/bird.dart';
import 'package:dino_game/components/cactus.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';

/// Spawns random obstacles, leaving a gap that grows with the game speed so
/// that the dino always has room to land and jump again.
class ObstacleSpawner extends Component with HasGameReference<DinoGame> {
  /// Score from which birds can appear.
  static const birdMinScore = 80;

  static const _birdChance = 0.3;

  /// Shortest gap, as the time in seconds it takes to cross it.
  static const _minGapTime = 0.6;

  PositionComponent? _last;
  double _gap = 0;

  @override
  void update(double dt) {
    if (game.isGameOver) {
      return;
    }
    final last = _last;
    if (last == null ||
        last.isRemoved ||
        DinoGame.worldSize.x - (last.position.x + last.size.x) >= _gap) {
      _spawn();
    }
  }

  void reset() {
    _last = null;
    _gap = 0;
  }

  void _spawn() {
    final random = game.random;
    final PositionComponent obstacle;
    if (game.score >= birdMinScore && random.nextDouble() < _birdChance) {
      obstacle = Bird(
        BirdLevel.values[random.nextInt(BirdLevel.values.length)],
      );
    } else {
      final roll = random.nextDouble();
      obstacle = Cactus(
        roll < 0.4
            ? Sprites.cactusSmall
            : roll < 0.7
            ? Sprites.cactusLarge
            : Sprites.cactusGroup,
      );
    }
    game.world.add(obstacle);
    _last = obstacle;
    _gap =
        game.speed * (_minGapTime + random.nextDouble() * 0.5) +
        obstacle.size.x;
  }
}
