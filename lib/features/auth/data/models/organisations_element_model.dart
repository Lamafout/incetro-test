import 'package:incetro_test/features/auth/domain/entities/organisations_element.dart';

class OrganisationsElementModel {
  int id;
  String? name;
  String? photo;
  double? rate;
  List<dynamic> averageCheck;
  List<String>? cuisins;
  bool? isFavorite;
  // TODO определиться с типом данных
  dynamic distance;

  OrganisationsElementModel({required this.id, required this.name, required this.photo, required this.rate, required this.averageCheck, 
  required this.cuisins, required this.isFavorite, required this.distance});

  factory OrganisationsElementModel.fromJson(Map<String, dynamic> json) {
    return OrganisationsElementModel(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      rate: json['rate'],
      averageCheck: json['averageCheck'],
      cuisins: json['cuisins'],
      isFavorite: json['isCavorite'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'rate': rate,
      'average_check': averageCheck,
      'cuisins': cuisins,
      'is_favorite': isFavorite,
      'distance': distance,
    };
  }

  OrganisationsElement toEntity() {
    return OrganisationsElement(
      id: id,
      name: name,
      photo: photo,
      rate: rate,
      averageCheck: averageCheck,
      cuisins: cuisins,
      isFavorite: isFavorite,
      distance: distance,
    );

  }
}