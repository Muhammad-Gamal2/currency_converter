import 'package:currency_data_api/src/currency_data_api.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:network_service/network_service.dart';

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  test('getCurrencyPrice returns Currency', () async {
    final mockNetworkService = MockNetworkService();
    when(() => mockNetworkService.get('/latest',
        headers: any(named: 'headers'),),).thenAnswer(
      (_) async => {
        'success': true,
        'timestamp': 1708638483,
        'base': 'EUR',
        'date': '2024-02-22',
        'rates': {
          'EGP': 33.439963,
          'USD': 1.082304,
          'GBP': 0.854916,
          'SAR': 4.059114,
        },
      },
    );

    final api = CurrencyDataApi(networkService: mockNetworkService);

    final currency = await api.getCurrencyPrice();

    expect(currency.base, 'EUR');
    expect(currency.date, '2024-02-22');
    expect(currency.rates['EGP'], 33.439963);
    expect(currency.rates['USD'], 1.082304);
    expect(currency.rates['GBP'], 0.854916);
    expect(currency.rates['SAR'], 4.059114);
  });

  test('getCurrencyPrice throws an exception when the API returns 429', ()
  async {
    final mockNetworkService = MockNetworkService();
    when(
          () => mockNetworkService.get(
        '/latest',
        headers: any(named: 'headers'),
      ),
    ).thenThrow(const CustomException(errorType: Errors.builtInException));

    final api = CurrencyDataApi(networkService: mockNetworkService);

    expect(
          () async => api.getCurrencyPrice(),
      throwsA(isA<CustomException>()),
    );
  });
}
