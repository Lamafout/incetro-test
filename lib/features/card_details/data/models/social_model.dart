import 'package:incetro_test/features/card_details/domain/entities/social.dart';

class SocialModel{
  final int id;
  final int type;
  final String name;
  final String url;
  final int organisation;

  SocialModel({
    required this.id,
    required this.type,
    required this.name,
    required this.url,
    required this.organisation,
  }); 

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    return SocialModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      url: json['url'],
      organisation: json['organisation'],
    );
  }

  Social toEntity() {
    return Social(
      id: id,
      type: type,
      name: name,
      url: url,
      organisation: organisation,
    );
  }
}