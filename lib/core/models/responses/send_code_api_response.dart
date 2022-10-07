import 'dart:convert';

SendCodeApiResponse sendCodeApiRequestFromJson(String str) => SendCodeApiResponse.fromJson(json.decode(str));

String sendCodeApiRequestToJson(SendCodeApiResponse data) => json.encode(data.toJson());

class SendCodeApiResponse {
  SendCodeApiResponse({
    required this.token,
  });

  String token;

  factory SendCodeApiResponse.fromJson(Map<String, dynamic> json) => SendCodeApiResponse(
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "token": token,
  };
}