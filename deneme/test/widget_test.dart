import 'package:deneme/main.dart';
import 'package:deneme/themes/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

void main() {
  testWidgets('tap toggles theme', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ThemeProvider(),
        child: const MyApp(),
      ),
    );
    expect(Theme.of(tester.element(find.text('Tap'))).brightness, Brightness.light);
    await tester.tap(find.text('Tap'));
    await tester.pumpAndSettle();
    expect(Theme.of(tester.element(find.text('Tap'))).brightness, Brightness.dark);
  });
}
