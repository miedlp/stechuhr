// Copyright (c) 2025 Philipp Miedl
//
// SPDX-License-Identifier: EUPL-1.2

import 'package:flutter_test/flutter_test.dart';

import 'package:stechuhr/main.dart';
import 'package:stechuhr/src/rust/frb_generated.dart';

import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() async => await RustLib.init());
  testWidgets('Can call rust function', (WidgetTester tester) async {
    await tester.pumpWidget(const StechuhrApp());
    expect(find.textContaining('Diff to date!'), findsOneWidget);
  });
}
