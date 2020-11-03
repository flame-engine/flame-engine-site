import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flameengineweb/theme.dart';
import 'home/home.dart';

void main() {
  setUrlStrategy(PathUrlStrategy());
  runApp(Provider<FlameTheme>(
    create: (_) => FlameTheme.theme,
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flame engine',
      theme: ThemeData(
        textTheme: GoogleFonts.exo2TextTheme(
          Theme.of(context).textTheme.copyWith(
                body1: TextStyle(
                  color: context.flameTheme.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
      ),
      home: Scaffold(
        body: Home(),
      ),
    );
  }
}
