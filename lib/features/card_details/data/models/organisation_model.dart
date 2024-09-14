import 'package:incetro_test/features/card_details/data/models/location_model.dart';
import 'package:incetro_test/features/card_details/data/models/schedule_model.dart';
import 'package:incetro_test/features/card_details/data/models/social_model.dart';
import 'package:incetro_test/features/card_details/domain/entities/organisation.dart';

class OrganisationModel {
  final int id;
  final String name;
  final String email;
  final String categoryName;
  final String detailedInfo;
  final List<String> photos;
  final List<String> phones;
  final List<String> urls;
  final List<SocialModel> social;
  final LocationModel location;  
  final List<ScheduleModel> schedules;
  final int rateCount;
  //TODO определиться с типом данных
  final List<dynamic> averageCheck;
  //TODO определиться с типом данных
  final List<dynamic> services;
  final List<String> serviceLanguages;
  final List<String> cuisines;
  final int reviewCount;
  //TODO определиться с типом данных
  final dynamic review;
  //TODO определиться с типом данных
  final dynamic distance;
  final int discount;
  final bool isFavorite;

  OrganisationModel({ 
    required this.id,
    required this.name,
    required this.email,
    required this.categoryName,
    required this.detailedInfo,
    required this.photos,
    required this.phones,
    required this.urls,
    required this.social,
    required this.location,
    required this.schedules,
    required this.rateCount,
    required this.averageCheck,
    required this.services,
    required this.serviceLanguages,
    required this.cuisines,
    required this.reviewCount,
    required this.review,
    required this.distance,
    required this.discount,
    required this.isFavorite,
  });

  factory OrganisationModel.fromJson(Map<String, dynamic> json) {
    return OrganisationModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      categoryName: json['categoryName'],
      detailedInfo: json['detailedInfo'],
      photos: List<String>.from(json['photos'].map((x) => x)),
      phones: List<String>.from(json['phones'].map((x) => x)),
      urls: List<String>.from(json['urls'].map((x) => x)),
      social: List<SocialModel>.from(json['social'].map((x) => SocialModel.fromJson(x))),
      location: LocationModel.fromJson(json['locationModel']),
      schedules: List<ScheduleModel>.from((json['schedules'].map((x) => ScheduleModel.fromJson(x)))),
      rateCount: json['rateCount'],
      averageCheck: List<dynamic>.from(json['averageCheck'].map((x) => x)),
      services: List<dynamic>.from(json['services'].map((x) => x)),
      serviceLanguages: List<String>.from(json['serviceLanguages'].map((x) => x)),
      cuisines: List<String>.from(json['cuisines'].map((x) => x)),
      reviewCount: json['reviewCount'],
      review: json['review'],
      distance: json['distance'],
      discount: json['discount'],
      isFavorite: json['isFavorite'],
    );
  }

  Organisation toEntity() {
    return Organisation(
      id: id,
      name: name,
      email: email,
      categoryName: categoryName,
      detailedInfo: detailedInfo,
      photos: photos,
      phones: phones,
      urls: urls,
      social: social.map((e) => e.toEntity()).toList(),
      location: location.toEntity(),
      schedules: schedules.map((e) => e.toEntity()).toList(),
      rateCount: rateCount,
      averageCheck: averageCheck,
      services: services,
      serviceLanguages: serviceLanguages,
      cuisines: cuisines,
      reviewCount: reviewCount,
      review: review,
      distance: distance,
      discount: discount,
      isFavorite: isFavorite,
      );
  }
}