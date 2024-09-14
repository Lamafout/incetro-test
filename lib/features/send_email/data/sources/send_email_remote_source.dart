import 'dart:convert';

import 'package:incetro_test/config/base_url.dart';
import 'package:incetro_test/features/send_email/data/models/send_email_model.dart';
import 'package:incetro_test/res/sources/remote_source.dart';
import 'package:http/http.dart' as http;

class SendEmailRemoteSource extends RemoteSource{
  Future<bool> sendEmail(SendEmailModel requestEmail) async{
    final response = await http.post(
      Uri.parse(baseUrl + sendEmailUrl),
      headers: <String, String>{
        'Content-Type': 'application/json'
      },
      body: jsonEncode(requestEmail.toJson()),
    );
    if (response.statusCode == 200){
      return json.decode(response.body)['status'];
    }
    else{
      throw Exception('Failed to send email');
    }
  }
}