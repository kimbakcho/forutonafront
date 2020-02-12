import 'dart:convert';

class PlayerjoincubeSearch {
  String playerUid;
  String orderBy;
  double playerLatitude;
  double playerLongitude;
  bool isDesc;
  int limit;
  int offset;

  PlayerjoincubeSearch({
    this.playerUid,
    this.orderBy,
    this.playerLatitude,
    this.playerLongitude,
    this.isDesc,
    this.limit,
    this.offset,
  });

  PlayerjoincubeSearch copyWith({
    String playerUid,
    String orderBy,
    double playerLatitude,
    double playerLongitude,
    bool isDesc,
    int limit,
    int offset,
  }) =>
      PlayerjoincubeSearch(
        playerUid: playerUid ?? this.playerUid,
        orderBy: orderBy ?? this.orderBy,
        playerLatitude: playerLatitude ?? this.playerLatitude,
        playerLongitude: playerLongitude ?? this.playerLongitude,
        isDesc: isDesc ?? this.isDesc,
        limit: limit ?? this.limit,
        offset: offset ?? this.offset,
      );

  factory PlayerjoincubeSearch.fromRawJson(String str) =>
      PlayerjoincubeSearch.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PlayerjoincubeSearch.fromJson(Map<String, dynamic> json) =>
      PlayerjoincubeSearch(
        playerUid: json["playerUid"] == null ? null : json["playerUid"],
        orderBy: json["orderBy"] == null ? null : json["orderBy"],
        playerLatitude: json["PlayerLatitude"] == null
            ? null
            : json["PlayerLatitude"].toDouble(),
        playerLongitude: json["PlayerLongitude"] == null
            ? null
            : json["PlayerLongitude"].toDouble(),
        isDesc: json["isDesc"] == null ? null : json["isDesc"],
        limit: json["limit"] == null ? null : json["limit"],
        offset: json["offset"] == null ? null : json["offset"],
      );

  Map<String, dynamic> toJson() => {
        "playerUid": playerUid == null ? null : playerUid,
        "orderBy": orderBy == null ? null : orderBy,
        "PlayerLatitude": playerLatitude == null ? null : playerLatitude,
        "PlayerLongitude": playerLongitude == null ? null : playerLongitude,
        "isDesc": isDesc == null ? null : isDesc,
        "limit": limit == null ? null : limit,
        "offset": offset == null ? null : offset,
      };
}
