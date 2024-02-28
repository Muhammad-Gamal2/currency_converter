part of 'convert_currency_cubit.dart';

@freezed
class ConvertCurrencyState with _$ConvertCurrencyState {
  const factory ConvertCurrencyState({
    @Default(0) num amount,
    @Default(0) num rate,
    @Default(0) num convertedAmount,
    @Default('EGP') String fromCurrency,
    @Default('USD') String toCurrency,
}) = _ConvertCurrencyState;
}
