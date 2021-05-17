import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/BallAction/QuestBall/QuestBallParticipantResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Components/UserProfileBar/UserInfoAvatar.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ParticipantInfoBar extends StatelessWidget {
  final QuestBallParticipantResDto questBallParticipantResDto;

  final Function()? onAcceptParticipation;

  final Function()? onDeleteParticipation;

  ParticipantInfoBar(
      {required this.questBallParticipantResDto,
      this.onAcceptParticipation,
      this.onDeleteParticipation});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParticipantInfoBarViewModel(),
      child: Consumer<ParticipantInfoBarViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Row(
              children: [
                UserInfoAvatar(
                    fUserInfoSimpleResDto: questBallParticipantResDto.uid!),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      questBallParticipantResDto.uid!.nickName!,
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: const Color(0xff000000),
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w500,
                        height: 1.4166666666666667,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      '참가시간 : ${TimeDisplayUtil.getCalcToStrFromNow(questBallParticipantResDto.participationTime!)}',
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: const Color(0xff3a3e3f),
                        letterSpacing: -0.24,
                        height: 1.4166666666666667,
                      ),
                      textAlign: TextAlign.left,
                    )
                  ],
                )),
                onAcceptParticipation != null
                    ? Container(
                        height: 21,
                        // margin: EdgeInsets.only(right: 16),
                        child: TextButton(
                          onPressed: () {
                            if (onAcceptParticipation != null) {
                              onAcceptParticipation!();
                            }
                          },
                          style: ButtonStyle(
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.zero),
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffE9FFFE)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                      side: BorderSide(
                                          color: Color(0xff00B2AC))))),
                          child: Text(
                            "참가승인",
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              color: const Color(0xff00b2ac),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                onDeleteParticipation != null
                    ? Container(
                        height: 21,
                        child: TextButton(
                          onPressed: () {
                            if (onDeleteParticipation != null) {
                              onDeleteParticipation!();
                            }
                          },
                          style: ButtonStyle(
                              padding:
                              MaterialStateProperty.all(EdgeInsets.zero),

                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xffFFE8F2)),
                              shape: MaterialStateProperty.all(CircleBorder(
                                  side: BorderSide(color: Color(0xffFF4F9A))))),
                          child: Icon(
                            Icons.close,
                            color: Color(0xffFF4F9A),
                            size: 12,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}

class ParticipantInfoBarViewModel extends ChangeNotifier {}
