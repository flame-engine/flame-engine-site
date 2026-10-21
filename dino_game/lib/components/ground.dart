import 'dart:ui';

import 'package:dino_game/dino_game.dart';
import 'package:flame/components.dart';

/// The scrolling ground line, made of one tile repeated horizontally.
class Ground extends PositionComponent with HasGameReference<DinoGame> {
  Ground()
    : super(
        position: Vector2(0, DinoGame.groundY - 1),
        size: Vector2(DinoGame.minWorldWidth, 0),
      );

  final _paint = Paint()..filterQuality = FilterQuality.none;
  late final Sprite _tile;
  double _offset = 0;

  @override
  Future<void> onLoad() async {
    _tile = await game.loadSprite('ground.png');
    size.y = _tile.srcSize.y;
  }

  @override
  void update(double dt) {
    size.x = game.worldWidth;
    if (!game.isPlaying) {
      return;
    }
    _offset = (_offset + game.speed * dt) % _tile.srcSize.x;
  }

  @override
  void render(Canvas canvas) {
    final tileSize = _tile.srcSize;
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
