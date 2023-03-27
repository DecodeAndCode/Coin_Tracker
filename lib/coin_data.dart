import 'package:http/http.dart' as http;
import 'dart:convert';

const List<String> currenciesList = [
  'INR',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'AUD',
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
  'MATIC'
];

const apiUrl = 'https://rest.coinapi.io/v1/exchangerate';
const apiKey = 'AF3AC315-BD62-4E89-AE05-FBA161C169F4';

class CoinData {
  Future getCoinData(String selectedCurrency) async {
    Map<String, String> cryptoPrices = {};

    for (String crypto in cryptoList) {
      String Url = '$apiUrl/$crypto/$selectedCurrency?apikey=$apiKey';
      print(Url);
      http.Response response = await http.get(Uri.parse(Url));

      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        double lastPrice = decodedData['rate'];
        cryptoPrices[crypto] = lastPrice.toStringAsFixed(2);
      } else {
        print(response.statusCode);
        throw 'Problem with the get request';
      }
    }
    return cryptoPrices;
  }
}
