// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:scaled_app/scaled_app.dart";

import 'package:stechuhr/pages/overview.dart';
import 'package:stechuhr/src/rust/frb_generated.dart';

double scaleFactorCallback(Size deviceSize) {
  const double widthOfDesign = 375;
  return deviceSize.width / widthOfDesign;
}

Future<void> main() async {
  await RustLib.init();
  runAppScaled(const StechuhrApp(), scaleFactor: scaleFactorCallback);
}

class StechuhrApp extends StatelessWidget {
  const StechuhrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StechuhrAppState(),
      child: MaterialApp(
        title: 'Stechuhr App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        ),
        home: OverviewPage(),
      ),
    );
  }
}