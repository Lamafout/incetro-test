import 'package:incetro_test/features/card_details/domain/entities/location.dart';

class LocationModel{
  final int id;
  final double latitude;
  final double longitude;
  final String city;
  final String address;
  final int organisation;
  final int district;

  LocationModel(this.id, this.latitude, this.longitude, this.city, this.address, this.organisation, this.district);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      json['id'],
      json['latitude'],
      json['longitude'],
      json['city'],
      json['address'],
      json['organisation'],
      json['district'],
    );
  }

  Location toEntity() {
    return Location(
      id: id,
      latitude: latitude,
      longitude: longitude,
      city: city,
      address: address,
      organisation: organisation,
      district: district,
    );
  }
}