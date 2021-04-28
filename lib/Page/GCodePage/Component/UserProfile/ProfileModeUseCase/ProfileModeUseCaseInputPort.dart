import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/Dto/UserProfileComponentInfoDto.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/UserProfileMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:injectable/injectable.dart';

abstract class ProfileModeUseCaseInputPort {
  Future<UserProfileComponentInfoDto> getUserInfo();
}

class ProfileModeUseCaseForMe implements ProfileModeUseCaseInputPort {

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  ProfileModeUseCaseForMe(this._signInUserInfoUseCaseInputPort);

  @override
  Future<UserProfileComponentInfoDto> getUserInfo() async {
     var fUserInfoResDto = await _signInUserInfoUseCaseInputPort.saveSignInInfoInMemoryFromAPiServer();
     UserProfileComponentInfoDto userProfileComponentInfoDto = UserProfileComponentInfoDto();
     userProfileComponentInfoDto.profileImageUrl = fUserInfoResDto!.profilePictureUrl;
     userProfileComponentInfoDto.countryCode = fUserInfoResDto.isoCode;
     userProfileComponentInfoDto.userNickName = fUserInfoResDto.nickName;
     userProfileComponentInfoDto.followerCount = fUserInfoResDto.followerCount;
     userProfileComponentInfoDto.followingCount = fUserInfoResDto.followingCount;
     userProfileComponentInfoDto.selfIntroduce = fUserInfoResDto.selfIntroduction;
     userProfileComponentInfoDto.uLevel = fUserInfoResDto.userLevel!.toInt();
     userProfileComponentInfoDto.backgroundUrl = fUserInfoResDto.backGroundImageUrl;
     userProfileComponentInfoDto.uid = fUserInfoResDto.uid;
     return userProfileComponentInfoDto;
  }
}

class ProfileModeUseCaseForOtherUser implements ProfileModeUseCaseInputPort {

  final UserInfoUseCaseInputPort _userInfoUseCaseInputPort;

  final String userUid;

  ProfileModeUseCaseForOtherUser(this._userInfoUseCaseInputPort,this.userUid);

  @override
  Future<UserProfileComponentInfoDto>  getUserInfo() async {
    FUserInfoSimpleResDto fUserInfoSimpleResDto = await _userInfoUseCaseInputPort.getFUserInfoSimple(userUid);
    UserProfileComponentInfoDto userProfileComponentInfoDto = UserProfileComponentInfoDto();
    userProfileComponentInfoDto.profileImageUrl = fUserInfoSimpleResDto.profilePictureUrl;
    userProfileComponentInfoDto.countryCode = fUserInfoSimpleResDto.isoCode;
    userProfileComponentInfoDto.userNickName = fUserInfoSimpleResDto.nickName;
    userProfileComponentInfoDto.followerCount = fUserInfoSimpleResDto.followerCount;
    userProfileComponentInfoDto.followingCount = fUserInfoSimpleResDto.followingCount;
    userProfileComponentInfoDto.selfIntroduce = fUserInfoSimpleResDto.selfIntroduction;
    userProfileComponentInfoDto.uLevel = fUserInfoSimpleResDto.userLevel!.toInt();
    userProfileComponentInfoDto.backgroundUrl = fUserInfoSimpleResDto.backGroundImageUrl;
    userProfileComponentInfoDto.uid = fUserInfoSimpleResDto.uid;
    return userProfileComponentInfoDto;
  }
}

@lazySingleton
class ProfileModeUseCaseFactory {
  getInstance(UserProfileMode userProfileMode,{String? userUid}){
    switch(userProfileMode){
      case UserProfileMode.ME:
        return ProfileModeUseCaseForMe(sl());
      case UserProfileMode.OtherUser:
        return ProfileModeUseCaseForOtherUser(sl(),userUid!);
    }
  }
}