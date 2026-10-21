import 'dart:ui';

import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

enum CactusKind {
  small('cactus_small.png'),
  large('cactus_large.png'),
  group('cactus_group.png');

  const CactusKind(this.fileName);

  final String fileName;
}

class Cactus extends SpriteComponent with HasGameReference<DinoGame>, Obstacle {
  Cactus(this.kind)
    : super(
        position: Vector2(0, DinoGame.groundY),
        anchor: Anchor.bottomLeft,
      );

  final CactusKind kind;

  @override
  Future<void> onLoad() async {
    sprite = await game.loadSprite(kind.fileName);
    size = sprite!.srcSize;
    paint.filterQuality = FilterQuality.none;
    add(RectangleHitbox(position: Vector2.all(1), size: size - Vector2.all(2)));
  }
}
