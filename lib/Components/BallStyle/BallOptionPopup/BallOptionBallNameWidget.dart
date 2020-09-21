import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BallOptionBallNameWidget extends StatelessWidget {
  final String ballName;

  const BallOptionBallNameWidget({Key key, this.ballName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
      height: 63,
      child: Center(
        child: Text(ballName,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: const Color(0xff2f3035),
              fontWeight: FontWeight.w700,
              height: 1.0714285714285714,
            )),
      ),
    );
  }
}
