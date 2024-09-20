import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:incetro_test/config/base_url.dart';
import 'package:incetro_test/features/auth/data/models/organisations_model.dart';
import 'package:incetro_test/res/sources/remote_source.dart';

class RemoteSourceAuth extends RemoteSource{
  Future<OrganisationsModel> getOrganisations(String token) async {
    final response = await http.get(
        Uri.parse(baseUrl + getOrgsUrl),
        headers: <String, String>{
          'Authorization' : 'Token $token'
        }
      );
    if (response.statusCode == 200) {
      print(json.decode(response.body)['data']);
      return OrganisationsModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<OrganisationsModel> getOrganisationsDemo() async{
    final response = await http.get(
        Uri.parse(baseUrl + getOrgsDemoUrl),
      );
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return OrganisationsModel.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load data');
    }
  }
}