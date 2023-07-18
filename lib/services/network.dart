import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;
  final Map<String, String> headers;
  NetworkHelper(this.url, this.headers);

  Future getCoinData() async {
    http.Response response = await http.get(Uri.parse(url), headers: headers);
    var decodeData;
    if (response.statusCode == 200) {
      String data = response.body;
      decodeData = jsonDecode(data);
    } else {
      print(response.statusCode);
    }

    return decodeData;
  }
}
