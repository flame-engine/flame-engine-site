library home;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../common/common.dart';
import '../common/bars.dart';
import '../theme.dart';

part 'content.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width <= 600;
    final padding = mobile
        ? EdgeInsets.only(bottom: bottombarHeight)
        : EdgeInsets.only(top: topbarHeight);

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
