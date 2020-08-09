import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';


class BasicReViewsInsert extends StatelessWidget {
  final String ballUuid;
  final String rootReplyUuid;

  const BasicReViewsInsert({Key key, this.ballUuid, this.rootReplyUuid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ReplyInsertViewModel(
              ballUuid: ballUuid,
              context: context,
              signInUserInfoUseCaseInputPort: sl(),
              rootReplyUuid: rootReplyUuid,
            ),
        child: Consumer<ID001ReplyInsertViewModel>(builder: (_, model, __) {
          return Container(
              padding: MediaQuery.of(context).viewInsets.add(EdgeInsets.fromLTRB(16, 8, 16, 8)),
              child: Row(children: <Widget>[
            Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(model.userProfileImage)))),
            Expanded(
              child: Container(
                width: 300,
                child: TextField(
                  minLines: 1,
                  maxLines: 3,
                  autocorrect: false,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(width: 0,color: Colors.white)
                    )
                  ),
                  keyboardType: TextInputType.multiline,
                  autofocus: true,
                  controller: model.replyTextEditController,
                  cursorColor: Color(0xff3497FD),
                ),
              ),
            ),
            Container(
              height: 30,
              width: 30,
              child: FlatButton(
                padding: EdgeInsets.all(0).add(EdgeInsets.only(right: 4)),
                onPressed: () {
                  model.insertReply(ballUuid,rootReplyUuid);
                },
                child: Icon(
                  ForutonaIcon.replysendicon,
                  color: Colors.white,
                  size: 14,
                ),
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xff007EFF),
              ),
            )
          ]));
        }));
  }
}

class ID001ReplyInsertViewModel extends ChangeNotifier {
  final String ballUuid;
  final String rootReplyUuid;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  final BuildContext context;
  String userProfileImage;
  TextEditingController replyTextEditController;
  StreamSubscription keyBoardSubscription;

  ID001ReplyInsertViewModel(
      {this.ballUuid,
      this.rootReplyUuid,
        this.context,
      SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
        FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort
      })
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fBallReplyUseCaseInputPort= fBallReplyUseCaseInputPort
  {
    replyTextEditController = TextEditingController();
    FUserInfoResDto fUserInfoResDto =
        this._signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    userProfileImage = fUserInfoResDto.profilePictureUrl;
    keyBoardSubscription = KeyboardVisibility.onChange.listen(keyBoardListen);
  }

  keyBoardListen(bool value){
    if(!value){
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    keyBoardSubscription.cancel();
    super.dispose();
  }

  Future<void> loadUserInfo() async {}

  void insertReply(String ballUuid, String rootReplyUuid) async {
    FBallReplyInsertReqDto reqDto = FBallReplyInsertReqDto();
    reqDto.ballUuid = ballUuid;
    reqDto.replyText = replyTextEditController.text;
    reqDto.replyUuid = rootReplyUuid;
    await _fBallReplyUseCaseInputPort.insertFBallReply(reqDto);
  }
}
