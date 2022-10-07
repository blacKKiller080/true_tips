import 'package:meta/meta.dart';
import 'dart:convert';

PayrollApiRequest payrollApiRequestFromJson(String str) =>
    PayrollApiRequest.fromJson(json.decode(str));

String payrollApiRequestToJson(PayrollApiRequest data) =>
    json.encode(data.toJson());

class PayrollApiRequest {
  PayrollApiRequest({
    required this.uid,
    required this.amount,
  });

  String uid;
  String amount;

  factory PayrollApiRequest.fromJson(Map<String, dynamic> json) =>
      PayrollApiRequest(
        uid: json["uid"],
        amount: json["amount"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "amount": amount,
      };
}
