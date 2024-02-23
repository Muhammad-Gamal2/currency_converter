import 'package:gold_data_api/src/models/models.dart';
import 'package:network_service/network_service.dart';

class GoldDataApi {
  GoldDataApi({NetworkService? networkService})
      : _networkService = networkService ??
            NetworkService(baseUrl: 'https://www.goldapi.io/api');

  final NetworkService _networkService;

  Future<Gold> getGoldPrice() async {
    const request = '/XAU/EGP';
    final response = await _networkService.get(request, headers: {
      'x-access-token': 'goldapi-8s2rrlstg2w9w-io',
    });
    return Gold.fromJson(response);
  }
}
