import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/Preference.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:injectable/injectable.dart';

abstract class MapMakerDescriptorContainer {
  Map<MapMakerDescriptorType, BitmapDescriptor>? container;

  getBitmapDescriptor(MapMakerDescriptorType key);

  init();
}

enum MapMakerDescriptorType {
  IssueBallIconUnSelectNormal,IssueBallIconSelectNormal,UserAvatarIcon,IssueBallIconUnSelectSmall,IssueBallIconSelectSmall
}

@LazySingleton(as: MapMakerDescriptorContainer)
class MapMakerDescriptorContainerImpl implements MapMakerDescriptorContainer {
  @override
  Map<MapMakerDescriptorType, BitmapDescriptor>? container;

  final MapBitmapDescriptorUseCaseInputPort
      _mapBitmapDescriptorUseCaseInputPort;
  final FireBaseAuthBaseAdapter _fireBaseAuthBaseAdapter;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  MapMakerDescriptorContainerImpl(
      {required
          MapBitmapDescriptorUseCaseInputPort
              mapBitmapDescriptorUseCaseInputPort,
      required
          FireBaseAuthBaseAdapter fireBaseAuthBaseAdapter,
      required
          SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _mapBitmapDescriptorUseCaseInputPort =
            mapBitmapDescriptorUseCaseInputPort,
        _fireBaseAuthBaseAdapter = fireBaseAuthBaseAdapter,
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort {
    container = Map<MapMakerDescriptorType, BitmapDescriptor>();
  }

  init() async {
    var issueBallIconUnSelectNormal =
        await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
            "assets/MarkesImages/issueballicon.png", Size(140, 140));
    container!.putIfAbsent(MapMakerDescriptorType.IssueBallIconUnSelectNormal, () => issueBallIconUnSelectNormal);

    var issueBallIconUnSelectSmall =
    await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
        "assets/MarkesImages/issueballicon.png", Size(90, 90));
    container!.putIfAbsent(MapMakerDescriptorType.IssueBallIconUnSelectSmall, () => issueBallIconUnSelectSmall);

    var issueBallIconSelectNormal =
    await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
        "assets/MarkesImages/issueselectballmaker.png", Size(140,107));
    container!.putIfAbsent(MapMakerDescriptorType.IssueBallIconSelectNormal, () => issueBallIconSelectNormal);

    var issueBallIconSelectSmall =
    await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
        "assets/MarkesImages/issueselectballmaker.png", Size(140,107));
    container!.putIfAbsent(MapMakerDescriptorType.IssueBallIconSelectSmall, () => issueBallIconSelectSmall);



    BitmapDescriptor userAvatarIcon =
    await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
        "assets/MainImage/empty_user.png", Size(70, 70));
    container![MapMakerDescriptorType.UserAvatarIcon] = userAvatarIcon ;
    container!.update(MapMakerDescriptorType.UserAvatarIcon, (value) => userAvatarIcon);
    _signInUserInfoUseCaseInputPort.fUserInfoStream!.listen((event) async {
      await mapPutUserAvatarIcon();
    });
  }

  Future mapPutUserAvatarIcon() async {
    if (await _fireBaseAuthBaseAdapter.isLogin()) {
      FUserInfoResDto userInfo =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!;
      if(userInfo.profilePictureUrl != null && userInfo.profilePictureUrl!.isNotEmpty){
        BitmapDescriptor userAvatarIcon =
        await _mapBitmapDescriptorUseCaseInputPort
            .urlPathToAvatarBitmapDescriptor(userInfo.profilePictureUrl!);
        container![MapMakerDescriptorType.UserAvatarIcon] = userAvatarIcon ;
        container!.update(MapMakerDescriptorType.UserAvatarIcon, (value) => userAvatarIcon);
      }else {
        BitmapDescriptor userAvatarIcon =
        await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
            "assets/MainImage/empty_user.png", Size(70, 70));
        container![MapMakerDescriptorType.UserAvatarIcon] = userAvatarIcon ;
        container!.update(MapMakerDescriptorType.UserAvatarIcon, (value) => userAvatarIcon);
      }
    }else {
      BitmapDescriptor noneAvatarIcon =
      await _mapBitmapDescriptorUseCaseInputPort.assertFileToBitmapDescriptor(
          "assets/MainImage/empty_user.png", Size(70, 70));
      container![MapMakerDescriptorType.UserAvatarIcon] = noneAvatarIcon ;
      container!.update(MapMakerDescriptorType.UserAvatarIcon, (value) => noneAvatarIcon);
    }
  }

  getBitmapDescriptor(MapMakerDescriptorType key) {
    if (!container!.containsKey(key)) {
      throw Exception("don't have BitmapDescriptor in container");
    }
    return container![key];
  }
}
