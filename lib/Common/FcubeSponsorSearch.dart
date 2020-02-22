// To parse this JSON data, do
//
//     final fcubeSponsorSearch = fcubeSponsorSearchFromJson(jsonString);

import 'dart:convert';

class FcubeSponsorSearch {
  int limit;
  int offset;
  String cubeuuid;
  bool isdesc;
  String orderby;

  FcubeSponsorSearch({
    this.limit,
    this.offset,
    this.cubeuuid,
    this.isdesc,
    this.orderby,
  });

  FcubeSponsorSearch copyWith({
    int limit,
    int offset,
    String cubeuuid,
    bool isdesc,
    String orderby,
  }) =>
      FcubeSponsorSearch(
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
        cubeuuid: cubeuuid ?? this.cubeuuid,
        isdesc: isdesc ?? this.isdesc,
        orderby: orderby ?? this.orderby,
      );

  factory FcubeSponsorSearch.fromRawJson(String str) =>
      FcubeSponsorSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeSponsorSearch.fromJson(Map<String, dynamic> json) =>
      FcubeSponsorSearch(
        limit: json["limit"] == null ? null : json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        isdesc: json["isdesc"] == null ? null : json["isdesc"],
        orderby: json["orderby"] == null ? null : json["orderby"],
      );

  Map<String, dynamic> toJson() => {
        "limit": limit == null ? null : limit,
        "offset": offset == null ? null : offset,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "isdesc": isdesc == null ? null : isdesc,
        "orderby": orderby == null ? null : orderby,
      };
}
