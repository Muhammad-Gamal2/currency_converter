import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:network_service/network_service.dart';

part 'currency_cubit.freezed.dart';

part 'currency_state.dart';

class CurrencyCubit extends Cubit<CurrencyState> {
  CurrencyCubit({required DataRepository dataRepository})
      : _dataRepository = dataRepository,
        super(const CurrencyState());

  final DataRepository _dataRepository;

  Future<void> getCurrencies() async {
    emit(state.copyWith(status: RequestStatus.inProgress));
    try {
      final currencies = await _dataRepository.getCurrencyPrice();
      if (currencies.isEmpty) {
        emit(
          state.copyWith(
            status: RequestStatus.success,
            currencies: [],
          ),
        );
        return;
      }
      // make the usd the first currency in the list
      final usd = currencies.firstWhere((element) => element.currency == 'USD');
      currencies
        ..remove(usd)
        ..insert(0, usd);
      emit(
        state.copyWith(
          status: RequestStatus.success,
          currencies: currencies,
        ),
      );
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.failure,
          exception: e,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: RequestStatus.failure,
          exception: const CustomException(errorType: Errors.builtInException),
        ),
      );
    }
  }
}
