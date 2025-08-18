// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';

import 'package:stechuhr/widgets/dynamicspacing.dart';

class ClockRow extends StatelessWidget {
  const ClockRow() : super();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DynamicSpacing(flex: 2),
        Expanded(
          flex: 6,
          child: AnalogClock.dark(
            dateTime: DateTime.now(),
            isKeepTime: true,
            child: Align(
              alignment: FractionalOffset(0.5, 0.7),
              child: FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  DateTime.now().timeZoneName,
                  style: TextStyle(color: Colors.grey, fontSize: 8),
                ),
              ),
            ),
          ),
        ),
        DynamicSpacing(flex: 2),
      ],
    );
  }
}
