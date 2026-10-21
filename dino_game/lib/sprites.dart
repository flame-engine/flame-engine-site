import 'package:flame/components.dart';
import 'package:flame/flame.dart';

/// Description of a sprite image stored in `assets/images/`.
///
/// [frameSize] is the size of one frame, so an animated sheet is
/// `frameSize.x * frames` pixels wide.
class SpriteAsset {
  const SpriteAsset(this.fileName, this.frameSize, {this.frames = 1});

  final String fileName;
  final Vector2 frameSize;
  final int frames;

  Vector2 get imageSize => Vector2(frameSize.x * frames, frameSize.y);
}

/// All the sprites of the game. See `assets/images/README.md` before editing.
class Sprites {
  Sprites._();

  static final dinoIdle = SpriteAsset('dino_idle.png', Vector2(22, 23));
  static final dinoRun = SpriteAsset(
    'dino_run.png',
    Vector2(22, 23),
    frames: 2,
  );
  static final dinoDead = SpriteAsset('dino_dead.png', Vector2(22, 23));
  static final dinoDuck = SpriteAsset(
    'dino_duck.png',
    Vector2(30, 14),
    frames: 2,
  );
  static final bird = SpriteAsset('bird.png', Vector2(24, 12), frames: 2);
  static final cactusSmall = SpriteAsset('cactus_small.png', Vector2(12, 18));
  static final cactusLarge = SpriteAsset('cactus_large.png', Vector2(13, 25));
  static final cactusGroup = SpriteAsset('cactus_group.png', Vector2(34, 18));
  static final cloud = SpriteAsset('cloud.png', Vector2(34, 8));
  static final ground = SpriteAsset('ground.png', Vector2(600, 8));
  static final restart = SpriteAsset('restart.png', Vector2(15, 15));

  static final all = [
    dinoIdle,
    dinoRun,
    dinoDead,
    dinoDuck,
    bird,
    cactusSmall,
    cactusLarge,
    cactusGroup,
    cloud,
    ground,
    restart,
  ];

  /// Loads every image into Flame's image cache.
  static Future<void> preload() =>
      Flame.images.loadAll([for (final s in all) s.fileName]);
}

/// Loading helpers, so components never deal with Flame's image cache.
extension SpriteAssetLoading on SpriteAsset {
  Future<Sprite> loadSprite() async {
    final image = await Flame.images.load(fileName);
    return Sprite(image, srcSize: frameSize);
  }

  Future<SpriteAnimation> loadAnimation({double stepTime = 0.1}) async {
    final image = await Flame.images.load(fileName);
    return SpriteAnimation.fromFrameData(
      image,
      SpriteAnimationData.sequenced(
        amount: frames,
        stepTime: stepTime,
        textureSize: frameSize,
      ),
    );
  }
}
