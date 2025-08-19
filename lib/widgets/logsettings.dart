// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:stechuhr/widgets/dynamicspacing.dart';

class LogSettings extends StatelessWidget{
  const LogSettings({super.key,
                          required this.selectedDate,
                          required this.platform,
                          required this.onChangedDate,
                          required this.onTapSettings});

  final DateTime selectedDate;
  final DateTimeFieldPickerPlatform platform;
  final ValueChanged<DateTime?>? onChangedDate;
  final VoidCallback? onTapSettings;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 0.0
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
                  onChanged: onChangedDate
                )
              ),
              DynamicSpacing(flex: 5),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: onTapSettings,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.settings,
                      color: Colors.blueAccent,
                      size: 30.0
                    )
                  )
                )
              )
            ]
          )
        )
      ]
    );
  }
}