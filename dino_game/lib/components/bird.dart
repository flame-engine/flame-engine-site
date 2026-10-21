import 'dart:ui';

import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

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
        size: Sprites.bird.frameSize.clone(),
        position: Vector2(DinoGame.worldSize.x, DinoGame.groundY - level.lift),
        anchor: Anchor.bottomLeft,
      );

  @override
  double get extraSpeed => 20;

  @override
  Future<void> onLoad() async {
    animation = await Sprites.bird.loadAnimation(stepTime: 0.2);
    paint.filterQuality = FilterQuality.none;
    add(RectangleHitbox(position: Vector2(2, 2), size: Vector2(20, 8)));
  }
}
