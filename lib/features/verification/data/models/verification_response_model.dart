import 'package:incetro_test/features/verification/domain/entities/verification_response.dart';

class VerificationResponseModel {
  final String email;
  final String accessToken;
  final String refreshToken;
  VerificationResponseModel({required this.email, required this.accessToken, required this.refreshToken});

  factory VerificationResponseModel.fromJson(Map<String, dynamic> json) {
    return VerificationResponseModel(
      email: json['email'],
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'access_token': accessToken,
      'refresh_token': refreshToken,
    };
  }

  VerificationResponse toEntity(){
    return VerificationResponse(
      email: email,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  factory VerificationResponseModel.fromEntity(VerificationResponse entity){
    return VerificationResponseModel(
      email: entity.email,
      accessToken: entity.accessToken,
      refreshToken: entity.refreshToken,
    );
  }
}