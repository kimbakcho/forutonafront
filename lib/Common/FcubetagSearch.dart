// To parse this JSON data, do
//
//     final fcubetagSearch = fcubetagSearchFromJson(jsonString);

import 'dart:convert';

class FcubetagSearch {
  String tagitem;
  int limit;
  int offset;

  FcubetagSearch({
    this.tagitem,
    this.limit,
    this.offset,
  });

  FcubetagSearch copyWith({
    String tagitem,
    int limit,
    int offset,
  }) =>
      FcubetagSearch(
        tagitem: tagitem ?? this.tagitem,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
      );

  factory FcubetagSearch.fromRawJson(String str) =>
      FcubetagSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubetagSearch.fromJson(Map<String, dynamic> json) => FcubetagSearch(
        tagitem: json["tagitem"] == null ? null : json["tagitem"],
        limit: json["limit"] == null ? null : json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "tagitem": tagitem == null ? null : tagitem,
        "limit": limit == null ? null : limit,
        "offset": offset == null ? null : offset,
      };
}
