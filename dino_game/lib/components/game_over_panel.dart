import 'package:dino_game/components/score_display.dart';
import 'package:dino_game/dino_game.dart';
import 'package:dino_game/sprites.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

class GameOverPanel extends PositionComponent {
  GameOverPanel() : super(position: Vector2(DinoGame.worldSize.x / 2, 0));

  @override
  Future<void> onLoad() async {
    final restart = Sprites.restart.frameSize;
    await addAll([
      TextComponent(
        text: 'G A M E  O V E R',
        textRenderer: textPaint,
        anchor: Anchor.topCenter,
        position: Vector2(0, 18),
      ),
      SpriteComponent(
        sprite: await Sprites.restart.loadSprite(),
        size: restart.clone(),
        anchor: Anchor.topCenter,
        position: Vector2(0, 32),
        paint: Paint()..filterQuality = FilterQuality.none,
      ),
    ]);
  }
}
