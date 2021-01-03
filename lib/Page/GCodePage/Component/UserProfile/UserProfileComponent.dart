import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/Dto/UserProfileComponentInfoDto.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/ProfileModeUseCase/ProfileModeUseCaseInputPort.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/UserProfileMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class UserProfileComponent extends StatelessWidget {
  final String userUid;

  final UserProfileMode userProfileMode;

  const UserProfileComponent({Key key, this.userUid, this.userProfileMode})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProfileComponentViewModel(sl(), userProfileMode),
      child:
          Consumer<UserProfileComponentViewModel>(builder: (_, model, child) {
        return Stack(
          children: [
            model._isLoaded
                ? Container(child: Text(model.userNickName))
                : CommonLoadingComponent()
          ],
        );
      }),
    );
  }
}

class UserProfileComponentViewModel extends ChangeNotifier {
  final ProfileModeUseCaseFactory _profileModeUseCaseFactory;

  final UserProfileMode userProfileMode;

  ProfileModeUseCaseInputPort _profileModeUseCaseInputPort;

  UserProfileComponentInfoDto _userProfileComponentInfoDto;

  bool _isLoaded = false;

  UserProfileComponentViewModel(
      this._profileModeUseCaseFactory, this.userProfileMode) {
    _profileModeUseCaseInputPort =
        _profileModeUseCaseFactory.getInstance(userProfileMode);
    _init();
  }

  _init() async {
    _userProfileComponentInfoDto =
        await _profileModeUseCaseInputPort.getUserInfo();
    _isLoaded = true;
    notifyListeners();
  }

  get userNickName {
    return _userProfileComponentInfoDto.userNickName;
  }
}
