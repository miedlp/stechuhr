// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:date_field/date_field.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:stechuhr/widgets/buttons.dart';
import 'package:stechuhr/widgets/clock.dart';
import 'package:stechuhr/widgets/dynamicspacing.dart';
import 'package:stechuhr/widgets/timelog.dart';

import 'package:stechuhr/src/rust/api/formatter.dart';

class OverviewPage extends StatefulWidget {
  @override
  State<OverviewPage> createState() => _OverviewPageState();
}

class StechuhrAppState extends ChangeNotifier {
  var current = WordPair.random();
}

class _OverviewPageState extends State<OverviewPage> {
  DateTime? selectedDate = DateTime.now();
  Duration goalTimeDay = Duration(hours: 8, minutes: 0);
  Duration goalTimeWeek = Duration(hours: 40, minutes: 0);
  Duration goalTimeMonth = Duration(hours: 160, minutes: 0);

  DateTimeFieldPickerPlatform platform = DateTimeFieldPickerPlatform.material;

  void _showGoalPicker() async {
    final tmpGoalTimeWeek =
        await showDurationPicker(
          context: context,
          initialTime: goalTimeWeek,
          baseUnit: BaseUnit.minute,
          upperBound: const Duration(hours: 168),
          lowerBound: const Duration(seconds: 0),
        ) ??
        Duration(hours: 37);
    setState(() {
      var hoursPerDay = tmpGoalTimeWeek.inHours ~/ 5;
      var minutesPerDay =
          (tmpGoalTimeWeek.inMinutes - (hoursPerDay * 5 * 60)) ~/ 5;
      goalTimeWeek = tmpGoalTimeWeek;
      goalTimeDay = Duration(hours: hoursPerDay, minutes: minutesPerDay);
      goalTimeMonth = Duration(hours: goalTimeWeek.inHours * 4);
    });

    if (!context.mounted) return;
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(
      content: Text('Chose weekly time goal: $goalTimeWeek'), duration: const Duration(seconds: 1)
      ));
  }

  String _durationFormatter(Duration timeDuration) {
    String negativeSign = timeDuration.isNegative ? '-' : '';
    if (timeDuration.isNegative) {
      timeDuration *= -1;
    }
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(
      timeDuration.inMinutes.remainder(60).abs(),
    );
    return "$negativeSign${twoDigits(timeDuration.inHours)}:$twoDigitMinutes";
  }

  @override
  Widget build(BuildContext context) {
    var recordedTimeDay = Duration(hours: 7, minutes: 24);
    var recordedTimeWeek = Duration(hours: 37, minutes: 0);
    var recordedTimeMonth = Duration(hours: 148, minutes: 0);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DynamicSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: ClockRow(),
            ),
            DynamicSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: ButtonRow(),
            ),
            DynamicSpacing(),
            Divider(thickness: 3.0, color: Colors.black),
            DynamicSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Text(
                "Time Log",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            DynamicSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 0.0,
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: 6,
                    child: DateTimeField(
                      decoration: const InputDecoration(
                        labelText: 'Log Display Date',
                      ),
                      value: selectedDate,
                      dateFormat: DateFormat.yMEd(),
                      mode: DateTimeFieldPickerMode.date,
                      pickerPlatform: platform,
                      initialPickerDateTime: selectedDate,
                      onChanged: (DateTime? value) {
                        setState(() {
                          selectedDate = value;
                        });
                      },
                    ),
                  ),
                  DynamicSpacing(flex: 5),
                  Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () async {
                        // TODO PMi: settings for sync to google drive
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Icon(
                          Icons.settings,
                          color: Colors.blueAccent,
                          size: 30.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            DynamicSpacing(),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 10.0,
              ),
              child: TimeLog(),
            ),
            DynamicSpacing(),
            DataTable(
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
                    DataCell(Text(_durationFormatter(recordedTimeDay))),
                    DataCell(Text(_durationFormatter(recordedTimeWeek))),
                    DataCell(Text(_durationFormatter(recordedTimeMonth))),
                  ],
                ),
                DataRow(
                  cells: <DataCell>[
                    DataCell(
                      InkWell(
                        onTap: () async {
                          _showGoalPicker();
                        },
                        child: Text(
                          'Diff to date',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    DataCell(
                      Text(formatDuration(durationInMinutes: (recordedTimeDay - goalTimeDay).inMinutes)),
                    ),
                    DataCell(
                      Text(formatDuration(durationInMinutes: (recordedTimeWeek - goalTimeWeek).inMinutes)),
                    ),
                    DataCell(
                      Text(
                        formatDuration(durationInMinutes: (recordedTimeMonth - goalTimeMonth).inMinutes),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            DynamicSpacing(),
          ],
        ),
      ),
    );
  }
}
