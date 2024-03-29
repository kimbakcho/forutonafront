import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Common/TimeUitl/TimeDisplayUtil.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/BallPowerDisplay/SmallBallPowerDisplay.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


import '../DBallMode.dart';
import 'DBallLimitTag.dart';

class DBallTitle extends StatelessWidget {
  final FBallResDto? fBallResDto;

  final DBallMode? dBallMode;

  final List<FBallTagResDto>? preViewfBallTagResDtos;

  const DBallTitle({Key? key, this.fBallResDto, this.dBallMode, this.preViewfBallTagResDtos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DBallTitleViewModel(fBallResDto),
      child: Consumer<DBallTitleViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 16),
            child: Column(
              children: [
                DLimitTag(ballUuid: model.fBallResDto!.ballUuid,mode: dBallMode,preViewfBallTagResDtos: preViewfBallTagResDtos),
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.only(top: 3),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(model.fBallResDto!.ballName!,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.notoSans(
                              fontSize: 16,
                              color: const Color(0xff000000),
                              fontWeight: FontWeight.w500,
                              height: 1.25,
                            )),
                        SizedBox(height: 6),
                        Row(
                          children: [
                            Text(
                              model.ballInfo,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.notoSans(
                                fontSize: 12,
                                color: const Color(0xff5b5b5b),
                              ),
                              textAlign: TextAlign.left,
                            )
                          ],
                        )
                      ],
                    ),
                  )),
                  SmallBallPowerDisplay(
                    ballPower: model.fBallResDto!.ballPower,
                  )
                ])
              ],
            ),
          );
        },
      ),
    );
  }
}

class DBallTitleViewModel extends ChangeNotifier {
  final FBallResDto? fBallResDto;

  DBallTitleViewModel(this.fBallResDto);

  String get ballInfo{
    return '조회수 ${fBallResDto!.ballHits} • 댓글수 ${fBallResDto!.replyCount} • ${TimeDisplayUtil.getCalcToStrFromNow(fBallResDto!.makeTime!)}$isEditText';
  }

  String get isEditText {
    if(fBallResDto!.isEditContent!){
      return "(edited)";
    }else {
      return "";
    }
  }

}
