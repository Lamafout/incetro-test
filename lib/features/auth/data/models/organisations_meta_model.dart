import 'package:incetro_test/features/auth/domain/entities/organisations_meta.dart';

class OrganisationsMetaModel{
  int totalCount;
  int pageCount;
  int currentPage;
  int perPage;

  OrganisationsMetaModel({required this.totalCount, required this.pageCount, required this.currentPage, required this.perPage});

  factory OrganisationsMetaModel.fromJson(Map<String, dynamic> json) {
    return OrganisationsMetaModel(
      totalCount: json['totalCount'],
      pageCount: json['pageCount'],
      currentPage: json['currentPage'],
      perPage: json['perPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalCount': totalCount,
      'pageCount': pageCount,
      'currentPage': currentPage,
      'perPage': perPage,
    };
  }

  OrganisationsMeta toEntity() {
    return OrganisationsMeta(
      totalCount: totalCount,
      pageCount: pageCount,
      currentPage: currentPage,
      perPage: perPage,
    );
  }
}