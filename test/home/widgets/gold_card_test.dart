import 'package:curreny_converter/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('GoldCard Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: GoldCard(
          type: '24K',
          price: 1000,
        ),
      ),
    );

    // Verify that the widget is displayed.
    expect(find.byType(GoldCard), findsOneWidget);

    // Verify that the widget displays the correct type and price.
    expect(find.text('24K'), findsOneWidget);
    expect(find.textContaining('1000'), findsOneWidget);
  });
}
