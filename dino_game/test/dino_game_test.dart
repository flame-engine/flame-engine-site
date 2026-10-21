import 'package:dino_game/dino_game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('DinoGame', () {
    testWithGame<DinoGame>(
      'loads with an empty world',
      DinoGame.new,
      (game) async {
        expect(game.children, isNotNull);
      },
    );
  });
}
