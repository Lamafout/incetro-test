import 'package:incetro_test/features/auth/domain/entities/organisations_meta.dart';

class OrganisationsMetaModel{
  int totalCount;
  int pageCount;
  int currentPage;
  int perPage;

  OrganisationsMetaModel({required this.totalCount, required this.pageCount, required this.currentPage, required this.perPage});

  factory OrganisationsMetaModel.fromJson(Map<String, dynamic> json) {
    return OrganisationsMetaModel(
      totalCount: json['total_count'],
      pageCount: json['page_count'],
      currentPage: json['current_page'],
      perPage: json['per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total_count': totalCount,
      'page_count': pageCount,
      'current_page': currentPage,
      'per_page': perPage,
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