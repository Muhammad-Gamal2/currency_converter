import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/blocs/convert_currency/convert_currency_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ConvertCurrencyCubit convertCurrencyCubit;

  setUp(() {
    convertCurrencyCubit = ConvertCurrencyCubit();
  });
  group('ConvertCurrencyCubit', () {
    blocTest<ConvertCurrencyCubit, ConvertCurrencyState>(
      'emits new state when convertCurrency is called',
      build: () => convertCurrencyCubit,
      seed: () => const ConvertCurrencyState(
        rate: 10.0,
      ),
      act: (cubit) => cubit.convertCurrency(100),
      expect: () => [
        const ConvertCurrencyState(
          amount: 100,
          convertedAmount: 1000,
          rate: 10,
        ),
      ],
    );

    blocTest<ConvertCurrencyCubit, ConvertCurrencyState>(
      'emits new state when setRate is called',
      build: () => convertCurrencyCubit,
      act: (cubit) => cubit.setRate(rate: 1.5),
      expect: () => [
        const ConvertCurrencyState(
          rate: 1.5,
        ),
      ],
    );

    blocTest<ConvertCurrencyCubit, ConvertCurrencyState>(
      'emits new state when replaceCurrencies is called',
      build: () => convertCurrencyCubit,
      act: (cubit) => cubit.replaceCurrencies(rate: 2.0),
      seed: () => const ConvertCurrencyState(
        amount: 100,
        rate: 1.0,
      ),
      expect: () => [
        const ConvertCurrencyState(
          amount: 100,
          convertedAmount: 200,
          rate: 2.0,
          fromCurrency: 'USD',
          toCurrency: 'EGP',
        ),
      ],
    );
  });
}
