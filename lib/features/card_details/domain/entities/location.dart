class Location{
  final int id;
  final double? latitude;
  final double? longitude;
  final String? city;
  final String? address;
  final int organisation;
  final int? district;

  Location({required this.id, required this.latitude, required this.longitude, 
  required this.city, required this.address, required this.organisation, required this.district});
}