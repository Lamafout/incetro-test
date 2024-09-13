import 'package:incetro_test/features/auth/domain/entities/organisations_element.dart';
import 'package:incetro_test/features/auth/domain/entities/organisations_meta.dart';

class Organisations{ 
  List <OrganisationsElement> data;
  OrganisationsMeta meta;

  // поле для определения источника данных: если демо, то 1, если нет, то 0
  bool? isDemo;

  Organisations({required this.data, required this.meta, this.isDemo});
}