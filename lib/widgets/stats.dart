// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';

class StatsTable extends StatelessWidget{
  const StatsTable({super.key,
                    required this.recordedTimeDay,
                    required this.recordedTimeWeek,
                    required this.recordedTimeMonth,
                    required this.diffGoalDay,
                    required this.diffGoalWeek,
                    required this.diffGoalMonth,
                   });

  final String recordedTimeDay;
  final String recordedTimeWeek;
  final String recordedTimeMonth;
  final String diffGoalDay;
  final String diffGoalWeek;
  final String diffGoalMonth;

  @override
  Widget build(BuildContext context) {
    return DataTable(
      dataTextStyle: TextStyle(fontSize: 12),
      headingTextStyle: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
      columnSpacing: 25.0,
      dividerThickness: 0.0,
      headingRowHeight: 20.0,
      dataRowMinHeight: 5.0,
      columns: const <DataColumn>[
        DataColumn(
          label: Expanded(
            child: Text(
              'To log display date',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Day',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Week',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              'Month',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('Recorded Time')),
              DataCell(Text(recordedTimeDay)),
              DataCell(Text(recordedTimeWeek)),
              DataCell(Text(recordedTimeMonth)),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('To date diff to goal')),
              DataCell(Text(diffGoalDay)),
              DataCell(Text(diffGoalWeek)),
              DataCell(Text(diffGoalMonth)),
            ]
          ),
        ],
      );
  }
}