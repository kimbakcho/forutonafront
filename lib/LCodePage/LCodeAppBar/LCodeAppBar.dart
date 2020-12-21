import 'package:flutter/material.dart';
import 'package:forutonafront/Common/ProgressIndicator/CommonLinearProgressIndicator.dart';
import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'TailButton.dart';

class LCodeAppBar extends StatelessWidget {
  final Function onTailButtonClick;

  final String tailButtonLabel;

  final bool enableTailButton;

  final double progressValue;

  const LCodeAppBar(
      {Key key,
      this.onTailButtonClick,
      this.tailButtonLabel,
      this.enableTailButton, this.progressValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: BorderCircleBackButton(),
          ),
          Text(
            '이용약관 동의',
            style: GoogleFonts.notoSans(
              fontSize: 16,
              color: const Color(0xff000000),
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
          Spacer(),
          Container(
            margin: EdgeInsets.only(right: 16),
            child: TailButton(
              enable: enableTailButton,
              label: tailButtonLabel,
            ),
          ),
        ]),
        SizedBox(
          height: 10,
        ),
        CommonLinearProgressIndicator(progressValue)
      ],
    );
  }
}
