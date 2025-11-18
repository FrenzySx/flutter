import 'package:flutter_test/flutter_test.dart';

import 'package:ecommerce_app/main.dart';

void main() {
  testWidgets('intro page smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Shop Now'), findsOneWidget);
  });
}
