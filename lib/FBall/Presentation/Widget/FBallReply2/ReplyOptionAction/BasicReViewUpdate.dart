import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
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
      create: (_) =>
          BasicReViewUpdateViewModel(
              signInUserInfoUseCaseInputPort: sl(),
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

  BasicReViewUpdateViewModel({this.fBallReplyResDto,
    SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        textEditingController = TextEditingController(text: fBallReplyResDto.replyText) {
    _fUserInfo = _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
  }

  String get userProfileImage {
    return _fUserInfo.profilePictureUrl;
  }

  String get ballUuid {
    return fBallReplyResDto.ballUuid.ballUuid;
  }

  updateReply(String ballUuid) {

  }
}
