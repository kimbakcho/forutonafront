// To parse this JSON data, do
//
//     final fcubeDescription = fcubeDescriptionFromJson(jsonString);

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Preference.dart';

class FcubeDescription {
  List<Desimage> desimages;
  String text;
  DateTime writetime;
  bool havemodify;
  String youtubeVideoid;
  List<String> tags;

  FcubeDescription(
      {this.desimages,
      this.text,
      this.writetime,
      this.havemodify,
      this.youtubeVideoid,
      this.tags});

  FcubeDescription copyWith(
          {List<Desimage> desimages,
          String text,
          DateTime writetime,
          bool havemodify,
          String youtubeVideoid,
          List<String> tags}) =>
      FcubeDescription(
        desimages: desimages ?? this.desimages,
        text: text ?? this.text,
        writetime: writetime ?? this.writetime,
        havemodify: havemodify ?? this.havemodify,
        youtubeVideoid: youtubeVideoid ?? this.youtubeVideoid,
        tags: tags ?? this.tags,
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
        writetime: json["writetime"] == null
            ? null
            : DateTime.parse(json["writetime"]),
        havemodify: json["havemodify"] == null ? null : json["havemodify"],
        youtubeVideoid:
            json["youtubeVideoid"] == null ? null : json["youtubeVideoid"],
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "desimages": desimages == null
            ? null
            : List<dynamic>.from(desimages.map((x) => x.toJson())),
        "text": text == null ? null : text,
        "writetime": writetime == null ? null : writetime.toIso8601String(),
        "havemodify": havemodify == null ? null : havemodify,
        "youtubeVideoid": youtubeVideoid == null ? null : youtubeVideoid,
        "tags": tags == null ? null : List<dynamic>.from(tags.map((x) => x)),
      };
  static Future<String> cuberelationimageupload(List<int> image) async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    IdTokenResult token = await user.getIdToken(refresh: true);
    var uploadurl = Preference.httpurlbase(
        Preference.baseBackEndUrl, '/api/v1/Fcube/cuberelationimageupload');
    var formData = FormData.fromMap({
      "CubeRelationImage":
          MultipartFile.fromBytes(image, filename: "cubeiamge.png"),
    });
    Dio dio = new Dio();
    var response = await dio.postUri(uploadurl,
        data: formData,
        options: Options(headers: {
          HttpHeaders.authorizationHeader: "Bearer " + token.token
        }));
    return response.data;
  }
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
