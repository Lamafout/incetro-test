class OrganisationsElement {
  int id;
  String name;
  String photo;
  double rate;
  List<int> averageCheck;
  List<String> cuisins;
  bool isFavorite;
  String distance;

  OrganisationsElement({required this.id, required this.name, required this.photo, required this.rate, required this.averageCheck, 
  required this.cuisins, required this.isFavorite, required this.distance});
}