import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class ReduceSizeTopBar extends StatelessWidget {
  final BallDisPlayUseCase? issueBallDisPlayUseCase;

  const ReduceSizeTopBar({Key? key, this.issueBallDisPlayUseCase})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        child: Text("이슈볼",
            style: GoogleFonts.notoSans(
              fontSize: 12,
              color: const Color(0xffdc3e57),
              fontWeight: FontWeight.w700,
            )),
      ),
      SizedBox(
        width: 15,
      ),
      Expanded(
        child: Container(
          child: Text(issueBallDisPlayUseCase!.displayMakeTime(),
              style: GoogleFonts.notoSans(
                fontSize: 12,
                color: const Color(0xff78849e),
              )),
        ),
      ),
      Container(
        child: Icon(ForutonaIcon.influence_i001, color: Color(0xffF841D9), size: 15),
      ),
      SizedBox(
        width: 10,
      ),
      Container(
          child: Text(issueBallDisPlayUseCase!.ballPower()+" BP",
              style: GoogleFonts.notoSans(
                fontSize: 12,
                color: const Color(0xfff841d9),
                fontWeight: FontWeight.w700,
              )))
    ]);
  }
}
