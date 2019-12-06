class FcubeAuthMethodType {
  const FcubeAuthMethodType._(this.value);

  final int value;
  static const FcubeAuthMethodType auth1pickture = FcubeAuthMethodType._(0);

  static const List<FcubeAuthMethodType> values = <FcubeAuthMethodType>[
    auth1pickture,
  ];

  static const List<String> _names = <String>[
    '인증샷',
  ];

  static const List<String> _imagepaths = <String>[
    'assets/AuthMethodImages/authpick.PNG',
  ];

  static String toImagePath(type) {
    return _imagepaths[type.value];
  }

  static FcubeAuthMethodType fromJson(value) {
    return values[_names.indexOf(value)];
  }

  static FcubeAuthMethodType fromString(strvalue) {
    return values[_names.indexWhere((findvalue) {
      return strvalue == findvalue;
    })];
  }

  static String toJson(type) {
    return _names[type.value];
  }

  @override
  String toString() => _names[value];
}
