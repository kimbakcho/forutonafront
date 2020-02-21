// To parse this JSON data, do
//
//     final fcubereplySearch = fcubereplySearchFromJson(jsonString);

import 'dart:convert';

class FcubereplySearch {
  String cubeuuid;
  int bgroup = 0;
  int offset;
  int limit;

  FcubereplySearch({this.cubeuuid, this.offset, this.limit, this.bgroup});

  FcubereplySearch copyWith(
          {String cubeuuid, int offset, int limit, int bgroup}) =>
      FcubereplySearch(
          cubeuuid: cubeuuid ?? this.cubeuuid,
          offset: offset ?? this.offset,
          limit: limit ?? this.limit,
          bgroup: bgroup ?? this.bgroup);

  factory FcubereplySearch.fromRawJson(String str) =>
      FcubereplySearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubereplySearch.fromJson(Map<String, dynamic> json) =>
      FcubereplySearch(
          cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
          offset: json["offset"] == null ? null : json["offset"],
          limit: json["limit"] == null ? null : json["limit"],
          bgroup: json["bgroup"] == null ? null : json["bgroup"]);

  Map<String, dynamic> toJson() => {
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "offset": offset == null ? null : offset,
        "limit": limit == null ? null : limit,
        "bgroup": bgroup == null ? null : bgroup,
      };
}
