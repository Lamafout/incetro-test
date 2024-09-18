import 'package:incetro_test/features/send_email/domain/entities/send_email.dart';

class SendEmailModel {
  String email;
  String type;
  SendEmailModel({required this.email}) : type = '0';

  factory SendEmailModel.fromJson(Map<String, dynamic> json) {
    return SendEmailModel(
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['type'] = type;
    return data;
  }

  factory SendEmailModel.fromEntity(SendEmail entity){
    return SendEmailModel(email: entity.email);
  }
}