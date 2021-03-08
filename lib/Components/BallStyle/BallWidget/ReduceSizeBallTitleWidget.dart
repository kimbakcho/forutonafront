import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/Components/UserProfileImageWidget/UserProfileImageWidget.dart';
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
      UserProfileImageWidget(
        height: 33,
        width: 33,
        imageUrl: issueBallDisPlayUseCase.profilePictureUrl(),
      ),
      SizedBox(width: 7),
      Expanded(
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(issueBallDisPlayUseCase.ballName(),
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
