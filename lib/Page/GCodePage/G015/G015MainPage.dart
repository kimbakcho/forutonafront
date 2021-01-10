import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/UserAlarmConfigUpdateReqDto.dart';
import 'package:forutonafront/Common/SwitchWidget/SwitchStyle1.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G015MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G015MainPageViewModel(sl(), sl()),
        child: Consumer<G015MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  color: Colors.white,
                  child: Column(children: [
                    CodeAppBar(
                        title: "알림",
                        visibleTailButton: false,
                        progressValue: 0),
                    Container(
                        padding: EdgeInsets.fromLTRB(10, 16, 16, 8),
                        child: Column(children: [
                          SizedBox(height: 10),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("채팅메시지"),
                                SwitchStyle1(
                                    initValue: model.alarmChatMessage,
                                    activeColor: Color(0xff3497FD),
                                    switchStyle1Controller:
                                        model.alarmChatMessageCon,
                                    onChanged: (value) {
                                      model._updateConfig();
                                    })
                              ]),
                          SizedBox(height: 16),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("내 컨텐츠에 댓글"),
                                SwitchStyle1(
                                    initValue: model.alarmContentReply,
                                    activeColor: Color(0xff3497FD),
                                    switchStyle1Controller:
                                        model.alarmContentReplyCon,
                                    onChanged: (value) {
                                      model._updateConfig();
                                    })
                              ]),
                          SizedBox(height: 16),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("내 댓글에 대댓글"),
                                SwitchStyle1(
                                    initValue: model.alarmReplyAndReply,
                                    activeColor: Color(0xff3497FD),
                                    switchStyle1Controller:
                                        model.alarmMyReplyAndReplyCon,
                                    onChanged: (value) {
                                      model._updateConfig();
                                    })
                              ])
                        ])),
                    Divider(
                      color: Color(0xffE4E7E8),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(8, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '팔로워의 신규 컨텐츠',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff3a3e3f),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '    팔로워가 신규 컨텐츠를 제작하면 알립니다.',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    color: const Color(0xff7a7a7a),
                                    letterSpacing: -0.24,
                                    fontWeight: FontWeight.w300,
                                    height: 1.8333333333333333,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                            SwitchStyle1(
                                initValue: model.alarmFollowNewContent,
                                activeColor: Color(0xff3497FD),
                                switchStyle1Controller:
                                    model.alarmFollowNewContentCon,
                                onChanged: (value) {
                                  model._updateConfig();
                                })
                          ],
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: Color(0xffE4E7E8),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                        margin: EdgeInsets.fromLTRB(8, 0, 16, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '내 주변 인기 컨텐츠',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff3a3e3f),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '    내 주변 인기 컨텐츠의 등장을 알립니다.',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 12,
                                    color: const Color(0xff7a7a7a),
                                    letterSpacing: -0.24,
                                    fontWeight: FontWeight.w300,
                                    height: 1.8333333333333333,
                                  ),
                                  textAlign: TextAlign.left,
                                )
                              ],
                            ),
                            SwitchStyle1(
                                initValue: model.alarmSponNewContent,
                                activeColor: Color(0xff3497FD),
                                switchStyle1Controller:
                                    model.alarmSponNewContentCon,
                                onChanged: (value) {
                                  model._updateConfig();
                                })
                          ],
                        )),
                    SizedBox(
                      height: 16,
                    ),
                    Divider(
                      color: Color(0xffE4E7E8),
                    ),
                  ])));
        }));
  }
}

class G015MainPageViewModel extends ChangeNotifier {
  SwitchStyle1Controller alarmChatMessageCon = SwitchStyle1Controller();

  SwitchStyle1Controller alarmContentReplyCon = SwitchStyle1Controller();

  SwitchStyle1Controller alarmMyReplyAndReplyCon = SwitchStyle1Controller();

  SwitchStyle1Controller alarmFollowNewContentCon = SwitchStyle1Controller();

  SwitchStyle1Controller alarmSponNewContentCon = SwitchStyle1Controller();

  SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  UpdateAccountUserInfoUseCaseInputPort _updateAccountUserInfoUseCaseInputPort;

  FUserInfoResDto _fUserInfoResDto;

  G015MainPageViewModel(this._signInUserInfoUseCaseInputPort,
      this._updateAccountUserInfoUseCaseInputPort) {
    this._fUserInfoResDto =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
  }

  _updateConfig() async {
    UserAlarmConfigUpdateReqDto userAlarmConfigUpdateReqDto =
        UserAlarmConfigUpdateReqDto();
    userAlarmConfigUpdateReqDto.alarmChatMessage = alarmChatMessageCon.isCheck;
    userAlarmConfigUpdateReqDto.alarmContentReply =
        alarmContentReplyCon.isCheck;
    userAlarmConfigUpdateReqDto.alarmFollowNewContent =
        alarmFollowNewContentCon.isCheck;
    userAlarmConfigUpdateReqDto.alarmReplyAndReply =
        alarmMyReplyAndReplyCon.isCheck;
    userAlarmConfigUpdateReqDto.alarmSponNewContent =
        alarmSponNewContentCon.isCheck;

    await this
        ._updateAccountUserInfoUseCaseInputPort
        .userAlarmConfigUpdate(userAlarmConfigUpdateReqDto);
    notifyListeners();
  }

  get alarmChatMessage {
    return _fUserInfoResDto.alarmChatMessage;
  }

  get alarmContentReply {
    return _fUserInfoResDto.alarmContentReply;
  }

  get alarmReplyAndReply {
    return _fUserInfoResDto.alarmReplyAndReply;
  }

  get alarmFollowNewContent {
    return _fUserInfoResDto.alarmFollowNewContent;
  }

  get alarmSponNewContent {
    return _fUserInfoResDto.alarmSponNewContent;
  }
}
