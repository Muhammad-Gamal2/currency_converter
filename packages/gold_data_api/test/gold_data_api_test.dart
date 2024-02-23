import 'package:flutter_test/flutter_test.dart';
import 'package:gold_data_api/src/gold_data_api.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_service/network_service.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  test('getGoldPrice returns Gold', () async {
    final mockNetworkService = MockNetworkService();
    when(
      () => mockNetworkService.get(
        '/XAU/EGP',
        headers: any(named: 'headers'),
      ),
    ).thenAnswer(
      (_) async => {
        'timestamp': 1708641650,
        'metal': 'XAU',
        'currency': 'EGP',
        'exchange': 'GOLDAPI',
        'symbol': 'GOLDAPI:XAUEGP',
        'open_time': 1708560000,
        'price': 62455.3622,
        'ch': -49.977,
        'ask': 62469.399,
        'bid': 62441.3255,
        'price_gram_24k': 2007.9865,
        'price_gram_22k': 1840.6543,
        'price_gram_21k': 1756.9882,
        'price_gram_20k': 1673.3221,
        'price_gram_18k': 1505.9899,
        'price_gram_16k': 1338.6577,
        'price_gram_14k': 1171.3255,
        'price_gram_10k': 836.6611,
      },
    );

    final api = GoldDataApi(networkService: mockNetworkService);

    final gold = await api.getGoldPrice();

    expect(gold.goldPrice24k, 2007.9865);
    expect(gold.goldPrice22k, 1840.6543);
    expect(gold.goldPrice21k, 1756.9882);
    expect(gold.goldPrice18k, 1505.9899);
    expect(gold.goldPrice14k, 1171.3255);
    expect(gold.goldPrice10k, 836.6611);
  });

  test('getGoldPrice throws an exception when the API returns 404', () async {
    final mockNetworkService = MockNetworkService();
    when(
      () => mockNetworkService.get(
        '/XAU/EGP',
        headers: any(named: 'headers'),
      ),
    ).thenThrow(const CustomException(errorType: Errors.builtInException));

    final api = GoldDataApi(networkService: mockNetworkService);

    expect(
      () async => api.getGoldPrice(),
      throwsA(isA<CustomException>()),
    );
  });
}
