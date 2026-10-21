import 'dart:ui';

import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';

/// The scrolling ground line, made of one tile repeated horizontally.
class Ground extends PositionComponent with HasGameReference<DinoGame> {
  Ground()
    : super(
        position: Vector2(0, DinoGame.groundY - 1),
        size: Vector2(DinoGame.worldSize.x, Sprites.ground.frameSize.y),
      );

  final _paint = Paint()..filterQuality = FilterQuality.none;
  late final Sprite _tile;
  double _offset = 0;

  @override
  Future<void> onLoad() async {
    _tile = await Sprites.ground.loadSprite();
  }

  @override
  void update(double dt) {
    if (game.isGameOver) {
      return;
    }
    _offset = (_offset + game.speed * dt) % Sprites.ground.frameSize.x;
  }

  @override
  void render(Canvas canvas) {
    final tileSize = Sprites.ground.frameSize;
    for (var x = -_offset; x < size.x; x += tileSize.x) {
      _tile.render(
        canvas,
        position: Vector2(x, 0),
        size: tileSize,
        overridePaint: _paint,
      );
    }
  }
}
