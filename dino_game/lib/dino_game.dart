import 'dart:ui';

import 'package:dino_game/sprites.dart';
import 'package:flame/game.dart';

class DinoGame extends FlameGame {
  @override
  Color backgroundColor() => const Color(0x00000000);

  @override
  Future<void> onLoad() async {
    await Sprites.preload();
  }
}
