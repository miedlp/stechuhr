// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stechuhr/main.dart';

void main() {
  testWidgets('Diff to Goal Smoke Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const StechuhrApp());

    // TODO PMi: Verify that the Diff to Goal setting is working.

    //// Verify that our counter starts at 0.
    //expect(find.text('0'), findsOneWidget);
    //expect(find.text('1'), findsNothing);

    //// Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byIcon(Icons.add));
    //await tester.pump();

    //// Verify that our counter has incremented.
    //expect(find.text('0'), findsNothing);
    //expect(find.text('1'), findsOneWidget);
  });
}
