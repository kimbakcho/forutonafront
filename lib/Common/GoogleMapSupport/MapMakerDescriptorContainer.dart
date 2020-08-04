import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapMakerDescriptorContainer {
  Map<String, BitmapDescriptor> container;

  getBitmapDescriptor(String key);

  init();
}

class MapMakerDescriptorContainerImpl implements MapMakerDescriptorContainer {
  @override
  Map<String, BitmapDescriptor> container;

  final MapBitmapDescriptorUseCaseInputPort
      _mapBitmapDescriptorUseCaseInputPort;
  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  MapMakerDescriptorContainerImpl(
      {@required
          MapBitmapDescriptorUseCaseInputPort
              mapBitmapDescriptorUseCaseInputPort,
      FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter,
      SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _mapBitmapDescriptorUseCaseInputPort =
            mapBitmapDescriptorUseCaseInputPort,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort {
    container = Map<String, BitmapDescriptor>();
  }

  init() async {
    var bitmapDescriptor =
        await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
            "assets/MarkesImages/issueballicon.png", Size(140, 140));
    container.putIfAbsent("IssueBallIcon", () => bitmapDescriptor);

    _signInUserInfoUseCaseInputPort.fUserInfoStream.listen((event) async {
      await mapPutUserAvatarIcon();
    });
  }

  Future mapPutUserAvatarIcon() async {
    if (await _fireBaseAuthBaseAdapter.isLogin()) {
      FUserInfo userInfo =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      BitmapDescriptor userAvatarIcon =
          await _mapBitmapDescriptorUseCaseInputPort
              .urlPathToAvatarBitmapDescriptor(userInfo.profilePictureUrl);
      container.putIfAbsent("UserAvatarIcon", () => userAvatarIcon);
    }
  }

  getBitmapDescriptor(String key) {
    if (!container.containsKey(key)) {
      throw Exception("don't have BitmapDescriptor in container");
    }
    return container[key];
  }
}
