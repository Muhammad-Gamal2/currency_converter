import 'package:currency_data_api/currency_data_api.dart' as currency_data_api;
import 'package:data_repository/data_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gold_data_api/gold_data_api.dart' as gold_data_api;
import 'package:mocktail/mocktail.dart';

class MockGoldDataApi extends Mock implements gold_data_api.GoldDataApi {}

class MockCurrencyDataApi extends Mock
    implements currency_data_api.CurrencyDataApi {}

void main() {
  late DataRepository dataRepository;
  late MockGoldDataApi mockGoldDataApi;
  late MockCurrencyDataApi mockCurrencyDataApi;

  setUp(() {
    mockGoldDataApi = MockGoldDataApi();
    mockCurrencyDataApi = MockCurrencyDataApi();
    dataRepository = DataRepository(
      currencyDataApi: mockCurrencyDataApi,
      goldApi: mockGoldDataApi,
    );
  });

  test('getGoldPrice returns Gold', () async {
    when(mockGoldDataApi.getGoldPrice).thenAnswer(
      (_) async => const gold_data_api.Gold(
        goldPrice24k: 2007.9865,
        goldPrice22k: 1840.6543,
        goldPrice21k: 1756.9882,
        goldPrice18k: 1505.9899,
        goldPrice14k: 1171.3255,
        goldPrice10k: 836.6611,
      ),
    );

    final gold = await dataRepository.getGoldPrice();

    expect(gold.goldPrice24k, 2007.9865);
    expect(gold.goldPrice22k, 1840.6543);
    expect(gold.goldPrice21k, 1756.9882);
    expect(gold.goldPrice18k, 1505.9899);
    expect(gold.goldPrice14k, 1171.3255);
    expect(gold.goldPrice10k, 836.6611);
  });

  test('getCurrencyPrice returns List<Currency>', () async {
    when(mockCurrencyDataApi.getCurrencyPrice).thenAnswer(
      (_) async => const currency_data_api.Currency(
        base: 'EUR',
        date: '2024-02-22',
        rates: {
          'EGP': 33.439963,
          'USD': 1.082304,
          'GBP': 0.854916,
          'SAR': 4.059114,
        },
      ),
    );

    final currencies = await dataRepository.getCurrencyPrice();

    expect(currencies[0].base, 'EUR');
    expect(currencies[0].currency, 'EGP');
    expect(currencies[0].rate, 33.439963);
    expect(currencies[1].currency, 'USD');
    expect(currencies[1].rate, 1.082304);
    expect(currencies[2].currency, 'GBP');
    expect(currencies[2].rate, 0.854916);
    expect(currencies[3].currency, 'SAR');
    expect(currencies[3].rate, 4.059114);
  });
}
