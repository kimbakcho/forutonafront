import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReViewsContentBars.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReViewsInsert.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInsertRow.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FullReviewPage extends StatelessWidget {
  final String ballUuid;

  const FullReviewPage({Key key, this.ballUuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FullReviewPageViewModel(
            signInUserInfoUseCaseInputPort: sl(),
            fBallReplyUseCaseInputPort: sl(),
            ballUuid: ballUuid),
        child: Consumer<FullReviewPageViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(children: <Widget>[
                    topAppBar(context, model),
                    Expanded(
                      child: BasicReViewsContentBars(
                        ballUuid: ballUuid,
                        canSubReplyInsert: true,
                        reviewInertMediator: model.reviewInertMediator,
                        pageLimit: 10,
                        listable: true,
                        showChildReply: true,
                        showEditBtn: true,
                      ),
                    ),
                    InkWell(
                        onTap: () {
                          model.showRootReplyInputDialog(context);
                        },
                        child: IgnorePointer(
                            child: ReviewInsertRow(
                          autoFocus: false,
                          userProfileImageUrl: model.userProfileImage,
                        )))
                  ])));
        }));
  }

  Row topAppBar(BuildContext context, FullReviewPageViewModel model) {
    return Row(children: <Widget>[
      BackButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      Container(
          child: Text("댓글(${model.reviewsCount})",
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                height: 1.25,
              )))
    ]);
  }
}

class FullReviewPageViewModel extends ChangeNotifier implements ReviewInertMediatorComponent{
  final String ballUuid;
  final ReviewInertMediator reviewInertMediator;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  int reviewsCount = 0;
  int page = 0;
  int pageLimit = 10;
  List<FBallReplyResDto> replys = [];
  bool isLastPage = false;
  FUserInfoResDto _fUserInfoResDto;

  FullReviewPageViewModel(
      {this.ballUuid,
        FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,
      SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : reviewInertMediator =
            ReviewInertMediatorImpl(fBallReplyUseCaseInputPort: sl()),
        _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fBallReplyUseCaseInputPort =fBallReplyUseCaseInputPort {
    this._fUserInfoResDto =
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
    reviewInertMediator.registerComponent(this);
    getReviewCount();
  }
  getReviewCount() async {
    reviewsCount = await this._fBallReplyUseCaseInputPort.getBallReviewCount(ballUuid);
        notifyListeners();
  }

  get userProfileImage {
    return this._fUserInfoResDto.profilePictureUrl;


  }

  showRootReplyInputDialog(BuildContext context) async {
    await showModalBottomSheet(
        context: context,
        isDismissible: true,
        isScrollControlled: true,
        builder: (context) {
          return BasicReViewsInsert(
              ballUuid: ballUuid,
              autoFocus: true,
              reviewInertMediator: reviewInertMediator);
        });
    getReviewCount();
  }

  @override
  onInserted(FBallReplyResDto fBallReplyResDto) {
    getReviewCount();
  }

}
