import 'dart:ui';

import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';

/// How high above the ground a bird flies.
enum BirdLevel {
  /// The dino has to jump.
  low(2),

  /// The dino can jump or duck.
  middle(16),

  /// The dino can simply run under it.
  high(30);

  const BirdLevel(this.lift);

  final double lift;
}

class Bird extends SpriteAnimationComponent
    with HasGameReference<DinoGame>, Obstacle {
  Bird(BirdLevel level)
    : super(
        position: Vector2(0, DinoGame.groundY - level.lift),
        anchor: Anchor.bottomLeft,
      );

  @override
  double get extraSpeed => 20;

  @override
  Future<void> onLoad() async {
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: await game.images.load('bird.png'),
      columns: 2,
      rows: 1,
    );
    animation = sheet.createAnimation(row: 0, stepTime: 0.2);
    size = animation!.frames.first.sprite.srcSize;
    paint.filterQuality = FilterQuality.none;
    add(RectangleHitbox(position: Vector2(2, 2), size: Vector2(20, 8)));
  }
}
