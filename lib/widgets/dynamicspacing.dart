// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter/material.dart';

class DynamicSpacing extends StatelessWidget {
  final int flex;
  final Color color;

  const DynamicSpacing({
    super.key,
    this.flex = 1,
    this.color = Colors.transparent,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(color: color),
    );
  }
}
