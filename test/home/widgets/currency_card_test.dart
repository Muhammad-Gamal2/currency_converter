import 'package:curreny_converter/home/home.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('CurrencyCard Widget Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: CurrencyCard(
          currency: Currency(base: 'EGP', currency: 'USD', rate: 15.5),
        ),
      ),
    );

    // Verify that the widget is displayed.
    expect(find.byType(CurrencyCard), findsOneWidget);

    // Verify that the widget displays the correct currency.
    expect(find.text('1 USD'), findsOneWidget);
    expect(find.textContaining('15.5'), findsOneWidget);
  });
}
