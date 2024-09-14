import 'dart:convert';

import 'package:incetro_test/config/base_url.dart';
import 'package:incetro_test/features/card_details/data/models/organisation_model.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/res/sources/remote_source.dart';
import 'package:http/http.dart' as http;

class CardDetailsRemoteSource extends RemoteSource{
  Future<OrganisationModel> getOrganisationById(int id, String token) async{
    final response = await http.get(
      Uri.parse(baseUrl + getOrganisationUrl + '${id.toString()}/'),
      headers: <String, String>{
        'Authorization': 'Token $token',
      }
    );

    if(response.statusCode == 200){
      return OrganisationModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 403){
      throw BadRequestException('Invalid token');
    } else{
      throw Exception('no connection or no organisation with such id');
    }
  }
}