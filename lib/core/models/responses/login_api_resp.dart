import 'dart:convert';

LoginApiResponse loginApiResponseFromJson(String str) =>
    LoginApiResponse.fromJson(json.decode(str));

String loginApiResponseToJson(LoginApiResponse data) =>
    json.encode(data.toJson());

class LoginApiResponse {
  LoginApiResponse({
    required this.token,
  });

  String token;

  factory LoginApiResponse.fromJson(Map<String, dynamic> json) =>
      LoginApiResponse(
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
      };

  @override
  String toString() {
    return 'LoginApiResponse{token: $token}';
  }
}
