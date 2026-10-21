import 'package:dino_game/dino_game.dart';
import 'package:flame/components.dart';
import 'package:flutter/painting.dart';

const _textColor = Color(0xFFFF8B36);

final textPaint = TextPaint(
  style: const TextStyle(
    fontFamily: 'monospace',
    fontSize: 8,
    fontWeight: FontWeight.bold,
    color: _textColor,
  ),
);

/// "HI 00123 00045" in the top right corner.
class ScoreDisplay extends TextComponent with HasGameReference<DinoGame> {
  ScoreDisplay()
    : super(
        textRenderer: textPaint,
        anchor: Anchor.topRight,
        position: Vector2(DinoGame.worldSize.x - 6, 4),
      );

  static String format(int score) => score.toString().padLeft(5, '0');

  @override
  void update(double dt) {
    super.update(dt);
    final best = game.highScore;
    text = best > 0
        ? 'HI ${format(best)}  ${format(game.score)}'
        : format(game.score);
  }
}
