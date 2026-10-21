# Dino game

The Chrome dino game, made with the [Flame](https://flame-engine.org) engine.
It is an easter egg of the site: it is built to run in an iframe on the home
page.

```sh
flutter run -d chrome   # play it alone (up / space / tap to start)
flutter test
flutter build web
```

Sprites are PNG files in `assets/images/`, see the README there.

## Embedding

The game fills its iframe (transparent background) and always shows 90 world
pixels in height, so give the iframe the size of the block it replaces.

It waits on a still dino until it is started. Controls: up / space / tap to
jump (and to start), down to duck, Escape to leave.

The page and the game talk with `postMessage` of
`{source: 'flame-dino', type: <type>}`, between pages of the same origin only
(see `lib/host_messages.dart`):

| Direction   | type     | Meaning                                      |
| ----------- | -------- | -------------------------------------------- |
| page → game | `start`  | start a run (or a new one after a game over) |
| page → game | `reset`  | back to the waiting screen                   |
| game → page | `ready`  | loaded, waiting for `start`                  |
| game → page | `closed` | the player pressed Escape, hide the iframe   |

The iframe must be focused (`iframe.focus()`) for the keyboard to reach the game.

On the site ([assets/js/dino-easter-egg.js](../assets/js/dino-easter-egg.js)),
the page also sends `reset` when the player clicks or taps anywhere else, or
scrolls the dino out of view, so that the game does not run in the background
and the page gets its keys back.
