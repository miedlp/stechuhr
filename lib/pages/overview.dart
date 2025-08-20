// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:date_field/date_field.dart';
import 'package:duration_picker/duration_picker.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

import 'package:stechuhr/widgets/buttons.dart';
import 'package:stechuhr/widgets/clock.dart';
import 'package:stechuhr/widgets/dynamicspacing.dart';
import 'package:stechuhr/widgets/stats.dart';
import 'package:stechuhr/widgets/timelog.dart';
import 'package:stechuhr/widgets/timelog_separator.dart';
import 'package:stechuhr/widgets/logsettings.dart';

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
  
  bool started = false;

  Duration goalTimeDay = Duration(hours: 8, minutes: 0);
  Duration goalTimeWeek = Duration(hours: 40, minutes: 0);
  Duration goalTimeMonth = Duration(hours: 160, minutes: 0);

  DateTimeFieldPickerPlatform platform = DateTimeFieldPickerPlatform.material;

  @override
  Widget build(BuildContext context) {
    var recordedTimeDay = Duration(hours: 7, minutes: 24);
    var recordedTimeWeek = Duration(hours: 37, minutes: 0);
    var recordedTimeMonth = Duration(hours: 148, minutes: 0);
    var tablerows = [
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
                    ];

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            DynamicSpacing(),
            ClockRow(),
            DynamicSpacing(),
            ButtonRow(
              onPressedStart: started ? null : () {
                  // TODO PMi: Interface to Rust logic
                  setState(() {
                    started = true;
                    selectedDate = DateTime.now();
                });
              },
              onPressedStop: started ? () {
                  // TODO PMi: Interface to Rust logic
                  setState(() {
                    started = false;
                    selectedDate = DateTime.now();
                });
              } : null
            ),
            DynamicSpacing(),
            TimelogSeparator(),
            DynamicSpacing(),
            Builder(
              builder: (BuildContext context) {
                return LogSettings(
                  selectedDate: selectedDate!,
                  platform: platform,
                  onChangedDate: (DateTime? value) {
                    setState(() {
                      selectedDate = value;
                    });
                  },
                  onTapSettings: () async {
                    Scaffold.of(context).openDrawer();
                  }
                );
              }
            ),
            DynamicSpacing(),
            TimeLog(tablerows: tablerows,),
            DynamicSpacing(),
            StatsTable(
              recordedTimeDay:    formatDuration(durationInMinutes: recordedTimeDay.inMinutes), 
              recordedTimeWeek:   formatDuration(durationInMinutes: recordedTimeWeek.inMinutes), 
              recordedTimeMonth:  formatDuration(durationInMinutes: recordedTimeMonth.inMinutes), 
              diffGoalDay:        formatDuration(durationInMinutes: (recordedTimeDay - goalTimeDay).inMinutes),
              diffGoalWeek:       formatDuration(durationInMinutes: (recordedTimeWeek - goalTimeWeek).inMinutes), 
              diffGoalMonth:      formatDuration(durationInMinutes: (recordedTimeMonth - goalTimeMonth).inMinutes),
            ),
            DynamicSpacing(),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Stechuhr App Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Set Weekly Time Goal'),
              onTap: () async {
                // TODO PMi: Navigate to settings page
                Navigator.pop(context);

                //InkWell(
                //  onTap: () async {
                //    _showGoalPicker();
                //  },
                //  child: Text(
                //    'Diff to date',
                //    style: TextStyle(color: Colors.blueAccent),
                //  ),
                //);

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
                  content: Text('Weekly time goal set to: ${formatDuration(durationInMinutes: goalTimeWeek.inMinutes)}'), duration: const Duration(seconds: 1)
                ));
              }
            ),
            ListTile(
              title: Text('Google Drive Sync'),
              onTap: () {
                // TODO PMi: settings for sync to google drive
                Navigator.pop(context);
              }
            )
          ],
        ),
      ),
    );
  }
}
