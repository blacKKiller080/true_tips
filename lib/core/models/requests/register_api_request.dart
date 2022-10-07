import 'package:meta/meta.dart';
import 'dart:convert';

RegisterApiRequest registerApiRequestFromJson(String str) => RegisterApiRequest.fromJson(json.decode(str));

String registerApiRequestToJson(RegisterApiRequest data) => json.encode(data.toJson());

class RegisterApiRequest {
  RegisterApiRequest({
    required this.password,
  });

  String password;

  factory RegisterApiRequest.fromJson(Map<String, dynamic> json) => RegisterApiRequest(
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
  };

  @override
  String toString() {
    return 'RegisterApiRequest{password: $password}';
  }
}
