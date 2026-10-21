import 'dart:ui';

import 'package:dino_game/components/dino.dart';
import 'package:dino_game/components/ground.dart';
import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/components/obstacle_spawner.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

enum GameState { playing, gameOver }

class DinoGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, TapCallbacks {
  DinoGame()
    : super(
        camera: CameraComponent.withFixedResolution(
          width: worldSize.x,
          height: worldSize.y,
        ),
      );

  /// Size of the visible world, in sprite pixels (the art is half resolution).
  static final worldSize = Vector2(300, 75);

  /// Y coordinate of the line the dino and the obstacles run on.
  static const groundY = 63.0;

  /// Horizontal scrolling speed, in world units per second.
  double speed = 180;

  GameState state = GameState.playing;

  late final Dino dino;

  bool get isGameOver => state == GameState.gameOver;

  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    await Sprites.preload();
    camera.viewfinder.anchor = Anchor.topLeft;
    dino = Dino();
    await world.addAll([Ground(), dino, ObstacleSpawner()]);
  }

  /// The single action of the game: jump, or restart once the game is over.
  void onAction() {
    if (isGameOver) {
      restart();
    } else {
      dino.jump();
    }
  }

  void gameOver() {
    if (isGameOver) {
      return;
    }
    state = GameState.gameOver;
    dino.die();
  }

  void restart() {
    world.children.whereType<Obstacle>().forEach((o) => o.removeFromParent());
    dino.reset();
    state = GameState.playing;
  }

  @override
  void onTapDown(TapDownEvent event) => onAction();
}
