import 'dart:ui';

import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

enum DinoState { idle, running, jumping, ducking, dead }

class Dino extends SpriteAnimationGroupComponent<DinoState>
    with HasGameReference<DinoGame>, KeyboardHandler, CollisionCallbacks {
  Dino()
    : super(
        size: Sprites.dinoIdle.frameSize.clone(),
        position: Vector2(8, DinoGame.groundY),
        anchor: Anchor.bottomLeft,
      );

  static const gravity = 1080.0;
  static const jumpVelocity = -300.0;

  /// Holding down while in the air makes the dino fall faster.
  static const fastFallFactor = 3.0;

  // Given a size from the start, otherwise the hitbox would fill the sprite.
  final _hitbox = RectangleHitbox(
    position: Vector2(4, 2),
    size: Vector2(14, 19),
  );

  double _velocityY = 0;
  bool _duckHeld = false;

  bool get isOnGround => position.y >= DinoGame.groundY;

  @override
  Future<void> onLoad() async {
    animations = {
      DinoState.idle: await Sprites.dinoIdle.loadAnimation(),
      DinoState.running: await Sprites.dinoRun.loadAnimation(),
      DinoState.jumping: await Sprites.dinoIdle.loadAnimation(),
      DinoState.ducking: await Sprites.dinoDuck.loadAnimation(),
      DinoState.dead: await Sprites.dinoDead.loadAnimation(),
    };
    paint.filterQuality = FilterQuality.none;
    add(_hitbox);
    _setState(DinoState.idle);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (!game.isPlaying || isOnGround && _velocityY == 0) {
      return;
    }
    _velocityY += gravity * (_duckHeld ? fastFallFactor : 1) * dt;
    position.y += _velocityY * dt;
    if (isOnGround) {
      position.y = DinoGame.groundY;
      _velocityY = 0;
      _setState(_groundState);
    }
  }

  DinoState get _groundState =>
      _duckHeld ? DinoState.ducking : DinoState.running;

  void jump() {
    if (!isOnGround || !game.isPlaying) {
      return;
    }
    _velocityY = jumpVelocity;
    _setState(DinoState.jumping);
  }

  void duck({required bool pressed}) {
    _duckHeld = pressed;
    if (isOnGround && game.isPlaying) {
      _setState(_groundState);
    }
  }

  void die() => _setState(DinoState.dead);

  /// Back on the ground, waiting for the game to start.
  void idle() {
    position.y = DinoGame.groundY;
    _velocityY = 0;
    _setState(DinoState.idle);
  }

  void reset() {
    position.y = DinoGame.groundY;
    _velocityY = 0;
    _setState(_groundState);
  }

  /// Switches the animation, and resizes the sprite and its hitbox to match.
  void _setState(DinoState state) {
    current = state;
    if (state == DinoState.ducking) {
      size = Sprites.dinoDuck.frameSize.clone();
      _hitbox
        ..position = Vector2(4, 3)
        ..size = Vector2(24, 10);
    } else {
      size = Sprites.dinoIdle.frameSize.clone();
      _hitbox
        ..position = Vector2(4, 2)
        ..size = Vector2(14, 19);
    }
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final key = event.logicalKey;
    if (event is KeyDownEvent) {
      if (key == LogicalKeyboardKey.arrowUp ||
          key == LogicalKeyboardKey.space) {
        game.onAction();
      } else if (key == LogicalKeyboardKey.arrowDown) {
        duck(pressed: true);
      } else if (key == LogicalKeyboardKey.escape) {
        game.exit();
      }
    } else if (event is KeyUpEvent && key == LogicalKeyboardKey.arrowDown) {
      duck(pressed: false);
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
