import 'package:currency_data_api/src/models/models.dart';
import 'package:network_service/network_service.dart';

class CurrencyDataApi {
  CurrencyDataApi({NetworkService? networkService})
      : _networkService = networkService ??
            NetworkService(baseUrl: 'http://api.exchangeratesapi.io/v1');

  final NetworkService _networkService;

  Future<Currency> getCurrencyPrice() async {
    const request = '/latest';
    final response = await _networkService.get(
      request,
      queryParameters: {
        'access_key': '13c3fb513fdd2b6fd2c441ff25f918ce',
        'symbols': 'EGP,USD,GBP,SAR',
      },
    );
    return Currency.fromJson(response);
  }
}
