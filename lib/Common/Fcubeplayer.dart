import 'dart:convert';

Fcubeplayer fcubeplayerFromJson(String str) =>
    Fcubeplayer.fromJson(json.decode(str));

String fcubeplayerToJson(Fcubeplayer data) => json.encode(data.toJson());

class Fcubeplayer {
  int idx;
  String cubeuuid;
  String uid;
  double latitude;
  double longitude;
  int haslike;
  int hasdislike;
  int hasgiveup;
  int hasexit;

  Fcubeplayer(
      {this.idx,
      this.cubeuuid,
      this.uid,
      this.latitude,
      this.longitude,
      this.haslike,
      this.hasdislike,
      this.hasgiveup,
      this.hasexit});

  factory Fcubeplayer.fromJson(Map<String, dynamic> json) => Fcubeplayer(
        idx: json["idx"],
        cubeuuid: json["Cubeuuid"],
        uid: json["Uid"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        haslike: json["haslike"],
        hasdislike: json["hasdislike"],
        hasgiveup: json["hasgiveup"],
        hasexit: json["hasexit"],
      );

  Map<String, dynamic> toJson() => {
        "idx": idx,
        "Cubeuuid": cubeuuid,
        "Uid": uid,
        "latitude": latitude,
        "longitude": longitude,
        "haslike": haslike,
        "hasdislike": hasdislike,
        "hasgiveup": hasgiveup,
        "hasexit": hasexit,
      };
}
