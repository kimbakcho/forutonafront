// To parse this JSON data, do
//
//     final newsObject = newsObjectFromJson(jsonString);

import 'dart:convert';

class NewsObject {
  String uuid;
  String imageUrl;
  DateTime publishDate;
  String category;
  String title;
  int index;

  NewsObject({
    this.uuid,
    this.imageUrl,
    this.publishDate,
    this.category,
    this.title,
    this.index,
  });

  NewsObject copyWith({
    String uuid,
    String imageUrl,
    DateTime publishDate,
    String category,
    String title,
    int index,
  }) =>
      NewsObject(
        uuid: uuid ?? this.uuid,
        imageUrl: imageUrl ?? this.imageUrl,
        publishDate: publishDate ?? this.publishDate,
        category: category ?? this.category,
        title: title ?? this.title,
        index: index ?? this.index,
      );

  factory NewsObject.fromRawJson(String str) =>
      NewsObject.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory NewsObject.fromJson(Map<String, dynamic> json) => NewsObject(
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
  static List<NewsObject> getNewsObjectItems() {
    List<NewsObject> listitem = List<NewsObject>();
    listitem.add(
      NewsObject(
          category: "기능소개",
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/form.png",
          index: 0,
          publishDate: DateTime(2020, 3, 3),
          title: "이슈볼에 대한 여러분의 모든 궁금증을 해결해 드리겠습니다!"),
    );
    listitem.add(
      NewsObject(
          category: "업데이트 소식",
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/form2.png",
          index: 0,
          publishDate: DateTime(2020, 3, 3),
          title: "여러분! 드디어 퀘스트볼이 신규 출시 되었습니다!"),
    );
    listitem.add(
      NewsObject(
          category: "이달의 콘텐츠",
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/form3.png",
          index: 0,
          publishDate: DateTime(2020, 3, 3),
          title: "[서울 인디뮤직 페스티벌]이 이달의 우수 콘텐츠로 선정되었습니다!"),
    );
    return listitem;
  }
}
