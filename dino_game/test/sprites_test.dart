import 'package:dino_game/sprites.dart';
import 'package:flame/flame.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Sprites', () {
    for (final sprite in Sprites.all) {
      test('${sprite.fileName} matches its declared size', () async {
        final image = await Flame.images.load(sprite.fileName);
        expect(image.width, sprite.imageSize.x.toInt());
        expect(image.height, sprite.imageSize.y.toInt());
      });
    }

    test('sprites and animations can be built', () async {
      final sprite = await Sprites.dinoIdle.loadSprite();
      expect(sprite.srcSize, Sprites.dinoIdle.frameSize);

      final animation = await Sprites.dinoRun.loadAnimation();
      expect(animation.frames.length, 2);
    });
  });
}
