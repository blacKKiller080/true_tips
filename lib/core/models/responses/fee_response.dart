import 'package:meta/meta.dart';
import 'dart:convert';

FeeResponse feeResponseFromJson(String str) =>
    FeeResponse.fromJson(json.decode(str));

String feeResponseToJson(FeeResponse data) => json.encode(data.toJson());

class FeeResponse {
  FeeResponse({
    required this.payrollFee,
    required this.payrollMinAmount,
    required this.payrollFeePercent,
  });

  int payrollFee;
  int payrollMinAmount;
  double payrollFeePercent;

  factory FeeResponse.fromJson(Map<String, dynamic> json) => FeeResponse(
        payrollFee: json["payroll_fee"],
        payrollMinAmount: json["payroll_min_amount"],
        payrollFeePercent: json["payroll_fee_percent"],
      );

  Map<String, dynamic> toJson() => {
        "payroll_fee": payrollFee,
        "payroll_min_amount": payrollMinAmount,
        "payroll_fee_percent": payrollFeePercent,
      };
}
