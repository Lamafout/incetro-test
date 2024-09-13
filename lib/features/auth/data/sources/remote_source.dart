import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:incetro_test/config/base_url.dart';
import 'package:incetro_test/features/auth/data/models/organisations_model.dart';

class RemoteSource {
  RemoteSource();
  Future<OrganisationsModel> getOrganisations(String token) async {
    final response = await http.get(
        Uri.parse(baseUrl + getOrgsUrl),
        headers: <String, String>{
          'Authorization' : 'Token $token'
        }
      );
    if (response.statusCode == 200) {
      return OrganisationsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<OrganisationsModel> getOrganisationsDemo() async{
    final response = await http.get(
        Uri.parse(baseUrl + getOrgsDemoUrl),
      );
    if (response.statusCode == 200) {
      return OrganisationsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

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