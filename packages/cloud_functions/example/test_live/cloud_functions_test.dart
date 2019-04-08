// Copyright 2019, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../lib/main.dart';

void main() {
  testWidgets('CloudFunctions example widget test',
      (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    expect(find.text('Cloud Functions example app'), findsOneWidget);
    expect(find.widgetWithText(Padding, 'Response 0: no response'), findsOneWidget);
    await tester.tap(find.text('SEND REQUEST'));
    await tester.pumpAndSettle();
    expect(find.widgetWithText(Padding, 'Response 1: hello world!'), findsOneWidget);
  });
}
