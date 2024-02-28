import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:network_service/network_service.dart';

part 'gold_cubit.freezed.dart';

part 'gold_state.dart';

class GoldCubit extends Cubit<GoldState> {
  GoldCubit({required DataRepository dataRepository})
      : _dataRepository = dataRepository,
        super(const GoldState());

  final DataRepository _dataRepository;

  Future<void> getGoldPrices() async {
    emit(state.copyWith(status: RequestStatus.inProgress));
    try {
      final goldPrices = await _dataRepository.getGoldPrice();
      emit(
        state.copyWith(
          status: RequestStatus.success,
          goldPrices: goldPrices,
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
