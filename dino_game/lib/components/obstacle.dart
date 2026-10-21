import 'dart:ui';

import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

/// A static obstacle (cactus) scrolling towards the dino.
class Obstacle extends SpriteComponent with HasGameReference<DinoGame> {
  Obstacle(this.asset)
    : super(
        size: asset.frameSize.clone(),
        position: Vector2(DinoGame.worldSize.x, DinoGame.groundY),
        anchor: Anchor.bottomLeft,
      );

  final SpriteAsset asset;

  @override
  Future<void> onLoad() async {
    sprite = await asset.loadSprite();
    paint.filterQuality = FilterQuality.none;
    add(RectangleHitbox(position: Vector2.all(1), size: size - Vector2.all(2)));
  }

  @override
  void update(double dt) {
    if (game.isGameOver) {
      return;
    }
    position.x -= game.speed * dt;
    if (position.x + size.x < 0) {
      removeFromParent();
    }
  }
}
