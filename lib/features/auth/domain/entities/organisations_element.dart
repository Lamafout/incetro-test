class OrganisationsElement {
  int id;
  String? name;
  String? photo;
  double? rate;
  List<dynamic> averageCheck;
  List<String>? cuisins;
  bool? isFavorite;
  // TODO определиться с типом данных
  dynamic distance;

  OrganisationsElement({required this.id, required this.name, required this.photo, required this.rate, required this.averageCheck, 
  required this.cuisins, required this.isFavorite, required this.distance});
}