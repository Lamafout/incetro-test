import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:incetro_test/config/base_url.dart';

abstract class RemoteSource {
  Future<Map<String, String>> updateToken(String oldAccessToken, String oldRefreshToken) async{
    final response = await http.post(
      Uri.parse(baseUrl + refreshUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        'access_token': oldAccessToken,
        'refresh_token': oldRefreshToken,
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
    else {
      throw Exception('Failed to load data');
    }
  }
}