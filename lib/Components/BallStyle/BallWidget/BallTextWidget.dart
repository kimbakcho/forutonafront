import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BallTextTagListBar.dart';

class BallTextWidget extends StatelessWidget {
  const BallTextWidget(
      {Key key,
      @required this.ballDisPlayUseCase,
      @required this.gotoDetailPage})
      : super(key: key);
  final BallDisPlayUseCase ballDisPlayUseCase;
  final Function gotoDetailPage;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(12, 0, 28, 12),
        child: Material(
          color: Colors.white,
            child: InkWell(
                onTap: () {
                  gotoDetailPage();
                },
                child: Column(children: <Widget>[
                  Row(children: <Widget>[
                    Flexible(
                        child: Text(
                      ballDisPlayUseCase.descriptionText(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff5b5b5b),
                        letterSpacing: -0.28,
                        height: 1.2142857142857142,
                      ),
                      textAlign: TextAlign.left,
                    ))
                  ]),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: BallTextTagListBar(
                            ballUuid: ballDisPlayUseCase.ballUuid()),
                      )
                    ],
                  )
                ]))));
  }
}
