import 'dart:math';
import 'dart:ui';

import 'package:dino_game/components/dino.dart';
import 'package:dino_game/components/game_over_panel.dart';
import 'package:dino_game/components/ground.dart';
import 'package:dino_game/components/obstacle.dart';
import 'package:dino_game/components/obstacle_spawner.dart';
import 'package:dino_game/components/score_display.dart';
import 'package:dino_game/high_score_storage.dart';
import 'package:dino_game/host_bridge.dart';
import 'package:dino_game/host_messages.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';

/// [idle] is the waiting screen: nothing moves until the game is started.
enum GameState { idle, playing, gameOver }

class DinoGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents, TapCallbacks {
  DinoGame({Random? random, HighScoreStorage? storage, HostBridge? bridge})
    : random = random ?? Random(),
      _storage = storage ?? HighScoreStorage(),
      bridge = bridge ?? HostBridge();

  /// Height of the visible world, in sprite pixels (the art is half
  /// resolution). The game is always scaled to show exactly this height.
  static const worldHeight = 75.0;

  /// The world is at least this wide, so that obstacles always show up early
  /// enough, even in a narrow window.
  static const minWorldWidth = 300.0;

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

  /// Link with the page embedding the game.
  final HostBridge bridge;

  /// Horizontal scrolling speed, in world units per second.
  double speed = initialSpeed;

  GameState state = GameState.idle;

  int highScore = 0;
  double _distance = 0;
  double _sinceGameOver = 0;

  late final Dino dino;
  late final ObstacleSpawner _spawner;
  GameOverPanel? _gameOverPanel;

  bool get isIdle => state == GameState.idle;
  bool get isPlaying => state == GameState.playing;
  bool get isGameOver => state == GameState.gameOver;

  /// Visible width of the world, which follows the shape of the window.
  double get worldWidth => size.x / camera.viewfinder.zoom;

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
    _updateZoom();
    bridge
      ..onCommand = _onHostCommand
      ..send(HostEvent.ready);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    _updateZoom();
  }

  @override
  void onRemove() {
    bridge.dispose();
    super.onRemove();
  }

  void _updateZoom() {
    if (size.x <= 0 || size.y <= 0) {
      return;
    }
    camera.viewfinder.zoom = min(size.y / worldHeight, size.x / minWorldWidth);
  }

  void _onHostCommand(String type) {
    switch (type) {
      case HostCommand.start:
        start();
      case HostCommand.reset:
        reset();
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (isGameOver) {
      _sinceGameOver += dt;
    }
    if (!isPlaying) {
      return;
    }
    speed = min(maxSpeed, speed + acceleration * dt);
    _distance += speed * dt;
  }

  /// The main action of the game: start, jump, or restart once the game is
  /// over.
  void onAction() {
    switch (state) {
      case GameState.idle:
        start();
      case GameState.playing:
        dino.jump();
      case GameState.gameOver:
        if (_sinceGameOver >= restartDelay) {
          restart();
        }
    }
  }

  /// Starts a run from the waiting screen, or a new one after a game over.
  void start() {
    if (isPlaying) {
      return;
    }
    restart();
  }

  /// Back to the waiting screen.
  void reset() {
    _clearRun();
    dino.idle();
    state = GameState.idle;
  }

  /// The player left the game: waits again and tells the page to hide it.
  void exit() {
    reset();
    bridge.send(HostEvent.closed);
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
    _clearRun();
    dino.reset();
    state = GameState.playing;
  }

  void _clearRun() {
    world.children.whereType<Obstacle>().forEach(
      (o) => (o as Component).removeFromParent(),
    );
    _gameOverPanel?.removeFromParent();
    _gameOverPanel = null;
    _spawner.reset();
    speed = initialSpeed;
    _distance = 0;
  }

  @override
  void onTapDown(TapDownEvent event) => onAction();
}
