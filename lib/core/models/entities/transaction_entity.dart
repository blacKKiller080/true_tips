import 'package:intl/intl.dart';

class TransactionEntity {
  TransactionEntity({
    required this.user,
    required this.amount,
    required this.rating,
    required this.comment,
    required this.state,
    required this.created,
  });

  int user;
  String amount;
  int rating;
  String comment;
  String state;
  String created;

  static fromJson(Map<String, dynamic> json) => TransactionEntity(
        user: json["user"],
        amount: json["amount"],
        rating: json["rating"],
        comment: json["comment"],
        state: json["state"],
        created: json["created"],
      );

  Map<String, dynamic> toJson() => {
        "user": user,
        "amount": amount,
        "rating": rating,
        "comment": comment,
        "state": state,
        "created": created,
      };

  @override
  String toString() {
    return 'TransactionEntity{user: $user, amount: $amount, rating: $rating, comment: $comment, state: $state, created: $created}';
  }

  String getDate() {
    this.created = this.created.replaceFirst(":S", "");
    var date = DateFormat("dd.MM.yyyy hh:mm").parse(this.created);
    return "${date.year}-${_getValidDateElement(date.month)}-${_getValidDateElement(date.day)} ${this._getValidDateElement(date.hour)}:${this._getValidDateElement(date.minute)}";
  }

  String _getValidDateElement(int date) {
    return date > 9 ? "$date" : "0$date";
  }

  String getComment() {
    return comment.trim().isEmpty ? "Нет комментария..." : comment;
  }
}
