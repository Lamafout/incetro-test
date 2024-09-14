import 'package:incetro_test/res/sources/local_source.dart';

class VerificationLocalSource extends LocalSource {
  VerificationLocalSource(super.sharedPreferences);

  Future<String> getEmail() async{
    return sharedPreferences.getString('email') ?? ''; 
  }
}