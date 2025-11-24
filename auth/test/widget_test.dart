import 'package:auth/components/my_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('MyButton shows text and handles tap', (tester) async {
    var taps = 0;
    await tester.pumpWidget(
      MaterialApp(home: MyButton(onTap: () => taps++, text: 'Go')),
    );
    await tester.tap(find.text('Go'));
    expect(taps, 1);
  });
}
