import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyInsertReqDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'BasicReViewsContentBar.dart';
import 'ReviewCountMediator.dart';
import 'ReviewInertMediator.dart';
import 'ReviewInsertRow.dart';

class BasicReViewsInsert extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator _reviewInertMediator;
  final ReviewCountMediator _reviewCountMediator;
  final FBallReplyResDto parentFBallReplyResDto;
  final bool autoFocus;

  const BasicReViewsInsert(
      {Key key,
      this.ballUuid,
      this.autoFocus,
      ReviewCountMediator reviewCountMediator,
      ReviewInertMediator reviewInertMediator,
      this.parentFBallReplyResDto})
      : _reviewInertMediator = reviewInertMediator,
        _reviewCountMediator = reviewCountMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ReplyInsertViewModel(
            ballUuid: ballUuid,
            context: context,
            parentFBallReplyResDto: parentFBallReplyResDto,
            reviewCountMediator: _reviewCountMediator,
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
                reviewCountMediator: _reviewCountMediator,
                reviewInertMediator: _reviewInertMediator,
                fBallReplyResDto: model.parentFBallReplyResDto,
              )
                  : Container(),
              ReviewTextActionRow(
                autoFocus: this.autoFocus,
                ballUuid: model.ballUuid,
                padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                userProfileImageUrl: model.userProfileImage,
                actionReply: model.insertReply,
                reviewTextActionRowController: model.reviewTextActionRowController,
              )
            ],
          )

            ;
        }));
  }
}

class ID001ReplyInsertViewModel extends ChangeNotifier {
  final String ballUuid;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final BuildContext context;
  final ReviewInertMediator _reviewInertMediator;
  final ReviewCountMediator _reviewCountMediator;
  final FBallReplyResDto parentFBallReplyResDto;
  String userProfileImage;
  ReviewTextActionRowController reviewTextActionRowController;
  StreamSubscription keyBoardSubscription;

  ID001ReplyInsertViewModel(
      {this.ballUuid,
      this.context,
      this.parentFBallReplyResDto,
      ReviewInertMediator reviewInertMediator,
      ReviewCountMediator reviewCountMediator,
      SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _reviewInertMediator = reviewInertMediator,
        _reviewCountMediator = reviewCountMediator {
    reviewTextActionRowController = ReviewTextActionRowController();
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

    reviewTextActionRowController.textFieldUnFocus();
    keyBoardSubscription.cancel();
    keyBoardSubscription = null;

    await showGeneralDialog(context: context,
        pageBuilder: (context, animation, secondaryAnimation) {
          _insertReplyInLoading(context);
      return CommonLoadingComponent();
    });

    Navigator.of(context).pop();

  }

  void _insertReplyInLoading(BuildContext context)async{
    FBallReplyInsertReqDto reqDto = FBallReplyInsertReqDto();
    reqDto.ballUuid = ballUuid;
    if (parentFBallReplyResDto != null) {
      reqDto.replyUuid = parentFBallReplyResDto.replyUuid;
    }
    reqDto.replyText = reviewTextActionRowController.replyText;
    await this._reviewInertMediator.insertReview(reqDto);
    await this._reviewCountMediator.reqReviewCount(ballUuid);
    Navigator.of(context).pop();
  }

}
