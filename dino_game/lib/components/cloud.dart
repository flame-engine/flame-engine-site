import 'dart:ui';

import 'package:dino_game/dino_game.dart';
import 'package:flame/components.dart';

/// A cloud drifting slowly behind everything else.
class Cloud extends SpriteComponent with HasGameReference<DinoGame> {
  Cloud({required double x, required double y})
    : super(position: Vector2(x, y), priority: -1);

  /// A cloud moves at this fraction of the speed of the ground.
  static const speedFactor = 0.1;

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite('cloud.png');
    size = sprite!.srcSize;
    paint.filterQuality = FilterQuality.none;
  }

  @override
  void update(double dt) {
    if (!game.isPlaying) {
      return;
    }
    super.update(dt);
    position.x -= game.speed * speedFactor * dt;
    if (position.x + size.x < 0) {
      removeFromParent();
    }
  }
}
