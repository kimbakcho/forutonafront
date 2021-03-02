import 'package:flutter/material.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ID001WidgetPart/ID001LikeAction.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ID01LikeState extends StatelessWidget {
  final String ballUuid;
  final DateTime ballActivationTime;
  final ValuationMediator valuationMediator;

  ID01LikeState(
      {this.ballUuid, this.ballActivationTime, this.valuationMediator}) {
    print(ballUuid);
    print(ballActivationTime);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID01LikeStateViewModel(
            valuationMediator: valuationMediator,
            ballUuid: ballUuid,
            ballActivationTime: ballActivationTime),
        child: Consumer<ID01LikeStateViewModel>(builder: (_, model, __) {
          return Container(
              height: 187,
              padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
              child: Column(children: <Widget>[
                topState(model),
                secondState(model),
                likeProgress(context, model),
                disLikeProgress(context, model)
              ]));
        }));
  }

  Container disLikeProgress(
      BuildContext context, ID01LikeStateViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: 21),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Icon(
              ForutonaIcon.thumbsdown,
              color: Colors.grey,
              size: 15,
            ),
          ),
          Container(
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 42 - 97 - 16,
              lineHeight: 10,
              backgroundColor: Color(0xffE4E7E8),
              progressColor: Color(0xff454F63),
              percent: model.ballDisLikePercent,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(
                "${model.ballDisLikeCount} (${(model.ballDisLikePercent * 100).toStringAsFixed(0)}%)",
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: const Color(0xff000000),
                  letterSpacing: -0.9800000000000001,
                  fontWeight: FontWeight.w700,
                  height: 1.4285714285714286,
                )),
          )
        ],
      ),
    );
  }

  Container likeProgress(BuildContext context, ID01LikeStateViewModel model) {
    return Container(
      margin: EdgeInsets.only(top: 21),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
            child: Icon(
              ForutonaIcon.thumbsup,
              color: Colors.grey,
              size: 15,
            ),
          ),
          Container(
            child: LinearPercentIndicator(
              width: MediaQuery.of(context).size.width - 42 - 97 - 16,
              lineHeight: 10,
              backgroundColor: Color(0xffE4E7E8),
              progressColor: Color(0xff454F63),
              percent: model.ballLikePercent,
            ),
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Text(
                "${model.ballLikeCount} (${(model.ballLikePercent * 100).toStringAsFixed(0)}%)",
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: const Color(0xff000000),
                  letterSpacing: -0.9800000000000001,
                  fontWeight: FontWeight.w700,
                  height: 1.4285714285714286,
                )),
          )
        ],
      ),
    );
  }

  Row secondState(ID01LikeStateViewModel model) {
    return Row(children: <Widget>[
      Icon(Icons.people, color: Color(0xffCCCCCC)),
      Container(
        margin: EdgeInsets.fromLTRB(8, 0, 13, 0),
        child: Text(
          "${model.likeServiceUseUserCount}",
          style: GoogleFonts.notoSans(
            fontSize: 16,
            color: const Color(0xffcccccc),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      Container(
        width: 1,
        height: 11,
        color: Color(0xffE4E7E8),
      ),
      Container(
          margin: EdgeInsets.only(left: 16),
          child: Row(children: <Widget>[
            Icon(Icons.access_time, color: Color(0xffcccccc)),
            Container(
                margin: EdgeInsets.only(left: 10),
                child: Text(model.ballRemindTime,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: const Color(0xffcccccc),
                      fontWeight: FontWeight.w700,
                    )))
          ]))
    ]);
  }

  Row topState(ID01LikeStateViewModel model) {
    return Row(children: <Widget>[
      Container(
          child: Text(
        "${model.ballPower}",
        style: GoogleFonts.notoSans(
          fontSize: 36,
          color: const Color(0xff000000),
          fontWeight: FontWeight.w700,
          height: 0.5555555555555556,
        ),
        textAlign: TextAlign.center,
      )),
      Container(
          margin: EdgeInsets.only(left: 5),
          child: Text(
            'Ball Power',
            style: GoogleFonts.notoSans(
              fontSize: 10,
              color: const Color(0xff78849e),
            ),
            textAlign: TextAlign.left,
          )),
      Spacer(),
      ID001LikeAction(
        ballUuid: ballUuid,
        valuationMediator: valuationMediator,
      )
    ]);
  }
}

class ID01LikeStateViewModel extends ChangeNotifier
    implements ValuationMediatorComponent {
  String ballUuid;
  DateTime _ballActivationTime;
  final ValuationMediator _valuationMediator;

  ID01LikeStateViewModel(
      {String ballUuid,
      DateTime ballActivationTime,
      @required ValuationMediator valuationMediator})
      : _valuationMediator = valuationMediator,
        _ballActivationTime = ballActivationTime {
    _valuationMediator.registerComponent(this);
  }

  get ballDisLikeCount => _valuationMediator.ballDisLikeCount;

  get ballLikeCount => _valuationMediator.ballLikeCount;

  get likeServiceUseUserCount => _valuationMediator.likeServiceUseUserCount;

  get ballPower => _valuationMediator.ballPower;

  double get ballLikePercent {
    if ((_valuationMediator.ballLikeCount +
            _valuationMediator.ballDisLikeCount) ==
        0) {
      return 0;
    }
    return _valuationMediator.ballLikeCount /
        (_valuationMediator.ballLikeCount +
            _valuationMediator.ballDisLikeCount);
  }

  double get ballDisLikePercent {
    if ((_valuationMediator.ballLikeCount +
            _valuationMediator.ballDisLikeCount) ==
        0) {
      return 0;
    }
    return _valuationMediator.ballDisLikeCount /
        (_valuationMediator.ballLikeCount +
            _valuationMediator.ballDisLikeCount);
  }

  String get ballRemindTime {
    return TimeDisplayUtil.getCalcToStrFromNow(_ballActivationTime);
  }

  @override
  valuationReqNotification() {
    notifyListeners();
  }

  @override
  void dispose() {
    _valuationMediator.unregisterComponent(this);
    super.dispose();
  }
}
