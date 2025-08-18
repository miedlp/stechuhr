// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';

import 'package:stechuhr/widgets/dynamicspacing.dart';

class ButtonRow extends StatelessWidget {
  const ButtonRow() : super(); 

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        DynamicSpacing(),
        Expanded(
          flex: 10,
          child: StyledButton(
            onPressed: () {
            // TODO PMi: Interface to Rust logic, should reset selectedDate to today
          },
            label: 'Start',
          ),
        ),
        DynamicSpacing(),
        Expanded(
          flex: 10,
          child: StyledButton(
            onPressed: null,
            label: 'Stop',
          ),
        ),
        DynamicSpacing(),
      ]
    );
  }
}

class StyledButton extends ElevatedButton {
  StyledButton({
    super.key,
    super.onPressed,
    required String label,
  }) : super(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(8.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            fixedSize: Size(100.0, 50.0)
          ),
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold)
          )
        );
}