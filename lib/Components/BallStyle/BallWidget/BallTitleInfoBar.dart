import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/Components/UserProfileImageWidget/UserProfileImageWidget.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class BallTitleInfoBar extends StatelessWidget {
  const BallTitleInfoBar({
    Key key,
    @required this.ballDisPlayUseCase,
    @required this.gotoDetailPage,
    this.showOptionPopUp,
  }) : super(key: key);
  final BallDisPlayUseCase ballDisPlayUseCase;
  final Function gotoDetailPage;
  final Function showOptionPopUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
      child: Row(
        children: <Widget>[
          UserProfileImageWidget(
            height: 30,
            width: 30,
            imageUrl: ballDisPlayUseCase.profilePictureUrl(),
          ),
          SizedBox(width: 8),
          Expanded(
              child: Material(
                  color: Colors.white,
                  child: InkWell(
                      onTap: () {
                        gotoDetailPage();
                      },
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                                child: Text(ballDisPlayUseCase.ballName(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      fontWeight: FontWeight.w700,
                                      height: 1.4285714285714286,
                                    ))),
                            Row(
                              children: <Widget>[
                                Container(
                                  child: Text(
                                      ' ${ballDisPlayUseCase.makerNickName(maxLength: 10)} ',
                                      maxLines: 1,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 10,
                                        color: const Color(0xff78849e),
                                        fontWeight: FontWeight.w700,
                                      )),
                                ),
                                Container(
                                  child: Text(
                                      '• 조회수 '
                                      '${ballDisPlayUseCase.ballHits()}회  •  ${ballDisPlayUseCase.displayMakeTime()}',
                                      maxLines: 1,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 10,
                                        color: const Color(0xff78849e),
                                      )),
                                )
                              ],
                            )
                          ])))),
          Container(
            width: 30,
            height: 30,
            child: Material(
              color: Colors.white,
              child: InkWell(
                onTap: () {
                  showOptionPopUp();
                },
                child: Icon(
                  ForutonaIcon.dots,
                  color: Color(0xffB8B8B8),
                  size: 15,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
