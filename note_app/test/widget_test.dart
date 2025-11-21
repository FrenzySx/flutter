import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:note_app/components/note_tile.dart';
import 'package:note_app/theme/theme_provider.dart';

void main() {
  testWidgets('NoteTile shows text and fires callbacks', (tester) async {
    var edited = false;
    var deleted = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: NoteTile(
            text: 'hello',
            onEditPressed: () => edited = true,
            onDeletePressed: () => deleted = true,
          ),
        ),
      ),
    );
    expect(find.text('hello'), findsOneWidget);
    await tester.tap(find.byIcon(Icons.edit));
    await tester.tap(find.byIcon(Icons.delete));
    expect(edited && deleted, isTrue);
  });

  test('ThemeProvider toggles dark mode', () {
    final p = ThemeProvider();
    expect(p.isDarkMode, isFalse);
    p.toggleTheme();
    expect(p.isDarkMode, isTrue);
  });
}
