part of 'gold_cubit.dart';

@freezed
class GoldState with _$GoldState {
  const factory GoldState({
    @Default(RequestStatus.initial) RequestStatus status,
    Gold? goldPrices,
    CustomException? exception,
  }) = _GoldState;
}
