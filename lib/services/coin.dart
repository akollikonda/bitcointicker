import 'package:bitcointicker/services/network.dart';

const apikey = 'D545616A-50D1-4C33-913E-6039C27642F4';
const urlPattern = 'https://rest.coinapi.io/v1/exchangerate/';
const headers = {'X-CoinAPI-Key': apikey};

class CoinModel {
  Future<Map<String, dynamic>> getCoinData(String coin, String currency) async {
    NetworkHelper helper =
        NetworkHelper('${urlPattern}${coin}/${currency}', headers);

    var coindata = await helper.getCoinData();
    return coindata;
  }
}
