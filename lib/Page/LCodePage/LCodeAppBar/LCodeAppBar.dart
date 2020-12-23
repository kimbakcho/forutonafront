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

  final bool visibleTailButton;

  final double progressValue;

  final String title;

  const LCodeAppBar(
      {Key key,
      this.onTailButtonClick,
      this.tailButtonLabel,
      this.enableTailButton, this.progressValue, this.visibleTailButton = true, this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
            children: [
          Container(
            margin: EdgeInsets.only(left: 16, right: 16, top: 8),
            child: BorderCircleBackButton(),
          ),
          Container(
            margin: EdgeInsets.only(top: 8),
            child:Text(
              title,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ) ,
          )
          ,
          Spacer(),
          visibleTailButton ? Container(
            margin: EdgeInsets.only(right: 16),
            child: TailButton(
              enable: enableTailButton,
              label: tailButtonLabel,
              buttonClick: (){
                onTailButtonClick();
              },
            ),
          ): Container(),
        ]),
        SizedBox(
          height: 10,
        ),
        CommonLinearProgressIndicator(progressValue)
      ],
    );
  }
}
