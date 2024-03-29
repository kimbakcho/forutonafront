import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/AppBis/FBallReply/Dto/FBallReply/FBallReplyUpdateReqDto.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import '../ReviewInsertRow.dart';
import '../ReviewUpdateMediator.dart';

class BasicReViewUpdate extends StatelessWidget {
  final FBallReplyResDto? fBallReplyResDto;
  final ReviewUpdateMediator? _reviewUpdateMediator;

  const BasicReViewUpdate(
      {Key? key,
      this.fBallReplyResDto,
      ReviewUpdateMediator? reviewUpdateMediator})
      : _reviewUpdateMediator = reviewUpdateMediator,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BasicReViewUpdateViewModel(
          signInUserInfoUseCaseInputPort: sl(),
          reviewUpdateMediator: _reviewUpdateMediator,
          context: context,
          fBallReplyResDto: fBallReplyResDto),
      child: Consumer<BasicReViewUpdateViewModel>(builder: (_, model, __) {
        return Container(
          child: ReviewTextActionRow(
            ballUuid: model.ballUuid,
            padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
            userProfileImageUrl: model.userProfileImage,
            autoFocus: true,
            actionReply: model.updateReply,
            reviewTextActionRowController: model.reviewTextActionRowController,
          ),
        );
      }),
    );
  }
}

class BasicReViewUpdateViewModel extends ChangeNotifier {
  final FBallReplyResDto? fBallReplyResDto;
  final SignInUserInfoUseCaseInputPort? _signInUserInfoUseCaseInputPort;
  FUserInfoResDto? _fUserInfo;
  ReviewTextActionRowController? reviewTextActionRowController;
  final ReviewUpdateMediator? _reviewUpdateMediator;
  final BuildContext? context;
  StreamSubscription? keyBoardSubscription;

  BasicReViewUpdateViewModel(
      {this.fBallReplyResDto,
      this.context,
      SignInUserInfoUseCaseInputPort? signInUserInfoUseCaseInputPort,
      ReviewUpdateMediator? reviewUpdateMediator})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _reviewUpdateMediator = reviewUpdateMediator
      {
  reviewTextActionRowController = ReviewTextActionRowController(initReplyText: fBallReplyResDto!.replyText);
  _fUserInfo = _signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory();
    var keyboardVisibilityController = KeyboardVisibilityController();
    keyBoardSubscription = keyboardVisibilityController.onChange.listen(keyBoardListen);
  }

  keyBoardListen(bool value) {
    if (!value) {
      Navigator.of(context!).pop();
    }
  }

  String? get userProfileImage {
    return _fUserInfo!.profilePictureUrl;
  }

  String? get ballUuid {
    return fBallReplyResDto!.ballUuid!.ballUuid;
  }

  @override
  void dispose() {
    if (keyBoardSubscription != null) {
      keyBoardSubscription!.cancel();
    }
    super.dispose();
  }

  updateReply(String ballUuid) async {


    reviewTextActionRowController!.textFieldUnFocus();
    keyBoardSubscription!.cancel();
    keyBoardSubscription = null;

    Navigator.of(context!).pop();

    showGeneralDialog(context: context!,
        pageBuilder: (context, animation, secondaryAnimation) {
          _updateReplyInLoading(context);
          return CommonLoadingComponent();
        });



  }

  void _updateReplyInLoading(BuildContext context) async{
    FBallReplyUpdateReqDto reqDto = FBallReplyUpdateReqDto();
    reqDto.replyText = reviewTextActionRowController!.replyText;
    reqDto.replyUuid = fBallReplyResDto!.replyUuid;
    FBallReplyResDto recvFBallReplyResDto = await _reviewUpdateMediator!.updateReView(reqDto);
    fBallReplyResDto!.replyText = recvFBallReplyResDto.replyText;
    Navigator.of(context).pop();
  }

}
