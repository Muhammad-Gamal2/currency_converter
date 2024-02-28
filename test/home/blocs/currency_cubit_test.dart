import 'package:bloc_test/bloc_test.dart';
import 'package:curreny_converter/home/home.dart';
import 'package:curreny_converter/shared/shared.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_service/network_service.dart';

class MockDataRepository extends Mock implements DataRepository {}

void main() {
  group('CurrencyCubit', () {
    late MockDataRepository mockDataRepository;

    setUp(() {
      mockDataRepository = MockDataRepository();
    });


    final currencies = <Currency>[
      const Currency(base: 'EGP', currency: 'USD', rate: 30.38),
    ];

    blocTest<CurrencyCubit, CurrencyState>(
      'emits [CurrencyState(status: RequestStatus.inProgress), '
      'CurrencyState(status: RequestStatus.success)] '
      'when getCurrencies is successful',
      build: () {
        when(() => mockDataRepository.getCurrencyPrice())
            .thenAnswer((_) async => currencies);
        return CurrencyCubit(dataRepository: mockDataRepository);
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => <CurrencyState>[
        const CurrencyState(status: RequestStatus.inProgress),
        CurrencyState(status: RequestStatus.success, currencies: currencies),
      ],
    );

    blocTest<CurrencyCubit, CurrencyState>(
      'emits [CurrencyState(status: RequestStatus.inProgress), '
      'CurrencyState(status: RequestStatus.success)] '
      'when getCurrencies is successful but returns empty list',
      build: () {
        when(() => mockDataRepository.getCurrencyPrice())
            .thenAnswer((_) async => <Currency>[]);
        return CurrencyCubit(dataRepository: mockDataRepository);
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => <CurrencyState>[
        const CurrencyState(status: RequestStatus.inProgress),
        const CurrencyState(
          status: RequestStatus.success,
          currencies: <Currency>[],
        ),
      ],
    );

    blocTest<CurrencyCubit, CurrencyState>(
      'emits [CurrencyState(status: RequestStatus.inProgress), '
      'CurrencyState(status: RequestStatus.failure)] '
      'when getCurrencies fails',
      build: () {
        when(() => mockDataRepository.getCurrencyPrice()).thenThrow(
          const CustomException(errorType: Errors.builtInException),
        );
        return CurrencyCubit(dataRepository: mockDataRepository);
      },
      act: (cubit) => cubit.getCurrencies(),
      expect: () => <CurrencyState>[
        const CurrencyState(status: RequestStatus.inProgress),
        const CurrencyState(
          status: RequestStatus.failure,
          exception: CustomException(errorType: Errors.builtInException),
        ),
      ],
    );
  });
}
