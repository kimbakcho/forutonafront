import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReply/FBallReplyResDto.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'BasicReViewsInsert.dart';
import 'ReviewInertMediator.dart';

class BasicReviews extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator reviewInertMediator;

  BasicReviews({Key key, this.ballUuid, this.reviewInertMediator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ReviewsViewModel(
            ballUuid: ballUuid,
            reviewInertMediator: reviewInertMediator,
            fireBaseAuthAdapterForUseCase: sl(),
            fBallReplyUseCaseInputPort: sl()),
        child: Consumer<ID001ReviewsViewModel>(builder: (_, model, __) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      child: Text(
                        '${model.reviewsCount}',
                        style: GoogleFonts.notoSans(
                          fontSize: 20,
                          color: const Color(0xffcccccc),
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      child: Text(
                        'Reviews',
                        style: GoogleFonts.notoSans(
                          fontSize: 10,
                          color: const Color(0xffcccccc),
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: 38,
                      height: 38,
                      child: FlatButton(
                        onPressed: () {
                          model.showRootReplyInputDialog(context);
                        },
                        child: Icon(Icons.edit, color: Colors.white),
                        padding: EdgeInsets.all(0),
                      ),
                      decoration: BoxDecoration(
                          color: Color(0xff007EFF), shape: BoxShape.circle),
                    )
                  ],
                )
              ],
            ),
          );
        }));
  }
}

class ID001ReviewsViewModel extends ChangeNotifier
    implements ReviewInertMediatorComponent {
  final String ballUuid;
  final FBallReplyUseCaseInputPort _fBallReplyUseCaseInputPort;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;
  final isLoaded = false;
  int reviewsCount = 0;
  PageWrap<FBallReplyResDto> _pageWrapFBallReplyResDto;
  ReviewInertMediator _reviewInertMediator;

  ID001ReviewsViewModel(
      {this.ballUuid,
      FBallReplyUseCaseInputPort fBallReplyUseCaseInputPort,
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase,
      ReviewInertMediator reviewInertMediator})
      : _fBallReplyUseCaseInputPort = fBallReplyUseCaseInputPort,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase,
        _reviewInertMediator = reviewInertMediator {
    _reviewInertMediator.registerComponent(this);
    loadReviewCount();
    loadReply();
  }

  void loadReviewCount() async {
    reviewsCount =
        await this._fBallReplyUseCaseInputPort.getBallReviewCount(ballUuid);
    notifyListeners();
  }

  void loadReply() async {
    FBallReplyReqDto replyReqDto = new FBallReplyReqDto();
    replyReqDto.ballUuid = ballUuid;
    replyReqDto.replyNumber = 0;
    replyReqDto.reqOnlySubReply = false;
    _pageWrapFBallReplyResDto = await this
        ._fBallReplyUseCaseInputPort
        .reqFBallReply(replyReqDto, Pageable(0, 3, "replyNumberDESC"));
    notifyListeners();
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
                reviewInertMediator: _reviewInertMediator);
          });
      loadReply();
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) {
        return J001View();
      }));
    }
  }

  @override
  onInserted(FBallReplyResDto fBallReplyResDto) {
    reviewsCount++;
    notifyListeners();
  }
}
