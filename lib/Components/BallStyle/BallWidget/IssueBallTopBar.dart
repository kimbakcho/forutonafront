import 'package:flutter/material.dart';
import 'package:forutonafront/Components/BallIconWidget/IssueBallIconWidget.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/IssueBallDisPlayUseCase.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class IssueBallTopBar extends StatelessWidget {
  const IssueBallTopBar({
    Key? key,
    required this.ballDisPlayUseCase,
  }) : super(key: key);

  final IssueBallDisPlayUseCase ballDisPlayUseCase;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 8, 7),
      child: Row(
        children: <Widget>[
          IssueBallIconWidget(
            size: Size(18.0, 18.0),
            iconSize: 18,
          ),
          SizedBox(
            width: 7,
          ),
          Text(
            '이슈볼',
            style: GoogleFonts.notoSans(
              fontSize: 12,
              color: const Color(0xffdc3e57),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Spacer(),
          Icon(ForutonaIcon.influence_i001, color: Color(0xffF841D9), size: 10),
          SizedBox(
            width: 7,
          ),
          Text(
            '${ballDisPlayUseCase.ballPower()}BP',
            style: GoogleFonts.notoSans(
              fontSize: 12,
              color: const Color(0xfff841d9),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 12,
          ),
        ],
      ),
    );
      
      
  }
}