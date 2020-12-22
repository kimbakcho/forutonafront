import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:google_fonts/google_fonts.dart';

class ReduceSizeBallTitleWidget extends StatelessWidget {
  const ReduceSizeBallTitleWidget({
    Key key,
    @required this.issueBallDisPlayUseCase,
  }) : super(key: key);

  final BallDisPlayUseCase issueBallDisPlayUseCase;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                    issueBallDisPlayUseCase
                        .profilePictureUrl()))),
        width: 33,
        height: 33,
      ),
      SizedBox(width: 7),
      Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                  issueBallDisPlayUseCase.ballName(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w700,
                    height: 1.3333333333333333,
                  ))))
    ]);
  }
}