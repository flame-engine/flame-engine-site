/// Protocol between the game and the web page embedding it in an iframe.
///
/// Every message is a `postMessage` of `{source: hostChannel, type: <type>}`,
/// in both directions, between pages of the same origin.
const hostChannel = 'flame-dino';

/// Commands the page can send to the game.
class HostCommand {
  HostCommand._();

  /// Starts a run (or a new one after a game over).
  static const start = 'start';

  /// Goes back to the waiting screen.
  static const reset = 'reset';
}

/// Events the game sends to the page.
class HostEvent {
  HostEvent._();

  /// The game is loaded and waits for a [HostCommand.start].
  static const ready = 'ready';

  /// The player left the game with Escape, the page should hide it.
  static const closed = 'closed';
}
