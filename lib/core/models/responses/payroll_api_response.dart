
import 'package:meta/meta.dart';
import 'dart:convert';

PayrollApiResponse payrollApiResponseFromJson(String str) => PayrollApiResponse.fromJson(json.decode(str));

String payrollApiResponseToJson(PayrollApiResponse data) => json.encode(data.toJson());

class PayrollApiResponse {
  PayrollApiResponse({
    required this.redirectUrl,
  });

  String redirectUrl;

  factory PayrollApiResponse.fromJson(Map<String, dynamic> json) => PayrollApiResponse(
    redirectUrl: json["redirect_url"],
  );

  Map<String, dynamic> toJson() => {
    "redirect_url": redirectUrl,
  };
}