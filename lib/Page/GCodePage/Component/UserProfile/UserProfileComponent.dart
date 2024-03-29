import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/Dto/UserProfileComponentInfoDto.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/ProfileModeUseCase/ProfileModeUseCaseInputPort.dart';
import 'package:forutonafront/Page/GCodePage/Component/UserProfile/UserProfileMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'UserSelfIntroduceWidget.dart';

class UserProfileComponent extends StatelessWidget {
  final String? userUid;

  final UserProfileMode? userProfileMode;

  final UserProfileComponentViewModelController?
      userProfileComponentViewModelController;

  const UserProfileComponent(
      {Key? key,
      this.userUid,
      this.userProfileMode,
      this.userProfileComponentViewModelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProfileComponentViewModel(sl(), userProfileMode,
          userProfileComponentViewModelController:
              userProfileComponentViewModelController),
      child:
          Consumer<UserProfileComponentViewModel>(builder: (_, model, child) {
        return Container(
          child: model._isLoaded
              ? Stack(
                  alignment: Alignment.topLeft,
                  children: [
                    Container(
                        height: 247,
                        decoration: model.getBackgroundDecoration()),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          border: Border.all(color: Color(0xffE4E7E8)),
                          boxShadow: [
                            BoxShadow(
                              offset: Offset(0,4),
                              blurRadius: 16,
                              color: Color(0xff455B63).withOpacity(0.08)
                            )
                          ]
                      ),
                      margin: EdgeInsets.only(top: 214, left: 16, right: 16),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 41,
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            alignment: Alignment.center,
                            child: Text(
                              model.userNickName,
                              style: GoogleFonts.notoSans(
                                fontSize: 17,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                height: 2.588235294117647,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width,
                              alignment: Alignment.center,
                              child: Text(
                                model.countryName,
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff454f63),
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.left,
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          UserSelfIntroduceWidget(
                            userProfileMode: userProfileMode!,
                            userSelfIntroduce: model.userSelfIntroduce,
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          // Divider(
                          //   color: Color(0xffE4E7E8),
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                          //   children: [
                          //     SizedBox(
                          //       height: 64,
                          //     ),
                          //     Container(
                          //       child: Column(
                          //         children: [
                          //           Text(model.followerCount,
                          //               style: GoogleFonts.notoSans(
                          //                 fontSize: 13,
                          //                 color: const Color(0xff000000),
                          //                 fontWeight: FontWeight.w700,
                          //               )),
                          //           Text(
                          //             '팔로워',
                          //             style: GoogleFonts.notoSans(
                          //               fontSize: 12,
                          //               color: const Color(0xff5b5b5b),
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //             textAlign: TextAlign.center,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Column(
                          //         children: [
                          //           Text(model.userLevel,
                          //               style: GoogleFonts.notoSans(
                          //                 fontSize: 13,
                          //                 color: const Color(0xff000000),
                          //                 fontWeight: FontWeight.w700,
                          //               )),
                          //           Text(
                          //             'U 레벨',
                          //             style: GoogleFonts.notoSans(
                          //               fontSize: 12,
                          //               color: const Color(0xff5b5b5b),
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //             textAlign: TextAlign.center,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     Container(
                          //       child: Column(
                          //         children: [
                          //           Text(model.followingCount,
                          //               style: GoogleFonts.notoSans(
                          //                 fontSize: 13,
                          //                 color: const Color(0xff000000),
                          //                 fontWeight: FontWeight.w700,
                          //               )),
                          //           Text(
                          //             '팔로잉',
                          //             style: GoogleFonts.notoSans(
                          //               fontSize: 12,
                          //               color: const Color(0xff5b5b5b),
                          //               fontWeight: FontWeight.w500,
                          //             ),
                          //             textAlign: TextAlign.center,
                          //           )
                          //         ],
                          //       ),
                          //     ),
                          //     SizedBox(
                          //       height: 64,
                          //     )
                          //   ],
                          // ),
                          // SizedBox(
                          //   height: 16,
                          // ),
                        ],
                      ),
                    ),
                    Positioned(
                        top: 173,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child:
                              Center(child: model.getProfileImageBoxWidget()),
                        )),
                  ],
                )
              : CommonLoadingComponent(),
        );
      }),
    );
  }
}

class UserProfileComponentViewModel extends ChangeNotifier {
  final ProfileModeUseCaseFactory? _profileModeUseCaseFactory;

  final UserProfileMode? userProfileMode;

  final UserProfileComponentViewModelController?
      userProfileComponentViewModelController;

  ProfileModeUseCaseInputPort? _profileModeUseCaseInputPort;

  UserProfileComponentInfoDto? _userProfileComponentInfoDto;

  bool _isLoaded = false;

  CodeCountry codeCountry = CodeCountry();

  UserProfileComponentViewModel(
      this._profileModeUseCaseFactory, this.userProfileMode,
      {this.userProfileComponentViewModelController}) {
    _profileModeUseCaseInputPort =
        _profileModeUseCaseFactory!.getInstance(userProfileMode!);
    if (userProfileComponentViewModelController != null) {
      userProfileComponentViewModelController!._userProfileComponentViewModel =
          this;
    }
    _init();
  }

  _init() async {
    _isLoaded = false;
    notifyListeners();
    _userProfileComponentInfoDto =
        await _profileModeUseCaseInputPort!.getUserInfo();
    _isLoaded = true;
    notifyListeners();
  }

  String get userNickName {
    return _userProfileComponentInfoDto!.userNickName!;
  }

  String get countryName {
    return codeCountry
        .findCountryName(_userProfileComponentInfoDto!.countryCode!);
  }

  String get userSelfIntroduce {
    if (_userProfileComponentInfoDto!.selfIntroduce != null) {
      return _userProfileComponentInfoDto!.selfIntroduce!;
    } else {
      return "";
    }
  }

  String get followerCount {
    return _userProfileComponentInfoDto!.followerCount.toString();
  }

  String get userLevel {
    return _userProfileComponentInfoDto!.uLevel.toString();
  }

  String get followingCount {
    return _userProfileComponentInfoDto!.followingCount.toString();
  }

  BoxDecoration getBackgroundDecoration() {
    if (_userProfileComponentInfoDto!.backgroundUrl != null) {
      return BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(_userProfileComponentInfoDto!.backgroundUrl!),
            fit: BoxFit.cover),
      );
    } else {
      return BoxDecoration(
        color: Color(0xffF4F5F5),
      );
    }
  }

  Widget getProfileImageBoxWidget() {
    if (_userProfileComponentInfoDto!.profileImageUrl != null) {
      return Container(
        height: 74,
        width: 74,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
          image: DecorationImage(
              image: NetworkImage(_userProfileComponentInfoDto!.profileImageUrl!),
              fit: BoxFit.cover),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0,4),
              blurRadius: 16
            )
          ]
        ),
      );
    } else {
      return Container(
        height: 74,
        width: 74,
        child: SvgPicture.asset("assets/IconImage/user-circle.svg"),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 2),
        ),
      );
    }
  }
}

class UserProfileComponentViewModelController {
  UserProfileComponentViewModel? _userProfileComponentViewModel;

  reloadUserInfo() {
    _userProfileComponentViewModel!._init();
  }
}
