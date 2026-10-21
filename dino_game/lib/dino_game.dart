import 'dart:math';
import 'dart:ui';

import 'package:dino_game/components/dino.dart';
import 'package:dino_game/components/game_over_panel.dart';
import 'package:dino_game/components/ground.dart';
import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/components/obstacle_spawner.dart';
import 'package:dino_game/components/score_display.dart';
import 'package:dino_game/high_score_storage.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

enum GameState { playing, gameOver }

class DinoGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, TapCallbacks {
  DinoGame({Random? random, HighScoreStorage? storage})
    : random = random ?? Random(),
      _storage = storage ?? HighScoreStorage(),
      super(
        camera: CameraComponent.withFixedResolution(
          width: worldSize.x,
          height: worldSize.y,
        ),
      );

  /// Size of the visible world, in sprite pixels (the art is half resolution).
  static final worldSize = Vector2(300, 75);

  /// Y coordinate of the line the dino and the obstacles run on.
  static const groundY = 63.0;

  static const initialSpeed = 180.0;
  static const maxSpeed = 400.0;

  /// Speed gained per second.
  static const acceleration = 4.0;

  /// A score is one world unit travelled divided by this.
  static const _distancePerPoint = 20;

  /// Delay before a game over can be dismissed, so that a key hammered at the
  /// moment of the crash does not restart the game right away.
  static const restartDelay = 0.3;

  final Random random;
  final HighScoreStorage _storage;

  /// Horizontal scrolling speed, in world units per second.
  double speed = initialSpeed;

  GameState state = GameState.playing;

  int highScore = 0;
  double _distance = 0;
  double _sinceGameOver = 0;

  late final Dino dino;
  late final ObstacleSpawner _spawner;
  GameOverPanel? _gameOverPanel;

  bool get isGameOver => state == GameState.gameOver;

  int get score => _distance ~/ _distancePerPoint;

  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    await Sprites.preload();
    highScore = await _storage.load();
    camera.viewfinder.anchor = Anchor.topLeft;
    dino = Dino();
    _spawner = ObstacleSpawner();
    await world.addAll([Ground(), dino, _spawner, ScoreDisplay()]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) {
      _sinceGameOver += dt;
      return;
    }
    speed = min(maxSpeed, speed + acceleration * dt);
    _distance += speed * dt;
  }

  /// The main action of the game: jump, or restart once the game is over.
  void onAction() {
    if (!isGameOver) {
      dino.jump();
    } else if (_sinceGameOver >= restartDelay) {
      restart();
    }
  }

  void gameOver() {
    if (isGameOver) {
      return;
    }
    state = GameState.gameOver;
    _sinceGameOver = 0;
    dino.die();
    if (score > highScore) {
      highScore = score;
      _storage.save(highScore);
    }
    world.add(_gameOverPanel = GameOverPanel());
  }

  void restart() {
    world.children.whereType<Obstacle>().forEach(
      (o) => (o as Component).removeFromParent(),
    );
    _gameOverPanel?.removeFromParent();
    _gameOverPanel = null;
    _spawner.reset();
    dino.reset();
    speed = initialSpeed;
    _distance = 0;
    state = GameState.playing;
  }

  @override
  void onTapDown(TapDownEvent event) => onAction();
}
