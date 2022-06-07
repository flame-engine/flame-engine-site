library home;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../common/bars.dart';
import '../common/common.dart';
import '../theme.dart';

part 'content.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width <= 800;
    final padding = mobile
        ? const EdgeInsets.only(bottom: bottombarHeight)
        : const EdgeInsets.only(top: topbarHeight);

    return Scaffold(
      body: BackgroundStuff(
        stackableChildren: [
          TopBar(),
          BottomBar(),
        ],
        child: Padding(
          padding: padding,
          child: Column(
            children: [
              Content(),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
