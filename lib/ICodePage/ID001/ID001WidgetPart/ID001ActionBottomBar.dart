import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallLikeResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ICodePage/ID001/ID001MainPage2ViewModel.dart';
import 'package:forutonafront/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ID001ActionBottomBar extends StatelessWidget {
  final String ballUuid;

  ID001ActionBottomBar({@required this.ballUuid});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001ActionBottomBarViewModel(
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
                        onPressed: () {}),
                    Positioned(
                        right: 0,
                        top: 13,
                        child: Container(
                          width: 31,
                          height: 13,
                          child: Text(
                            "120",
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
    implements ValuationMediatorComponent {
  final String ballUuid;
  final ValuationMediator _valuationMediator;
  BallLikeState ballLikeState = BallLikeState.None;

  ID001ActionBottomBarViewModel(
      {this.ballUuid, @required ValuationMediator valuationMediator})
      : _valuationMediator = valuationMediator {
    _valuationMediator.registerComponent(this);
  }

  likeAction() async {
    if (ballLikeState == BallLikeState.Up) {
      await _valuationMediator.likeCancel(1, ballUuid);
    } else if (ballLikeState == BallLikeState.Down) {
      await _valuationMediator.disLikeCancel(1, ballUuid);
      await _valuationMediator.like(1, ballUuid);
    } else {
      await _valuationMediator.like(1, ballUuid);
    }
  }

  disLikeAction() async {
    if (ballLikeState == BallLikeState.Up) {
      await _valuationMediator.likeCancel(1, ballUuid);
      await _valuationMediator.disLike(1, ballUuid);
    } else if (ballLikeState == BallLikeState.Down) {
      await _valuationMediator.disLikeCancel(1, ballUuid);
    } else {
      await _valuationMediator.disLike(1, ballUuid);
    }
  }

  @override
  updateValuation(FBallLikeResDto fBallLikeResDto) {

    if (fBallLikeResDto.fballValuationResDto.ballLike > 0) {
      ballLikeState = BallLikeState.Up;
    } else if (fBallLikeResDto.fballValuationResDto.ballDislike > 0) {
      ballLikeState = BallLikeState.Down;
    } else {
      ballLikeState = BallLikeState.None;
    }
    notifyListeners();
  }
}
