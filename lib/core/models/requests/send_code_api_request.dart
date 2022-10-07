import 'dart:convert';

SendCodeApiRequest sendCodeApiRequestFromJson(String str) => SendCodeApiRequest.fromJson(json.decode(str));

String sendCodeApiRequestToJson(SendCodeApiRequest data) => json.encode(data.toJson());

class SendCodeApiRequest {
  SendCodeApiRequest({
    required this.uid,
    required this.code,
  });

  String uid;
  String code;

  factory SendCodeApiRequest.fromJson(Map<String, dynamic> json) => SendCodeApiRequest(
    uid: json["uid"],
    code: json["code"],
  );

  Map<String, dynamic> toJson() => {
    "uid": uid,
    "code": code,
  };

  @override
  String toString() {
    return 'SendCodeApiRequest{uid: $uid, code: $code}';
  }
}
