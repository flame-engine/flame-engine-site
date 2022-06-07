library flamecon;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../common/bars.dart';
import '../common/common.dart';
import '../theme.dart';

part 'content.dart';
part 'data.dart';

class Flamecon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mobile = MediaQuery.of(context).size.width <= 600;
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
