import 'package:incetro_test/features/verification/domain/entities/verification_request.dart';

class VerificationRequestModel {
  late String email;
  final String verificationCode;

  setEmail(String email) {
    this.email = email;
  }
  VerificationRequestModel({required this.verificationCode});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'verification_code': verificationCode,
    };
  }

  factory VerificationRequestModel.fromEntity(VerificationRequest entity){
    return VerificationRequestModel(
      verificationCode: entity.verificationCode,
    );
  }
}