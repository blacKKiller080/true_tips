import 'package:meta/meta.dart';
import 'dart:convert';

SetPasswordApiResponse registerApiResponseFromJson(String str) => SetPasswordApiResponse.fromJson(json.decode(str));

String registerApiResponseToJson(SetPasswordApiResponse data) => json.encode(data.toJson());

class SetPasswordApiResponse {
  SetPasswordApiResponse({
    required this.password,
  });

  String password;

  factory SetPasswordApiResponse.fromJson(Map<String, dynamic> json) => SetPasswordApiResponse(
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
  };
}
