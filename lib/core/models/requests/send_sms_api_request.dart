import 'dart:convert';

SendSmsApiRequest sendSmsApiRequestFromJson(String str) => SendSmsApiRequest.fromJson(json.decode(str));

String sendSmsApiRequestToJson(SendSmsApiRequest data) => json.encode(data.toJson());

class SendSmsApiRequest {
  SendSmsApiRequest({
    required this.phone,
  });

  String phone;

  factory SendSmsApiRequest.fromJson(Map<String, dynamic> json) => SendSmsApiRequest(
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };

  @override
  String toString() {
    return 'SendSmsApiRequest{phone: $phone}';
  }
}
