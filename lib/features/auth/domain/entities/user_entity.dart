class User {
  String email;
  String accessToken;
  String refreshToken;
  User({required this.accessToken, required this.refreshToken, required this.email});
}