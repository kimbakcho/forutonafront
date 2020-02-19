// To parse this JSON data, do
//
//     final fcubereplySearch = fcubereplySearchFromJson(jsonString);

import 'dart:convert';

class FcubereplySearch {
  String cubeuuid;
  int offset;
  int limit;

  FcubereplySearch({
    this.cubeuuid,
    this.offset,
    this.limit,
  });

  FcubereplySearch copyWith({
    String cubeuuid,
    int offset,
    int limit,
  }) =>
      FcubereplySearch(
        cubeuuid: cubeuuid ?? this.cubeuuid,
        offset: offset ?? this.offset,
        limit: limit ?? this.limit,
      );

  factory FcubereplySearch.fromRawJson(String str) =>
      FcubereplySearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubereplySearch.fromJson(Map<String, dynamic> json) =>
      FcubereplySearch(
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        offset: json["offset"] == null ? null : json["offset"],
        limit: json["limit"] == null ? null : json["limit"],
      );

  Map<String, dynamic> toJson() => {
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "offset": offset == null ? null : offset,
        "limit": limit == null ? null : limit,
      };
}
