import 'dart:ui';

import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/dino_game.dart';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';

enum DinoState { idle, running, jumping, ducking, dead }

class Dino extends SpriteAnimationGroupComponent<DinoState>
    with HasGameReference<DinoGame>, KeyboardHandler, CollisionCallbacks {
  Dino()
    : super(
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
      DinoState.idle: await _loadAnimation('dino_idle.png'),
      DinoState.running: await _loadAnimation('dino_run.png', frames: 2),
      DinoState.jumping: await _loadAnimation('dino_idle.png'),
      DinoState.ducking: await _loadAnimation('dino_duck.png', frames: 2),
      DinoState.dead: await _loadAnimation('dino_dead.png'),
    };
    paint.filterQuality = FilterQuality.none;
    add(_hitbox);
    _setState(DinoState.idle);
  }

  /// Loads an image made of [frames] equal frames side by side.
  Future<SpriteAnimation> _loadAnimation(
    String fileName, {
    int frames = 1,
  }) async {
    final sheet = SpriteSheet.fromColumnsAndRows(
      image: await game.images.load(fileName),
      columns: frames,
      rows: 1,
    );
    return sheet.createAnimation(row: 0, stepTime: 0.1);
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
    size = animations![state]!.frames.first.sprite.srcSize;
    if (state == DinoState.ducking) {
      _hitbox
        ..position = Vector2(4, 3)
        ..size = Vector2(24, 10);
    } else {
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
