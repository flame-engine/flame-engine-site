import 'package:shared_preferences/shared_preferences.dart';

/// Persists the best score (localStorage on the web).
class HighScoreStorage {
  static const _key = 'dino_high_score';

  Future<int> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt(_key) ?? 0;
    } on Exception catch (_) {
      return 0;
    }
  }

  Future<void> save(int score) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(_key, score);
    } on Exception catch (_) {
      // Storage can be unavailable (private mode), the game still works.
    }
  }
}
