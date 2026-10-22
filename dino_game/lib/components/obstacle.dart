import 'package:dino_game/dino_game.dart';
import 'package:flame/components.dart';

/// Something that scrolls towards the dino and ends the game on contact.
mixin Obstacle on PositionComponent, HasGameReference<DinoGame> {
  /// Extra speed on top of the scrolling speed of the ground.
  double get extraSpeed => 0;

  @override
  void update(double dt) {
    if (game.isIdle) {
      removeFromParent(); // e.g. spawned in the frame where the game was reset
      return;
    }
    if (!game.isPlaying) {
      return;
    }
    super.update(dt);
    position.x -= (game.speed + extraSpeed) * dt;
    if (position.x + size.x < 0) {
      removeFromParent();
    }
  }
}
