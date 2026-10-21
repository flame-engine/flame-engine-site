import 'package:dino_game/components/score_display.dart';
import 'package:dino_game/dino_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class GameOverPanel extends PositionComponent with HasGameReference<DinoGame> {
  GameOverPanel() : super(position: Vector2(DinoGame.minWorldWidth / 2, 0));

  @override
  Future<void> onLoad() async {
    position.x = game.worldWidth / 2;
    await addAll([
      TextComponent(
        text: 'G A M E  O V E R',
        textRenderer: textPaint,
        anchor: Anchor.topCenter,
        position: Vector2(0, 18),
      ),
      SpriteComponent(
        sprite: await game.loadSprite('restart.png'),
        anchor: Anchor.topCenter,
        position: Vector2(0, 32),
        paint: Paint()..filterQuality = FilterQuality.none,
      ),
    ]);
  }
}
