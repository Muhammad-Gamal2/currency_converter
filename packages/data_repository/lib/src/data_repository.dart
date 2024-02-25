import 'package:currency_data_api/currency_data_api.dart' hide Currency;
import 'package:data_repository/src/models/models.dart';
import 'package:gold_data_api/gold_data_api.dart' hide Gold;

class DataRepository {
  DataRepository({GoldDataApi? goldApi, CurrencyDataApi? currencyDataApi})
      : _goldApi = goldApi ?? GoldDataApi(),
        _currencyDataApi = currencyDataApi ?? CurrencyDataApi();

  final GoldDataApi _goldApi;
  final CurrencyDataApi _currencyDataApi;

  Future<Gold> getGoldPrice() async {
    final gold = await _goldApi.getGoldPrice();
    return Gold(
      goldPrice24k: gold.goldPrice24k,
      goldPrice22k: gold.goldPrice22k,
      goldPrice21k: gold.goldPrice21k,
      goldPrice18k: gold.goldPrice18k,
      goldPrice14k: gold.goldPrice14k,
      goldPrice10k: gold.goldPrice10k,
    );
  }

  Future<List<Currency>> getCurrencyPrice() async {
    final currency = await _currencyDataApi.getCurrencyPrice();
    final EGPRate = currency.rates['EGP'] ?? 1;
    return currency.rates.entries.map(
      (e) {
        if (e.key == 'EGP') {
          return Currency(
            base: 'EGP',
            currency: 'EUR',
            rate: EGPRate,
          );
        }
        return Currency(
          base: 'EGP',
          currency: e.key,
          rate: EGPRate/e.value,
        );
      },
    ).toList();
  }
}
