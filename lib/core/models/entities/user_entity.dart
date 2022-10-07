import 'dart:convert';

import 'package:true_tips_mobile/core/constants/system.dart';

UserEntity userEntityFromJson(String str) =>
    UserEntity.fromJson(json.decode(str));

String userEntityToJson(UserEntity data) => json.encode(data.toJson());

class UserEntity {
  UserEntity({
    required this.firstName,
    required this.lastName,
    required this.workPlace,
    required this.city,
    this.birthDate,
    required this.comment,
    required this.uid,
    required this.balance,
  });

  String firstName;
  String lastName;
  String workPlace;
  String city;
  dynamic birthDate;
  String comment;
  String uid;
  String balance;

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
        firstName: json["first_name"],
        lastName: json["last_name"],
        workPlace: json["work_place"],
        city: json["city"],
        birthDate: json["birth_date"],
        comment: json["comment"],
        uid: json["uid"],
        balance: json["balance"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "work_place": workPlace,
        "city": city,
        "birth_date": birthDate,
        "comment": comment,
        "uid": uid,
        "balance": balance,
      };

  @override
  String toString() {
    return 'UserEntity{firstName: $firstName, lastName: $lastName, workPlace: $workPlace, city: $city, birthDate: $birthDate, comment: $comment, uid: $uid, balance: $balance}';
  }

  String _getFullName() {
    return "$firstName $lastName";
  }

  String getFullName() {
    return this._getFullName().trim().isEmpty
        ? "Имя не указано"
        : _getFullName();
  }

  String getWorkPlace() {
    return this.workPlace.isEmpty ? 'Организация не указана' : this.workPlace;
  }

  String getQR() {
    return System.MAIN_URL + "?uuid=" + this.uid;
  }

  double getBalance() {
    return double.parse(this.balance.isEmpty ? "0" : this.balance);
  }
}
