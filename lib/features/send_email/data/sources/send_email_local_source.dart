import 'package:incetro_test/res/sources/local_source.dart';

class SendEmailLocalSource extends LocalSource{
  SendEmailLocalSource(super.sharedPreferences);

  saveEmail(String email) {
    sharedPreferences.setString('email', email);
  }
}