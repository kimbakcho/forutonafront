import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:google_fonts/google_fonts.dart';

class ReduceSizeAddressBar extends StatelessWidget {
  const ReduceSizeAddressBar({
    Key key,
    @required this.issueBallDisPlayUseCase,
  }) : super(key: key);

  final BallDisPlayUseCase issueBallDisPlayUseCase;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            child: Icon(
              Icons.location_on,
              size: 10,
              color: Color(0xffB1B1B1),
            )),
        Expanded(
          child: Text(
            issueBallDisPlayUseCase.placeAddress(),
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.notoSans(
              fontSize: 11,
              color: const Color(0xffb1b1b1),
              letterSpacing: -0.22,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}