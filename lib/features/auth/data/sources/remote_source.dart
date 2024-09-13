import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:incetro_test/features/auth/data/models/organisations_model.dart';

class RemoteSource {
  final String url;

  RemoteSource(this.url);
  Future<OrganisationsModel> getOrganisations(String token) async {
    final response = await http.get(
        Uri.parse(url),
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
        Uri.parse(url),
      );
    if (response.statusCode == 200) {
      return OrganisationsModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}