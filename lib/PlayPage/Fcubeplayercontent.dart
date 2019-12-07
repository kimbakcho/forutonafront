import 'dart:convert';

FcubePlayerContent fcubePlayerContentFromJson(String str) =>
    FcubePlayerContent.fromJson(json.decode(str));

String fcubePlayerContentToJson(FcubePlayerContent data) =>
    json.encode(data.toJson());

class FcubePlayerContent {
  int idx;
  String cubeuuid;
  String uid;
  FcubeplayercontentType contenttype;
  String contentvalue;
  DateTime contentupdatetime;

  FcubePlayerContent({
    this.idx,
    this.cubeuuid,
    this.uid,
    this.contenttype,
    this.contentvalue,
    this.contentupdatetime,
  });

  FcubePlayerContent copyWith({
    int idx,
    String cubeuuid,
    String uid,
    FcubeplayercontentType contenttype,
    String contentvalue,
    DateTime contentupdatetime,
  }) =>
      FcubePlayerContent(
        idx: idx ?? this.idx,
        cubeuuid: cubeuuid ?? this.cubeuuid,
        uid: uid ?? this.uid,
        contenttype: contenttype ?? this.contenttype,
        contentvalue: contentvalue ?? this.contentvalue,
        contentupdatetime: contentupdatetime ?? this.contentupdatetime,
      );

  factory FcubePlayerContent.fromJson(Map<String, dynamic> json) =>
      FcubePlayerContent(
        idx: json["idx"] == null ? null : json["idx"],
        cubeuuid: json["cubeuuid"] == null ? null : json["cubeuuid"],
        uid: json["Uid"] == null ? null : json["Uid"],
        contenttype: json["contenttype"] == null
            ? null
            : FcubeplayercontentType.fromJson(json["contenttype"]),
        contentvalue:
            json["contentvalue"] == null ? null : json["contentvalue"],
        contentupdatetime: json["contentupdatetime"] == null
            ? null
            : DateTime.parse(json["contentupdatetime"]),
      );

  Map<String, dynamic> toJson() => {
        "idx": idx == null ? null : idx,
        "cubeuuid": cubeuuid == null ? null : cubeuuid,
        "uid": uid == null ? null : uid,
        "contenttype": contenttype == null
            ? null
            : FcubeplayercontentType.toJson(this.contenttype),
        "contentvalue": contentvalue == null ? null : contentvalue,
        "contentupdatetime": contentupdatetime == null
            ? null
            : contentupdatetime.toIso8601String(),
      };
}

class FcubeplayercontentType {
  const FcubeplayercontentType._(this.value);
  final int value;
  static const FcubeplayercontentType startCubeLocationCheckin =
      FcubeplayercontentType._(0);
  static const FcubeplayercontentType checkInCubeLocationCheckin =
      FcubeplayercontentType._(1);

  static const List<FcubeplayercontentType> values = <FcubeplayercontentType>[
    startCubeLocationCheckin,
    checkInCubeLocationCheckin,
  ];

  static const List<String> _names = <String>[
    'startCubeLocationCheckin',
    'checkInCubeLocationCheckin'
  ];

  static FcubeplayercontentType fromJson(value) {
    return values[_names.indexOf(value)];
  }

  static String toJson(type) {
    return _names[type.value];
  }

  @override
  String toString() => _names[value];
}
