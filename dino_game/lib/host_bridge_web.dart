import 'dart:js_interop';

import 'package:dino_game/host_messages.dart';
import 'package:web/web.dart' as web;

/// Talks to the page embedding the game in an iframe, see `host_messages.dart`.
class HostBridge {
  HostBridge() {
    web.window.addEventListener('message', _listener);
  }

  /// Called with each [HostCommand] received from the page.
  void Function(String type)? onCommand;

  late final JSFunction _listener = _onMessage.toJS;

  void _onMessage(web.MessageEvent event) {
    // Only the pages of the same site can drive the game.
    if (event.origin != web.window.location.origin) {
      return;
    }
    final data = event.data.dartify();
    if (data is Map && data['source'] == hostChannel) {
      onCommand?.call(data['type'] as String);
    }
  }

  void send(String type) {
    final parent = web.window.parent;
    if (parent == null || parent == web.window) {
      return; // Not embedded, e.g. `flutter run`.
    }
    parent.postMessage(
      {'source': hostChannel, 'type': type}.jsify(),
      web.window.location.origin.toJS,
    );
  }

  void dispose() => web.window.removeEventListener('message', _listener);
}
