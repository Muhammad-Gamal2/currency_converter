import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockConvertCurrencyCubit extends MockCubit<ConvertCurrencyState>
    implements ConvertCurrencyCubit {}

class MockCurrencyCubit extends MockCubit<CurrencyState>
    implements CurrencyCubit {}

void main() {
  late MockConvertCurrencyCubit mockCubit;
  late CurrencyCubit currencyCubit;

  setUp(() {
    mockCubit = MockConvertCurrencyCubit();
    currencyCubit = MockCurrencyCubit();
  });

  testWidgets('ConverterPage Widget Test', (WidgetTester tester) async {
    const currencies = [
      Currency(base: 'EGP', currency: 'USD', rate: 15.5),
      Currency(base: 'EGP', currency: 'EUR', rate: 18.5),
    ];
    when(() => mockCubit.state).thenReturn(
      const ConvertCurrencyState(
        rate: 15.5,
      ),
    );

    when(() => currencyCubit.state).thenReturn(
      const CurrencyState(
        status: RequestStatus.success,
        currencies: currencies,
      ),
    );

    whenListen(
      currencyCubit,
      Stream<CurrencyState>.fromIterable([
        const CurrencyState(),
        const CurrencyState(
          currencies: currencies,
          status: RequestStatus.success,
        ),
      ]),
    );

    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: MultiBlocProvider(
          providers: [
            BlocProvider.value(
              value: mockCubit,
            ),
            BlocProvider.value(
              value: currencyCubit,
            ),
          ],
          child: const ConverterPage(),
        ),
      ),
    );

    // Verify that the ConverterPage is displayed.
    expect(find.byType(ConverterPage), findsOneWidget);

    // Verify that the ConverterWidget is displayed.
    expect(find.byType(ConverterWidget), findsOneWidget);
  });
}
