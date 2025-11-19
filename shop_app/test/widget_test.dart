import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/main.dart';
import 'package:shop_app/models/shop.dart';

void main() {
  testWidgets('intro to shop and add to cart', (tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(create: (_) => Shop(), child: const MyApp()),
    );
    expect(find.text('Minimal Shop'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_forward));
    await tester.pumpAndSettle();
    expect(find.text('Product 1'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.add).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Yes'));
    await tester.pumpAndSettle();
    expect(find.text('1'), findsOneWidget);
  });
}
