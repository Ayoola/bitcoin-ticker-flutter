import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const String kApiKey = 'EC95181E-B1CF-46AD-AA06-0CA70CDE7720';

class CoinData {
  Future<dynamic> getCoinData(String currency) async {
    http.Response response = await http.get(
      'https://rest.coinapi.io/v1/exchangerate/BTC/$currency',
      headers: {
        'X-CoinAPI-Key': kApiKey,
      },
    );

    var coinData = await jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      return coinData;
    }
  }
}
