import 'dart:convert';

class HomeMainTop {
  String uuid;
  String imageUrl;
  DateTime publishDate;
  bool isEvent;
  String title;
  int index;

  HomeMainTop({
    this.uuid,
    this.imageUrl,
    this.publishDate,
    this.isEvent,
    this.title,
    this.index,
  });

  HomeMainTop copyWith({
    String uuid,
    String imageUrl,
    DateTime publishDate,
    bool isEvent,
    String title,
    int index,
  }) =>
      HomeMainTop(
        uuid: uuid ?? this.uuid,
        imageUrl: imageUrl ?? this.imageUrl,
        publishDate: publishDate ?? this.publishDate,
        isEvent: isEvent ?? this.isEvent,
        title: title ?? this.title,
        index: index ?? this.index,
      );

  factory HomeMainTop.fromRawJson(String str) =>
      HomeMainTop.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory HomeMainTop.fromJson(Map<String, dynamic> json) => HomeMainTop(
        uuid: json["uuid"] == null ? null : json["uuid"],
        imageUrl: json["imageUrl"] == null ? null : json["imageUrl"],
        publishDate: json["publishDate"] == null
            ? null
            : DateTime.parse(json["publishDate"]),
        isEvent: json["isEvent"] == null ? null : json["isEvent"],
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
      );

  Map<String, dynamic> toJson() => {
        "uuid": uuid == null ? null : uuid,
        "imageUrl": imageUrl == null ? null : imageUrl,
        "publishDate":
            publishDate == null ? null : publishDate.toIso8601String(),
        "isEvent": isEvent == null ? null : isEvent,
        "title": title == null ? null : title,
        "index": index == null ? null : index,
      };
  static List<HomeMainTop> getMainTopItems() {
    List<HomeMainTop> items = List<HomeMainTop>();
    items.add(
      HomeMainTop(
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/control-785555_1920.png",
          index: 0,
          isEvent: true,
          publishDate: DateTime(2020, 3, 3),
          title: "이곳에는 정말로 보물이 숨겨져 있답니다! 우리가 직접 숨겨놓았거든요."),
    );
    items.add(
      HomeMainTop(
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/adventure-1850912_640.png",
          index: 1,
          isEvent: false,
          publishDate: DateTime(2020, 3, 3),
          title: "이곳에는 정말로 보물이 숨겨져 있답니다! 우리가 직접 숨겨놓았거든요."),
    );
    items.add(
      HomeMainTop(
          imageUrl:
              "https://storage.googleapis.com/publicforutona/cuberelationimage/treasure-map-1850653_1920.png",
          index: 2,
          isEvent: false,
          publishDate: DateTime(2020, 3, 3),
          title: "이곳에는 정말로 보물이 숨겨져 있답니다! 우리가 직접 숨겨놓았거든요."),
    );
    return items;
  }
}
