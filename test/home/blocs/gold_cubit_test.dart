import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_service/network_service.dart';

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  group('GoldCubit', () {
    late MockDataRepository mockDataRepository;

    setUp(() {
      mockDataRepository = MockDataRepository();
    });

    const gold =
      Gold(goldPrice22k: 100, goldPrice24k: 200, goldPrice21k: 300);

    blocTest<GoldCubit, GoldState>(
      'emits [GoldState(status: RequestStatus.inProgress), '
      'GoldState(status: RequestStatus.success)] '
      'when getGoldPrices is successful',
      build: () {
        when(() => mockDataRepository.getGoldPrice())
            .thenAnswer((_) async => gold);
        return GoldCubit(dataRepository: mockDataRepository);
      },
      act: (cubit) => cubit.getGoldPrices(),
      expect: () => <GoldState>[
        const GoldState(status: RequestStatus.inProgress),
        const GoldState(status: RequestStatus.success, goldPrices: gold),
      ],
    );

    blocTest<GoldCubit, GoldState>(
      'emits [GoldState(status: RequestStatus.inProgress), '
      'GoldState(status: RequestStatus.failure)] '
      'when getGoldPrices fails',
      build: () {
        when(() => mockDataRepository.getGoldPrice()).thenThrow(
          const CustomException(errorType: Errors.builtInException),
        );
        return GoldCubit(dataRepository: mockDataRepository);
      },
      act: (cubit) => cubit.getGoldPrices(),
      expect: () => <GoldState>[
        const GoldState(status: RequestStatus.inProgress),
        const GoldState(
          status: RequestStatus.failure,
          exception: CustomException(errorType: Errors.builtInException),
        ),
      ],
    );
  });
}
