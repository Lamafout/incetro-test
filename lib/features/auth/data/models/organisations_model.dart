import 'package:incetro_test/features/auth/data/models/organisations_element_model.dart';
import 'package:incetro_test/features/auth/data/models/organisations_meta_model.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations.dart';

class OrganisationsModel{
  List <OrganisationsElementModel> data;
  OrganisationsMetaModel meta;

  OrganisationsModel({required this.data, required this.meta});

  factory OrganisationsModel.fromJson(Map<String, dynamic> json){
    return OrganisationsModel(
      data: List<OrganisationsElementModel>.from(json["data"].map((x) => OrganisationsElementModel.fromJson(x))),
      meta: OrganisationsMetaModel.fromJson(json["meta"]),
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "data": data.map((x) => x.toJson()).toList(),
      "meta": meta.toJson(),
    };
  }

  Organisations toEntity(){
    return Organisations(
      data: data.map((x) => x.toEntity()).toList(),
      meta: meta.toEntity(),
    );
  }

  Organisations toEntityDemo(){
    return Organisations(
      data: data.map((x) => x.toEntity()).toList(),
      meta: meta.toEntity(),
      isDemo: true,
    );
  }
}