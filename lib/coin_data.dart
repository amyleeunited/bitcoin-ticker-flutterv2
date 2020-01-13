import 'dart:convert';

import 'package:http/http.dart' as http;
//import 'package:convert/convert.dart';

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

const bitCoinAverageURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker';

class CoinData {

  Future getBitCoinData(String currency) async{

    String requestURL = '$bitCoinAverageURL/BTC$currency';
    http.Response response = await http.get(requestURL);
    if(response.statusCode == 200){
      String data = response.body;
      return jsonDecode(data);

    }
    else{
      print(response.statusCode);
    }

  }

  Future getEthereumData(String currency) async{

    String requestURL = '$bitCoinAverageURL/ETH$currency';
    http.Response response = await http.get(requestURL);
    if(response.statusCode == 200){
      String data = response.body;
      return jsonDecode(data);

    }
    else{
      print(response.statusCode);
    }

  }

  Future getLiteCoinData(String currency) async{

    String requestURL = '$bitCoinAverageURL/LTC$currency';
    http.Response response = await http.get(requestURL);
    if(response.statusCode == 200){
      String data = response.body;
      return jsonDecode(data);

    }
    else{
      print(response.statusCode);
    }

  }
}
