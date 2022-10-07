import 'dart:convert';

LoginApiRequest loginApiRequestFromJson(String str) => LoginApiRequest.fromJson(json.decode(str));

String loginApiRequestToJson(LoginApiRequest data) => json.encode(data.toJson());

class LoginApiRequest {
  LoginApiRequest({
    required this.phone,
    required this.password,
  });

  String phone;
  String password;

  factory LoginApiRequest.fromJson(Map<String, dynamic> json) => LoginApiRequest(
    phone: json["phone"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "password": password,
  };

  @override
  String toString() {
    return 'LoginApiRequest{phone: $phone, password: $password}';
  }
}