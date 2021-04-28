import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';

class ID01BallPowerState extends StatefulWidget {
  final FBallResDto? fBallResDto;

  const ID01BallPowerState({Key? key, this.fBallResDto}) : super(key: key);

  @override
  _ID01BallPowerStateState createState() => _ID01BallPowerStateState();
}

class _ID01BallPowerStateState extends State<ID01BallPowerState> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01BallPowerStateViewModel(widget.fBallResDto),
      child: Consumer<ID01BallPowerStateViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Row(children: <Widget>[
                  Icon(Icons.people, color: Color(0xffCCCCCC)),
                  Container(
                    margin: EdgeInsets.fromLTRB(8, 0, 13, 0),
                    child: Text(
                      "${widget.fBallResDto!.contributor}",
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
                            child: Text(TimeDisplayUtil.getCalcToStrFromNow(widget.fBallResDto!.activationTime!),
                                style: GoogleFonts.notoSans(
                                  fontSize: 16,
                                  color: const Color(0xffcccccc),
                                  fontWeight: FontWeight.w700,
                                )))
                      ]))
                ]),
                Container(
                  margin: EdgeInsets.only(top: 21),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Icon(
                          ForutonaIcon.like,
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
                            "${widget.fBallResDto!.ballLikes} (${(model.ballLikePercent * 100).toStringAsFixed(0)}%)",
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
                ),
                Container(
                  margin: EdgeInsets.only(top: 21),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 8, 0),
                        child: Icon(
                          Icons.thumb_down,
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
                            "${widget.fBallResDto!.ballDisLikes} (${(model.ballDisLikePercent * 100).toStringAsFixed(0)}%)",
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
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class ID01BallPowerStateViewModel extends ChangeNotifier {
  final FBallResDto? fBallResDto;

  ID01BallPowerStateViewModel(this.fBallResDto);

  double get ballLikePercent {
    if ((fBallResDto!.ballLikes! +
        fBallResDto!.ballDisLikes!) ==
        0) {
      return 0;
    }
    return fBallResDto!.ballLikes! /
        (fBallResDto!.ballLikes! +
            fBallResDto!.ballDisLikes!);
  }
  double get ballDisLikePercent {
    if ((fBallResDto!.ballLikes! +
        fBallResDto!.ballDisLikes!) ==
        0) {
      return 0;
    }
    return fBallResDto!.ballDisLikes! /
        (fBallResDto!.ballLikes! +
            fBallResDto!.ballDisLikes!);
  }
}
