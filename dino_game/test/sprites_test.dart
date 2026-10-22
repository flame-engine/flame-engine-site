import 'dart:io';

import 'package:dino_game/dino_game.dart';
import 'package:flame_test/flame_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final sprites = Directory('assets/images')
      .listSync()
      .whereType<File>()
      .where((file) => file.path.endsWith('.png'))
      .map((file) => file.uri.pathSegments.last)
      .toList();

  group('sprites', () {
    test('there are sprites to test', () {
      expect(sprites, isNotEmpty);
    });

    for (final fileName in sprites) {
      testWithGame<DinoGame>('$fileName can be loaded', DinoGame.new, (
        game,
      ) async {
        final sprite = await game.loadSprite(fileName);
        expect(sprite.srcSize.x, greaterThan(0));
        expect(sprite.srcSize.y, greaterThan(0));
      });
    }
  });
}
