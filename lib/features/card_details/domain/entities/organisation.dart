import 'package:incetro_test/features/card_details/domain/entities/location.dart';
import 'package:incetro_test/features/card_details/domain/entities/schedule.dart';
import 'package:incetro_test/features/card_details/domain/entities/social.dart';

class Organisation {
  final int id;
  final String? name;
  final String? email;
  final String? categoryName;
  final String? detailedInfo;
  final List<String> photos;
  final List<String?> phones;
  final List<String?> urls;
  final List<Social?> social;
  final Location location;  
  final List<Schedule> schedules;
  final int? rateCount;
  final double? rate;
  //TODO определиться с типом данных
  final List<dynamic> averageCheck;
  //TODO определиться с типом данных
  final List<dynamic> services;
  final List<String?> serviceLanguages;
  final List<String?> cuisines;
  final int? reviewCount;
  //TODO определиться с типом данных
  final dynamic review;
  //TODO определиться с типом данных
  final dynamic distance;
  final int? discount;
  final bool isFavorite;

  Organisation({ 
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
    required this.rate,
    required this.review,
    required this.distance,
    required this.discount,
    required this.isFavorite,
  });
}