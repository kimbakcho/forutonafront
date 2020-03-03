// To parse this JSON data, do
//
//     final fcubetag = fcubetagFromJson(jsonString);

import 'dart:convert';

class Fcubetag {
  String cubeuuid;
  String tagitem;

  Fcubetag({
    this.cubeuuid,
    this.tagitem,
  });

  Fcubetag copyWith({
    String cubeuuid,
    String tagitem,
  }) =>
      Fcubetag(
        cubeuuid: cubeuuid ?? this.cubeuuid,
        tagitem: tagitem ?? this.tagitem,
      );

  factory Fcubetag.fromRawJson(String str) =>
      Fcubetag.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Fcubetag.fromJson(Map<String, dynamic> json) => Fcubetag(
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        tagitem: json["tagitem"] == null ? null : json["tagitem"],
      );

  Map<String, dynamic> toJson() => {
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "tagitem": tagitem == null ? null : tagitem,
      };

  static List<String> recomandtegs() {
    List<String> items = List<String>();
    items.add("방송맛집");
    items.add("무료공연");
    items.add("데이터장소");
    items.add("축제");
    items.add("연예인사인회");

    return items;
  }
}
