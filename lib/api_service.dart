import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CryptoData {
  Future<List<dynamic>> fetchCrypto() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chacheData = prefs.getString('crypto');

    if (chacheData != null) {
      return json.decode(chacheData);
    } else {
      final response = await http.get(Uri.parse(
          'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=10&page=1&sparkline=false')); //jika datanya konek maka dimasukkan await
      if (response.statusCode == 200) {
        prefs.setString('crypto', response.body);
        return json.decode(response.body);
      } else {
        throw Exception('gagal sinkron');
      }
    }
  }
  // Future<List<dynamic>> fetchPost( ) async {
  //   final response = await http.get(Uri.parse(
  //       'https://jsonplaceholder.typicode.com/posts')); //jika datanya konek maka dimasukkan await
  //   if (response.statusCode == 200) {
  //     return json.decode(response.body);
  //   } else {
  //     throw Exception('gagal sinkron');
  //   }
  // }
}
