import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:freestyle1/main.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() {
  testWidgets('add task', (tester) async {
    final dir = Directory.systemTemp.createTempSync();
    await tester.runAsync(() async {
      Hive.init(dir.path);
      await Hive.openBox("MyBox");
    });
    await tester.pumpWidget(const MyApp());
    expect(find.text("Make Tutorial"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    await tester.enterText(find.byType(TextField), "New one");
    await tester.tap(find.text("Save"));
    await tester.pump();
    expect(find.text("New one"), findsOneWidget);
  });
}
