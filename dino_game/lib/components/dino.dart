import 'dart:ui';

import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

enum DinoState { running, jumping, dead }

class Dino extends SpriteAnimationGroupComponent<DinoState>
    with HasGameReference<DinoGame>, KeyboardHandler, CollisionCallbacks {
  Dino()
    : super(
        size: Sprites.dinoIdle.frameSize.clone(),
        position: Vector2(20, DinoGame.groundY),
        anchor: Anchor.bottomLeft,
      );

  static const gravity = 1080.0;
  static const jumpVelocity = -300.0;

  double _velocityY = 0;

  bool get isOnGround => position.y >= DinoGame.groundY;

  @override
  Future<void> onLoad() async {
    animations = {
      DinoState.running: await Sprites.dinoRun.loadAnimation(),
      DinoState.jumping: await Sprites.dinoIdle.loadAnimation(),
      DinoState.dead: await Sprites.dinoDead.loadAnimation(),
    };
    current = DinoState.running;
    paint.filterQuality = FilterQuality.none;
    add(RectangleHitbox(position: Vector2(4, 2), size: Vector2(14, 19)));
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (game.isGameOver || isOnGround && _velocityY == 0) {
      return;
    }
    _velocityY += gravity * dt;
    position.y += _velocityY * dt;
    if (isOnGround) {
      position.y = DinoGame.groundY;
      _velocityY = 0;
      current = DinoState.running;
    }
  }

  void jump() {
    if (!isOnGround || game.isGameOver) {
      return;
    }
    _velocityY = jumpVelocity;
    current = DinoState.jumping;
  }

  void die() {
    current = DinoState.dead;
  }

  void reset() {
    position.y = DinoGame.groundY;
    _velocityY = 0;
    current = DinoState.running;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    if (event is KeyDownEvent &&
        (event.logicalKey == LogicalKeyboardKey.arrowUp ||
            event.logicalKey == LogicalKeyboardKey.space)) {
      game.onAction();
    }
    return true;
  }

  @override
  void onCollisionStart(
    Set<Vector2> intersectionPoints,
    PositionComponent other,
  ) {
    super.onCollisionStart(intersectionPoints, other);
    if (other is Obstacle) {
      game.gameOver();
    }
  }
}
