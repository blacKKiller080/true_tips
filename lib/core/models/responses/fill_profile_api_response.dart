// To parse this JSON data, do
//
//     final fillProfileApiResponse = fillProfileApiResponseFromJson(jsonString);

import 'dart:convert';

FillProfileApiResponse fillProfileApiResponseFromJson(String str) => FillProfileApiResponse.fromJson(json.decode(str));

String fillProfileApiResponseToJson(FillProfileApiResponse data) => json.encode(data.toJson());

class FillProfileApiResponse {
  FillProfileApiResponse({
    this.firstName,
    this.lastName,
    this.workPlace,
    this.city,
    this.birthDate,
    this.comment,
  });

  String ? firstName;
  String ? lastName;
  String ? workPlace;
  String ? city;
  DateTime ? birthDate;
  String ? comment;

  factory FillProfileApiResponse.fromJson(Map<String, dynamic> json) => FillProfileApiResponse(
    firstName: json["first_name"],
    lastName: json["last_name"],
    workPlace: json["work_place"],
    city: json["city"],
    birthDate: DateTime.parse(json["birth_date"]),
    comment: json["comment"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "work_place": workPlace,
    "city": city,
    "birth_date": "${birthDate!.year.toString().padLeft(4, '0')}-${birthDate!.month.toString().padLeft(2, '0')}-${birthDate!.day.toString().padLeft(2, '0')}",
    "comment": comment,
  };
}
