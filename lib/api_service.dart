import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  Future<List<dynamic>> fetchPhotos() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chacheData = prefs.getString('photos');

    if (chacheData != null) {
      return json.decode(chacheData);
    } else {
      final response = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/photos')); //jika datanya konek maka dimasukkan await
      if (response.statusCode == 200) {
        prefs.setString('photos', response.body);
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
