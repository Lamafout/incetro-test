class UserModel{
  String email;
  String accessToken;
  String refreshToken;
  UserModel({required this.accessToken, required this.refreshToken, required this.email});

  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      accessToken: json['access_token'],
      refreshToken: json['refresh_token'],
      email: json['email']
    );
  }
  Map<String, dynamic> toJson(){
    return {
      'access_token': accessToken,
      'refresh_token': refreshToken,
      'email': email
    };
  }
}