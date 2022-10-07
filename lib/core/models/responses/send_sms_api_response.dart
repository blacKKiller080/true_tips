import 'package:meta/meta.dart';
import 'dart:convert';

SendSmsApiResponse sendSmsApiResponseFromJson(String str) => SendSmsApiResponse.fromJson(json.decode(str));

String sendSmsApiResponseToJson(SendSmsApiResponse data) => json.encode(data.toJson());

class SendSmsApiResponse {
  SendSmsApiResponse({
    required this.phone,
    required this.uid,
  });

  String phone;
  String uid;

  factory SendSmsApiResponse.fromJson(Map<String, dynamic> json) => SendSmsApiResponse(
    phone: json["phone"],
    uid: json["uid"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "uid": uid,
  };

  @override
  String toString() {
    return 'SendSmsApiResponse{phone: $phone, uid: $uid}';
  }
}
