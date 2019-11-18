class FcubeTypeObj {
  String name;
  FcubeType type;
  String picture;
  String description;

  FcubeTypeObj({this.name, this.type, this.picture, this.description});
}

class FcubeType {
  const FcubeType._(this.value);

  final int value;
  static const FcubeType messageCube = FcubeType._(0);
  static const FcubeType questCube = FcubeType._(1);
  static const FcubeType startcube = FcubeType._(2);
  static const FcubeType finishcube = FcubeType._(3);
  static const FcubeType checkincube = FcubeType._(4);
  static const FcubeType currentselectcube = FcubeType._(5);

  static const List<FcubeType> values = <FcubeType>[
    messageCube,
    questCube,
    startcube,
    finishcube,
    checkincube,
    currentselectcube
  ];

  static const List<String> _names = <String>[
    'messagecube',
    'questCube',
    'startcube',
    'finishcube',
    'checkincube',
    'currentselectcube'
  ];

  static FcubeType fromJson(value) {
    return values[_names.indexOf(value)];
  }

  static String toJson(type) {
    return _names[type.value];
  }

  @override
  String toString() => _names[value];
}
