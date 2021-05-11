import 'package:flutter/cupertino.dart';
import 'package:flutter/painting.dart';

import 'package:provider/provider.dart';

class FlameTheme {
  const FlameTheme({
    required this.background,
    required this.backgroundSurface,
    required this.primaryAccent,
    required this.secondaryAccent,
    required this.textColor,
  });

  final Color background;
  final Color backgroundSurface;
  final Color primaryAccent;
  final Color secondaryAccent;
  final Color textColor;

  static final theme = const FlameTheme(
    background: Color(0xFF000000),
    backgroundSurface: Color(0xFF272727),
    primaryAccent: Color(0xFFEB1930),
    secondaryAccent: Color(0xFFF44C32),
    textColor: Color(0xFFFDFFFC),
  );
}

extension ThemeOnContext on BuildContext {
  FlameTheme get flameTheme {
    return this.watch<FlameTheme>();
  }
}
