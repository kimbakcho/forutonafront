import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/FullReviewPage/FullReviewPage.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewCountMediator.dart';
import 'package:forutonafront/FBall/Presentation/Widget/FBallReply2/ReviewInertMediator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ID001ActionBottomBar extends StatelessWidget {
  final String ballUuid;
  final ReviewInertMediator reviewInertMediator;
  final ReviewCountMediator reviewCountMediator;

  ID001ActionBottomBar({@required this.ballUuid,this.reviewCountMediator,this.reviewInertMediator});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ActionBottomBarViewModel(
          reviewCountMediator: reviewCountMediator,
            valuationMediator:
                Provider.of<ID001MainPage2ViewModel>(context).valuationMediator,
            ballUuid: ballUuid),
        child: Consumer<ID001ActionBottomBarViewModel>(builder: (_, model, __) {
          return Container(
            child: Row(
              children: <Widget>[
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(Icons.card_giftcard),
                    onPressed: () {}),
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(ForutonaIcon.heart),
                    onPressed: () {}),
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(ForutonaIcon.share),
                    onPressed: () {}),
                Stack(
                  children: <Widget>[
                    RawMaterialButton(
                        padding: EdgeInsets.only(right: 10),
                        constraints: BoxConstraints(),
                        child: Icon(ForutonaIcon.comment),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => FullReviewPage(
                                ballUuid: ballUuid,
                                reviewInertMediator: reviewInertMediator,
                                reviewCountMediator: reviewCountMediator,
                              )));
                        }),
                    Positioned(
                        right: 0,
                        top: 13,
                        child: Container(
                          width: 31,
                          height: 13,
                          child: Text(
                            "${model.reviewCount}",
                            style: GoogleFonts.notoSans(
                              fontSize: 9,
                              color: const Color(0xffffffff),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: const Color(0xffff4e6a),
                          ),
                        ))
                  ],
                ),
                Spacer(),
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(ForutonaIcon.thumbsup,
                        color: model.ballLikeState == BallLikeState.Up
                            ? Colors.lightBlueAccent
                            : Colors.grey),
                    onPressed: () {
                      model.likeAction();
                    }),
                RawMaterialButton(
                    padding: EdgeInsets.all(5),
                    constraints: BoxConstraints(),
                    child: Icon(ForutonaIcon.thumbsdown,
                        color: model.ballLikeState == BallLikeState.Down
                            ? Colors.lightBlueAccent
                            : Colors.grey),
                    onPressed: () {
                      model.disLikeAction();
                    }),
              ],
            ),
            width: MediaQuery.of(context).size.width,
            decoration:
                BoxDecoration(color: Color(0xffFFFFFF).withOpacity(0.9)),
          );
        }));
  }
}

class ID001ActionBottomBarViewModel extends ChangeNotifier
    implements ValuationMediatorComponent,ReviewCountMediatorComponent {
  String ballUuid;
  final ValuationMediator _valuationMediator;
  final ReviewCountMediator _reviewCountMediator;

  ID001ActionBottomBarViewModel(
      {this.ballUuid, @required ValuationMediator valuationMediator,
        ReviewCountMediator reviewCountMediator
      })
      : _valuationMediator = valuationMediator,_reviewCountMediator=reviewCountMediator {
    _valuationMediator.registerComponent(this);
    _reviewCountMediator.registerComponent(this);
    _reviewCountMediator.reqReviewCount(ballUuid);
  }

  likeAction() async {
    _valuationMediator.likeAction(this);
  }

  BallLikeState get ballLikeState {
    return _valuationMediator.ballLikeState;
  }

  disLikeAction() async {
    _valuationMediator.disLikeAction(this);
  }


  @override
  void dispose() {
    _reviewCountMediator.unregisterComponent(this);
    super.dispose();
  }

  @override
  reqNotification() {
    notifyListeners();
  }

  get reviewCount {
    return _reviewCountMediator.reviewCount;
  }

  @override
  onReviewCount(int reviewCount) {
    notifyListeners();
  }
}
