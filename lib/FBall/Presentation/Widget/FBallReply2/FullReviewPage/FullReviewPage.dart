import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReViewsContentBars.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/BasicReViewsInsert.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewDeleteMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInsertRow.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewUpdateMediator.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FullReviewPage extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator reviewInertMediator;
  final ReviewCountMediator reviewCountMediator;
  final ReviewDeleteMediator reviewDeleteMediator;
  final ReviewUpdateMediator reviewUpdateMediator;

  const FullReviewPage(
      {Key key,
      this.ballUuid,
      this.reviewInertMediator,
      this.reviewDeleteMediator,
      this.reviewUpdateMediator,
      this.reviewCountMediator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => FullReviewPageViewModel(
            signInUserInfoUseCaseInputPort: sl(),
            fBallReplyUseCaseInputPort: sl(),
            reviewCountMediator: reviewCountMediator,
            reviewDeleteMediator: reviewDeleteMediator,
            fireBaseAuthAdapterForUseCase: sl(),
            reviewInertMediator: reviewInertMediator,
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
                        reviewCountMediator: reviewCountMediator,
                        reviewInertMediator: reviewInertMediator,
                        reviewUpdateMediator: reviewUpdateMediator,
                        reviewDeleteMediator: reviewDeleteMediator,
                        canSubReplyInsert: true,
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
                            child: ReviewTextActionRow(
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
          child: Text("댓글(${model.reviewCount})",
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                height: 1.25,
              )))
    ]);
  }
}

class FullReviewPageViewModel extends ChangeNotifier
    implements ReviewCountMediatorComponent, ReviewDeleteMediatorComponent,ReviewUpdateMediatorComponent {
  final String ballUuid;
  final ReviewInertMediator reviewInertMediator;
  final ReviewCountMediator reviewCountMediator;
  final ReviewDeleteMediator reviewDeleteMediator;
  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final Preference _preference = sl();

  int page = 0;
  int pageLimit = 10;
  List<FBallReplyResDto> replys = [];
  bool isLastPage = false;
  FUserInfoResDto _fUserInfoResDto;

  FullReviewPageViewModel(
      {this.ballUuid,
      this.reviewInertMediator,
      this.reviewCountMediator,
      this.reviewDeleteMediator,
      FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort})
      : _signInUserInfoUseCaseInputPort = signInUserInfoUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase {
    initPage();
    reviewCountMediator.registerComponent(this);
    reviewDeleteMediator.registerComponent(this);
  }

  initPage() async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      this._fUserInfoResDto =
          _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory();
      notifyListeners();
    }
  }

  get userProfileImage {
    if (_fUserInfoResDto == null) {
      return _preference.basicProfileImageUrl;
    } else {
      return this._fUserInfoResDto.profilePictureUrl;
    }
  }

  showRootReplyInputDialog(BuildContext context) async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      await showModalBottomSheet(
          context: context,
          isDismissible: true,
          isScrollControlled: true,
          builder: (context) {
            return BasicReViewsInsert(
                ballUuid: ballUuid,
                autoFocus: true,
                reviewCountMediator: reviewCountMediator,
                reviewInertMediator: reviewInertMediator);
          });
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J001View()));
    }
  }

  get reviewCount {
    return reviewCountMediator.reviewCount;
  }

  @override
  void dispose() {
    reviewCountMediator.unregisterComponent(this);
    reviewDeleteMediator.unregisterComponent(this);
    super.dispose();
  }

  @override
  onReviewCount(int reviewCount) {
    notifyListeners();
  }

  @override
  onDeleted(FBallReplyResDto fBallReplyResDto) {
    notifyListeners();
  }

  @override
  onUpdated(FBallReplyResDto fBallReplyResDto) {
    notifyListeners();
  }
}
