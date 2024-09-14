import 'dart:convert';

import 'package:incetro_test/config/base_url.dart';
import 'package:incetro_test/features/verification/data/models/verification_request_model.dart';
import 'package:incetro_test/features/verification/data/models/verification_response_model.dart';
import 'package:incetro_test/res/failures/failure.dart';
import 'package:incetro_test/res/sources/remote_source.dart';
import 'package:http/http.dart' as http;

class VerificationRemoteSource extends RemoteSource {
  Future<VerificationResponseModel> sendCode(VerificationRequestModel request) async {
    final response = await http.post(
      Uri.parse(baseUrl + sendVerificationCodeUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: json.encode(request.toJson()),
    );

    if (response.statusCode >= 200 && response.statusCode <= 300) {
      return VerificationResponseModel.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400){
      throw BadRequestException('Incorrect code or email');
    } else{
      throw Exception('Something wrong, I can feel it');
    }
  }
}