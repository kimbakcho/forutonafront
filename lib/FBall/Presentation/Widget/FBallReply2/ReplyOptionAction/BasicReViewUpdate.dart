import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyUpdateReqDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInsertRow.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class BasicReViewUpdate extends StatelessWidget {
  final FBallReplyResDto fBallReplyResDto;

  const BasicReViewUpdate({Key key, this.fBallReplyResDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BasicReViewUpdateViewModel(
          signInUserInfoUseCaseInputPort: sl(),
          fBallReplyUseCaseInputPort: sl(),
          context: context,
          fBallReplyResDto: fBallReplyResDto),
      child: Consumer<BasicReViewUpdateViewModel>(builder: (_, model, __) {
        return Container(
          padding: MediaQuery.of(context).viewInsets,
          child: ReviewTextActionRow(
            ballUuid: model.ballUuid,
            userProfileImageUrl: model.userProfileImage,
            autoFocus: true,
            actionReply: model.updateReply,
            replyTextEditController: model.textEditingController,
          ),
        );
      }),
    );
  }
}

class BasicReViewUpdateViewModel extends ChangeNotifier {
  final FBallReplyResDto fBallReplyResDto;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  FUserInfoResDto _fUserInfo;
  final TextEditingController textEditingController;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  final BuildContext context;
  StreamSubscription keyBoardSubscription;

  BasicReViewUpdateViewModel(
      {this.fBallReplyResDto,
      this.context,
      SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort,
        textEditingController =
            TextEditingController(text: fBallReplyResDto.replyText) {
    _fUserInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    keyBoardSubscription = KeyboardVisibility.onChange.listen(keyBoardListen);
  }

  keyBoardListen(bool value) {
    if (!value) {
      Navigator.of(context).pop();
    }
  }

  String get userProfileImage {
    return _fUserInfo.profilePictureUrl;
  }

  String get ballUuid {
    return fBallReplyResDto.ballUuid.ballUuid;
  }

  @override
  void dispose() {
    if (keyBoardSubscription != null) {
      keyBoardSubscription.cancel();
    }
    super.dispose();
  }

  updateReply(String ballUuid) async {
    FBallReplyUpdateReqDto reqDto = FBallReplyUpdateReqDto();
    reqDto.replyText = textEditingController.text;
    reqDto.replyUuid = fBallReplyResDto.replyUuid;
    FBallReplyResDto recvFBallReplyResDto =
        await _fBallReplyUseCaseInputPort.updateFBallReply(reqDto);
    fBallReplyResDto.replyText = recvFBallReplyResDto.replyText;
    keyBoardSubscription.cancel();
    keyBoardSubscription = null;
    Navigator.of(context).pop();
  }
}
