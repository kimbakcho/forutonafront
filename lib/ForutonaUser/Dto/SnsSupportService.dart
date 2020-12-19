import 'package:json_annotation/json_annotation.dart';

enum SnsSupportService {
  @JsonValue("FaceBook")
  FaceBook,
  @JsonValue("Naver")
  Naver,
  @JsonValue("Kakao")
  Kakao,
  @JsonValue("Forutona")
  Forutona
}
