part of 'currency_cubit.dart';

@freezed
class CurrencyState with _$CurrencyState {
  const factory CurrencyState({
    @Default(RequestStatus.initial) RequestStatus status,
    List<Currency>? currencies,
    CustomException? exception,
  }) = _CurrencyState;
}
