# Dino game sprites

Every sprite is a plain PNG you can edit in any pixel-art editor. Keep the
image size (and the frame size for animated sheets), the game reads them from
the constants in `lib/sprites.dart`. The art is drawn at half resolution, the game
world is 300x75 and is scaled up with no smoothing. Keep all sprites at the same
pixel scale (a dino pixel is as big as a cactus pixel).

| File             | Size  | Frames                                                         |
| ---------------- | ----- | -------------------------------------------------------------- |
| dino_idle.png    | 22x23 | 1 (also used while jumping)                                    |
| dino_run.png     | 44x23 | 2 of 22x23                                                     |
| dino_dead.png    | 22x23 | 1                                                              |
| dino_duck.png    | 60x14 | 2 of 30x14                                                     |
| bird.png         | 48x12 | 2 of 24x12                                                     |
| cactus_small.png | 12x18 | 1                                                              |
| cactus_large.png | 13x25 | 1                                                              |
| cactus_group.png | 34x18 | 1                                                              |
| cloud.png        | 34x8  | 1                                                              |
| ground.png       | 600x8 | 1, tiles horizontally (keep the left and right edges seamless) |
| restart.png      | 15x15 | 1                                                              |
