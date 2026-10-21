# Dino game sprites

Every sprite is a plain PNG you can edit in any pixel-art editor. Keep the
image size (and the frame size for animated sheets), the game reads them from
the constants in `lib/sprites.dart`. The art is drawn at 1x and scaled up by the
game with no smoothing.

| File | Size | Frames |
| --- | --- | --- |
| dino_idle.png | 22x23 | 1 (also used while jumping) |
| dino_run.png | 44x23 | 2 of 22x23 |
| dino_dead.png | 22x23 | 1 |
| dino_duck.png | 60x14 | 2 of 30x14 |
| bird.png | 48x12 | 2 of 24x12 |
| cactus_small.png | 29x35 | 1 |
| cactus_large.png | 31x50 | 1 |
| cactus_group.png | 83x35 | 1 |
| cloud.png | 34x8 | 1 |
| ground.png | 600x14 | 1, tiles horizontally (keep the left and right edges seamless) |
| restart.png | 18x10 | 1 |
