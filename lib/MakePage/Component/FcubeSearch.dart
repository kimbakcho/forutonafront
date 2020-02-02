// To parse this JSON data, do
//
//     final fcubeSearch = fcubeSearchFromJson(jsonString);

import 'dart:convert';

class FcubeSearch {
  String uid;
  int limit;
  int offset;
  String orderby;
  bool isdesc;

  FcubeSearch({
    this.uid,
    this.limit,
    this.offset,
    this.orderby,
    this.isdesc,
  });

  FcubeSearch copyWith({
    String uid,
    int limit,
    int offset,
    String orderby,
    bool isdesc,
  }) =>
      FcubeSearch(
        uid: uid ?? this.uid,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        orderby: orderby ?? this.orderby,
        isdesc: isdesc ?? this.isdesc,
      );

  factory FcubeSearch.fromRawJson(String str) =>
      FcubeSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeSearch.fromJson(Map<String, dynamic> json) => FcubeSearch(
        uid: json["uid"] == null ? null : json["uid"],
        limit: json["limit"] == null ? null : json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        orderby: json["orderby"] == null ? null : json["orderby"],
        isdesc: json["isdesc"] == null ? null : json["isdesc"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid == null ? null : uid,
        "limit": limit == null ? null : limit,
        "offset": offset == null ? null : offset,
        "orderby": orderby == null ? null : orderby,
        "isdesc": isdesc == null ? null : isdesc,
      };
}
