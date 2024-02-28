import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConvertCurrencyCubit extends MockCubit<ConvertCurrencyState>
    implements ConvertCurrencyCubit {}

void main() {
  late ConvertCurrencyCubit convertCurrencyCubit;

  setUp(() {
    convertCurrencyCubit = MockConvertCurrencyCubit();
  });
  testWidgets('ConverterWidget and ItemWidget Test',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ConverterWidget(
            state: ConvertCurrencyState(
              fromCurrency: 'USD',
              toCurrency: 'EGP',
              rate: 15.5,
              convertedAmount: 155,
              amount: 10,
            ),
          ),
        ),
      ),
    );

    // Verify that the ConverterWidget is displayed.
    expect(find.byType(ConverterWidget), findsOneWidget);

    // Verify that the ItemWidget is displayed.
    expect(find.byType(ItemWidget), findsNWidgets(2));

    // Verify that the widgets display the correct currency and amount.
    expect(find.text('USD'), findsOneWidget);
    expect(find.text('EGP'), findsOneWidget);
    expect(find.text('155.00'), findsOneWidget);
  });

  testWidgets('Test change currency button', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    when(() => convertCurrencyCubit.state).thenReturn(
      const ConvertCurrencyState(
        fromCurrency: 'USD',
        toCurrency: 'EGP',
        rate: 15,
        convertedAmount: 1575,
        amount: 105,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: BlocProvider<ConvertCurrencyCubit>.value(
            value: convertCurrencyCubit,
            child: ConverterWidget(
              state: convertCurrencyCubit.state,
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.byIcon(Icons.swap_vert_circle_outlined));
    await tester.pump();

    when(() => convertCurrencyCubit.state).thenReturn(
      const ConvertCurrencyState(
        rate: 1/15,
        convertedAmount: 7,
        amount: 105,
      ),
    );

    // Verify that the currency is changed.
    expect(find.textContaining('7'), findsOneWidget);
  });
}
