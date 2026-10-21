/// Bridge used outside of the browser (tests, desktop): it only records the
/// events instead of sending them.
class HostBridge {
  /// Called with each `HostCommand` received from the page.
  void Function(String type)? onCommand;

  final sent = <String>[];

  void send(String type) => sent.add(type);

  void dispose() {}
}
