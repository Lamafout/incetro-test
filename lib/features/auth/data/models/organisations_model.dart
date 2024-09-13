import 'package:incetro_test/features/auth/domain/entities/organisations.dart';

class OrganisationsModel{
  int id;
  String name;
  String photo;
  double rate;
  List<int> averageCheck;
  List<String> cuisins;
  bool isFavorite;
  String distance;

  OrganisationsModel({required this.id, required this.name, required this.photo, required this.rate, required this.averageCheck, 
  required this.cuisins, required this.isFavorite, required this.distance});

  factory OrganisationsModel.fromJson(Map<String, dynamic> json){
    return OrganisationsModel(
      id: json['id'],
      name: json['name'],
      photo: json['photo'],
      rate: json['rate'],
      averageCheck: json['averageCheck'],
      cuisins: json['cuisins'],
      isFavorite: json['isFavorite'],
      distance: json['distance'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'name': name,
      'photo': photo,
      'rate': rate,
      'averageCheck': averageCheck,
      'cuisins': cuisins,
      'isFavorite': isFavorite,
      'distance': distance,
    };
  }

  Organisations toEntity(){
    return Organisations(
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