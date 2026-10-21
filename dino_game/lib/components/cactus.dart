import 'dart:ui';

import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Cactus extends SpriteComponent with HasGameReference<DinoGame>, Obstacle {
  Cactus(this.asset)
    : super(
        size: asset.frameSize.clone(),
        position: Vector2(0, DinoGame.groundY),
        anchor: Anchor.bottomLeft,
      );

  final SpriteAsset asset;

  @override
  Future<void> onLoad() async {
    sprite = await asset.loadSprite();
    paint.filterQuality = FilterQuality.none;
    add(RectangleHitbox(position: Vector2.all(1), size: size - Vector2.all(2)));
  }
}
