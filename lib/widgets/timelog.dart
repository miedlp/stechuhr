// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';

import 'package:stechuhr/widgets/dynamicspacing.dart';

class TimeLog extends StatelessWidget {
  const TimeLog() : super();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          // Header row (not scrollable)
          Row(
            children: [
            DynamicSpacing(flex: 2),
            Expanded(
              flex: 1,
              child: Text(
                'Start',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            DynamicSpacing(),
            Expanded(
              flex: 1,
              child: Text(
                'Stop',
                style: TextStyle(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            DynamicSpacing(flex: 2)
          ],
        ),
        // Scrollable data rows
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
                children: [
                  DynamicSpacing(flex: 2),
                  Expanded(
                    flex: 4,
                    child: Table(children: [
                      TableRow(children: [Text('12:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                      TableRow(children: [Text('08:00'), Text('17:00')]),
                    ])
                  ),
                  DynamicSpacing()
                ]
              ),
          ),
        )],
      ),
    );
  }
}
