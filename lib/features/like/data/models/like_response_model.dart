import 'package:incetro_test/features/like/domain/entities/like_response.dart';

class LikeResponseModel {
  final int? id;
  final String? user;
  final int? organization;

  late String status;
  setStatus(String newStatus) {
    status = newStatus;
  }

  LikeResponseModel({required this.id, required this.user, required this.organization});

  factory LikeResponseModel.fromJson(Map<String, dynamic> json) {
    return LikeResponseModel(
      id: json['id'],
      user: json['user'],
      organization: json['organization'],
    );
  }

  LikeResponse toEntity() {
    return LikeResponse(
      id: id,
      user: user,
      organization: organization,
      status: status,
    );
    }
}