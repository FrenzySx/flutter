import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:increment/main.dart';

void main() {
  testWidgets('increment and decrement', (tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('0'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('1'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.remove));
    await tester.tap(find.byIcon(Icons.remove));
    await tester.pump();
    expect(find.text('-1'), findsOneWidget);
  });
}
