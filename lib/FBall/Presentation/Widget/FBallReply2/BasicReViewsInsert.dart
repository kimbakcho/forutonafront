import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReViewsContentBar.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInsertRow.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class BasicReViewsInsert extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator _reviewInertMediator;
  final FBallReplyResDto parentFBallReplyResDto;
  final bool autoFocus;

  const BasicReViewsInsert(
      {Key key,
      this.ballUuid,
      this.autoFocus,
      ReviewInertMediator reviewInertMediator, this.parentFBallReplyResDto})
      : _reviewInertMediator = reviewInertMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ReplyInsertViewModel(
            ballUuid: ballUuid,
            context: context,
            parentFBallReplyResDto: parentFBallReplyResDto,
            reviewInertMediator: _reviewInertMediator,
            signInUserInfoUseCaseInputPort: sl()),
        child: Consumer<ID001ReplyInsertViewModel>(builder: (_, model, __) {
          return ListView(
            shrinkWrap: true,
            padding: MediaQuery.of(context).viewInsets,
            children: <Widget>[
              model.parentFBallReplyResDto != null
                  ? BasicReViewsContentBar(
                      showChildReply: false,
                      showEditBtn: false,
                      hasBottomPadding: false,
                      hasBoardLine: false,
                      canSubReplyInsert: false,
                      reviewInertMediator: _reviewInertMediator,
                      fBallReplyResDto: model.parentFBallReplyResDto,
                    )
                  : Container(),
              ReviewInsertRow(
                autoFocus: this.autoFocus,
                ballUuid: model.ballUuid,
                userProfileImageUrl: model.userProfileImage,
                insertReply: model.insertReply,
                replyTextEditController: model.replyTextEditController,
              )
            ],
          );
        }));
  }
}

class ID001ReplyInsertViewModel extends ChangeNotifier {
  final String ballUuid;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final BuildContext context;
  final ReviewInertMediator _reviewInertMediator;
  final FBallReplyResDto parentFBallReplyResDto;
  String userProfileImage;
  TextEditingController replyTextEditController;
  StreamSubscription keyBoardSubscription;

  ID001ReplyInsertViewModel(
      {this.ballUuid,
      this.context,
        this.parentFBallReplyResDto,
      ReviewInertMediator reviewInertMediator,
      SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _reviewInertMediator = reviewInertMediator {
    replyTextEditController = TextEditingController();
    FUserInfoResDto fUserInfoResDto =
        this._signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    userProfileImage = fUserInfoResDto.profilePictureUrl;
    keyBoardSubscription = KeyboardVisibility.onChange.listen(keyBoardListen);
  }

  keyBoardListen(bool value) {
    if (!value) {
      Navigator.of(context).pop();
    }
  }

  @override
  void dispose() {
    if (keyBoardSubscription != null) {
      keyBoardSubscription.cancel();
    }
    super.dispose();
  }

  Future<void> loadUserInfo() async {}

  void insertReply(String ballUuid) async {
    FBallReplyInsertReqDto reqDto = FBallReplyInsertReqDto();
    reqDto.ballUuid = ballUuid;
    if(parentFBallReplyResDto != null){
      reqDto.replyUuid = parentFBallReplyResDto.replyUuid;
    }
    reqDto.replyText = replyTextEditController.text;
    await this._reviewInertMediator.insertReview(reqDto);
    keyBoardSubscription.cancel();
    keyBoardSubscription = null;
    Navigator.of(context).pop();
  }
}
