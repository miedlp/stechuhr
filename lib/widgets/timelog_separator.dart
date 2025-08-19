// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';

class TimelogSeparator extends StatelessWidget{
  const TimelogSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(thickness: 3.0, color: Colors.black),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 8.0,
          ),
          child: Text(
            "Time Log",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        )
      ]
    );
  }
}