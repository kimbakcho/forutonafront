import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BallOptionButtonAction.dart';

class BallBasicOptionButton extends StatelessWidget {
  final String ballText;
  final Color textColor;
  final BallOptionButtonAction ballOptionButtonAction;
  final BorderRadiusGeometry borderRadiusGeometry;

  const BallBasicOptionButton(
      {Key key,
      this.ballText,
      this.ballOptionButtonAction,
      this.textColor = const Color(0xff3497FD), this.borderRadiusGeometry})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 49,
      child: FlatButton(
        onPressed: () async {
          if (ballOptionButtonAction != null) {
            await ballOptionButtonAction.execute();
          } else {
            throw UnimplementedError();
          }
          Navigator.of(context).pop();
        },
        child: Text(ballText,
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: textColor,
              fontWeight: FontWeight.w500,
            )),
      ),
      decoration: BoxDecoration(
        borderRadius: borderRadiusGeometry
      ),
    );
  }
}
