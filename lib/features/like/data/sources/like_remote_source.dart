import 'dart:convert';

import 'package:incetro_test/config/base_url.dart';
import 'package:incetro_test/features/like/data/models/like_response_model.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/res/sources/remote_source.dart';
import 'package:http/http.dart' as http;

class LikeRemoteSource extends RemoteSource {
  Future<LikeResponseModel> postLike(int id, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl$getOrganizationUrl${id.toString()}/favorite/'),
      headers: <String, String>{
        'Authorization': 'Token $token'
      }
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      final decodedBody = json.decode(response.body);
      return decodedBody['id'] == null
      ? throw IsAlreadyLikedException('Organisation with id $id is already in favorites of user')
      : LikeResponseModel.fromJson(decodedBody);
    }
    else if (response.statusCode == 403){
      throw IncorrectTokenException('Incorrect access token, need to refresh');
    } else{
      throw Exception();
    }
  }

  Future<void> deleteLike(int id, String token) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$getOrganizationUrl${id.toString()}/favorite/'),
      headers: <String, String>{
        'Authorization': 'Token $token'
      }
    );
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return;
    }
    else if (response.statusCode == 403){
      throw IncorrectTokenException('Incorrect access token, need to refresh');
    } else if (response.statusCode == 404){
      throw BadRequestException('Orgaisation with id $id is already not in favorites or no organisation with such id');
    } else {
      throw Exception();
    }
  }
}