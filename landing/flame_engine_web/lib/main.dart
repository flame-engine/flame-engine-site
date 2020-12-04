import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'package:flameengineweb/theme.dart';
import 'flamecon/flamecon.dart';
import 'home/home.dart';

import 'configure_nonweb.dart' if (dart.library.html) 'configure_web.dart';


void main() {
  configureApp();
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.exo2TextTheme(
          Theme.of(context).textTheme.copyWith(
                bodyText2: TextStyle(
                  color: context.flameTheme.textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
        ),
      ),
      routes: <String, WidgetBuilder>{
        "/": (ctx) => Home(),
        "/flamecon": (ctx) => Flamecon(),
      },
      initialRoute: "home",
    );
  }
}
