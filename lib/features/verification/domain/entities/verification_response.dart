class VerificationResponse {
  final String email;
  final String accessToken;
  final String refreshToken;
  VerificationResponse({required this.email, required this.accessToken, required this.refreshToken});
}