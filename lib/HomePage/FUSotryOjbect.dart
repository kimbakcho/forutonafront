// To parse this JSON data, do
//
//     final FUSotryOjbect = FUSotryOjbectFromJson(jsonString);

import 'dart:convert';

class FUSotryOjbect {
  String uuid;
  String imageUrl;
  DateTime publishDate;
  String category;
  String title;
  int index;

  FUSotryOjbect({
    this.uuid,
    this.imageUrl,
    this.publishDate,
    this.category,
    this.title,
    this.index,
  });

  FUSotryOjbect copyWith({
    String uuid,
    String imageUrl,
    DateTime publishDate,
    String category,
    String title,
    int index,
  }) =>
      FUSotryOjbect(
        uuid: uuid ?? this.uuid,
        imageUrl: imageUrl ?? this.imageUrl,
        publishDate: publishDate ?? this.publishDate,
        category: category ?? this.category,
        title: title ?? this.title,
        index: index ?? this.index,
      );

  factory FUSotryOjbect.fromRawJson(String str) =>
      FUSotryOjbect.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FUSotryOjbect.fromJson(Map<String, dynamic> json) => FUSotryOjbect(
        uuid: json["uuid"] == null ? null : json["uuid"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        publishDate: json["publishDate"] == null
            ? null
            : DateTime.parse(json["publishDate"]),
        category: json["category"] == null ? null : json["category"],
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid == null ? null : uuid,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "publishDate":
            publishDate == null ? null : publishDate.toIso8601String(),
        "category": category == null ? null : category,
        "title": title == null ? null : title,
        "index": index == null ? null : index,
      };
  static List<FUSotryOjbect> getFUSotryOjbectItems() {
    List<FUSotryOjbect> listitem = List<FUSotryOjbect>();
    listitem.add(
      FUSotryOjbect(
          category: "포루투나TV",
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/form4.png",
          index: 0,
          publishDate: DateTime(2020, 3, 20),
          title: "아직 알려지지 않은 아름다운 곳을 이슈볼로 남기기 위해 여정을 떠나봤는데..."),
    );
    listitem.add(
      FUSotryOjbect(
          category: "기부 활동",
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/form5.png",
          index: 0,
          publishDate: DateTime(2020, 3, 19),
          title: "U포인트 모금을 통해 후원된 금액을 전달하였습니다."),
    );
    listitem.add(
      FUSotryOjbect(
          category: "포루투나TV",
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/form6.png",
          index: 0,
          publishDate: DateTime(2020, 3, 18),
          title: "연인들이 데이트하기 좋은 곳을 소개해드립니다!"),
    );
    return listitem;
  }
}
