import 'dart:convert';

UpdatePasswordApiRequest updatePasswordApiRequestFromJson(String str) =>
    UpdatePasswordApiRequest.fromJson(json.decode(str));

String updatePasswordApiRequestToJson(UpdatePasswordApiRequest data) =>
    json.encode(data.toJson());

class UpdatePasswordApiRequest {
  UpdatePasswordApiRequest({
    required this.password,
    required this.oldPassword,
  });

  String password;
  String oldPassword;

  factory UpdatePasswordApiRequest.fromJson(Map<String, dynamic> json) =>
      UpdatePasswordApiRequest(
        password: json["password"],
        oldPassword: json["old_password"],
      );

  Map<String, dynamic> toJson() => {
        "password": password,
        "old_password": oldPassword,
      };
}
