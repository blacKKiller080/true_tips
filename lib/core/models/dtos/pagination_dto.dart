import 'dart:convert';

String paginationDtoToJson(PaginationDto data) => json.encode(data.toJson());

class PaginationDto {
  PaginationDto({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<dynamic> results;

  factory PaginationDto.fromJson(
          Map<String, dynamic> json, dynamic fromJson) =>
      PaginationDto(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<dynamic>.from(json["results"].map((x) => fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'PaginationDto{count: $count, next: $next, previous: $previous, results: $results}';
  }
}
