import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'convert_currency_state.dart';

part 'convert_currency_cubit.freezed.dart';

class ConvertCurrencyCubit extends Cubit<ConvertCurrencyState> {
  ConvertCurrencyCubit() : super(const ConvertCurrencyState());

  void convertCurrency(num amount) {
    final convertedAmount = amount * state.rate;
    emit(state.copyWith(convertedAmount: convertedAmount, amount: amount));
  }

  void setRate({required num rate}) {
    emit(state.copyWith(rate: rate));
  }

  void replaceCurrencies({required num rate}) {
    emit(
      state.copyWith(
        rate: rate,
        fromCurrency: state.toCurrency,
        toCurrency: state.fromCurrency,
        convertedAmount: state.amount * rate,
      ),
    );
  }
}
