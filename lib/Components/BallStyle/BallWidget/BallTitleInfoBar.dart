import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallDisPlayUseCase/BallDisPlayUseCase.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';

class BallTitleInfoBar extends StatelessWidget {
  const BallTitleInfoBar({
    Key key,
    @required this.ballDisPlayUseCase,
    @required this.gotoDetailPage
  }) : super(key: key);
  final BallDisPlayUseCase ballDisPlayUseCase;
  final Function gotoDetailPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(12, 12, 0, 12),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(
                        ballDisPlayUseCase.profilePictureUrl()))),
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
                                child: Text(
                                    ballDisPlayUseCase.ballName(),
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
                                          '${ballDisPlayUseCase.ballHits()}회  •  ${ballDisPlayUseCase.remainTime()}',
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
                onTap: () {},
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
