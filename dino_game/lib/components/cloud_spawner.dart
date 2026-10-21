import 'package:dino_game/components/cloud.dart';
import 'package:dino_game/dino_game.dart';
import 'package:flame/components.dart';

/// Keeps a few clouds in the sky.
class CloudSpawner extends Component with HasGameReference<DinoGame> {
  /// Clouds fly between these heights, below the score.
  static const _minY = 16.0;
  static const _maxY = 44.0;

  double _timeToNext = 0;

  @override
  Future<void> onLoad() async {
    // Some clouds already there when the game is shown.
    for (var i = 0; i < 3; i++) {
      _spawn(x: game.random.nextDouble() * game.worldWidth);
    }
    _scheduleNext();
  }

  @override
  void update(double dt) {
    if (!game.isPlaying) {
      return;
    }
    _timeToNext -= dt;
    if (_timeToNext <= 0) {
      _spawn(x: game.worldWidth);
      _scheduleNext();
    }
  }

  void _scheduleNext() => _timeToNext = 2 + game.random.nextDouble() * 4;

  void _spawn({required double x}) {
    final y = _minY + game.random.nextDouble() * (_maxY - _minY);
    game.world.add(Cloud(x: x, y: y));
  }
}
