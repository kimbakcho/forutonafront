// To parse this JSON data, do
//
//     final fcubeDescription = fcubeDescriptionFromJson(jsonString);

import 'dart:convert';

class FcubeDescription {
  List<Desimage> desimages;
  String text;

  FcubeDescription({
    this.desimages,
    this.text,
  });

  FcubeDescription copyWith({
    List<Desimage> desimages,
    String text,
  }) =>
      FcubeDescription(
        desimages: desimages ?? this.desimages,
        text: text ?? this.text,
      );

  factory FcubeDescription.fromRawJson(String str) =>
      FcubeDescription.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FcubeDescription.fromJson(Map<String, dynamic> json) =>
      FcubeDescription(
        desimages: json["desimages"] == null
            ? null
            : List<Desimage>.from(
                json["desimages"].map((x) => Desimage.fromJson(x))),
        text: json["text"] == null ? null : json["text"],
      );

  Map<String, dynamic> toJson() => {
        "desimages": desimages == null
            ? null
            : List<dynamic>.from(desimages.map((x) => x.toJson())),
        "text": text == null ? null : text,
      };
}

class Desimage {
  int index;
  String src;

  Desimage({
    this.index,
    this.src,
  });

  Desimage copyWith({
    int index,
    String src,
  }) =>
      Desimage(
        index: index ?? this.index,
        src: src ?? this.src,
      );

  factory Desimage.fromRawJson(String str) =>
      Desimage.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Desimage.fromJson(Map<String, dynamic> json) => Desimage(
        index: json["index"] == null ? null : json["index"],
        src: json["src"] == null ? null : json["src"],
      );

  Map<String, dynamic> toJson() => {
        "index": index == null ? null : index,
        "src": src == null ? null : src,
      };
}
