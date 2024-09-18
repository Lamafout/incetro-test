import 'package:incetro_test/features/card_details/domain/entities/social.dart';

class SocialModel{
  final int? id;
  final int? type;
  final String? name;
  final String? url;
  final int? organization;

  SocialModel({
    required this.id,
    required this.type,
    required this.name,
    required this.url,
    required this.organization,
  }); 

  factory SocialModel.fromJson(Map<String, dynamic> json) {
    print('МЫ ДОШЛИ ДО ТЕЛА ФУНКЦИИ СОШИАЛ');
    return SocialModel(
      id: json['id'] ?? 0,
      type: json['type'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
      organization: json['organization'] ?? 0,
    );
  }

  Social toEntity() {
    return Social(
      id: id,
      type: type,
      name: name,
      url: url,
      organization: organization,
    );
  }
}