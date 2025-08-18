// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import "package:scaled_app/scaled_app.dart";

import 'package:stechuhr/pages/overview.dart';

double scaleFactorCallback(Size deviceSize) {
  const double widthOfDesign = 375;
  return deviceSize.width / widthOfDesign;
}

void main() {
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
