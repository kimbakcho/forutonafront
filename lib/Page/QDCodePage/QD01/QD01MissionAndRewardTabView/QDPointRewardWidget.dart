import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QDPointRewardWidget extends StatelessWidget {
  final int influenceRewardPoint;

  final int rewardPoint;

  QDPointRewardWidget(
      {required this.influenceRewardPoint, required this.rewardPoint});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => QDPointRewardWidgetViewModel(),
        child:
            Consumer<QDPointRewardWidgetViewModel>(builder: (_, model, child) {
          return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(color: Color(0xffE4E7E8), width: 1))),
              child: Column(children: [
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xffF2F3F5),
                      ),
                      child: Icon(ForutonaIcon.zap_1, color: Color(0xffF841D9),size: 16,),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        '영향력 보상',
                        style: GoogleFonts.notoSans(
                          fontSize: 12,
                          color: const Color(0xff3a3e3f),
                          letterSpacing: -0.24,
                          fontWeight: FontWeight.w500,
                          height: 1.4166666666666667,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '$influenceRewardPoint U',
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xfff841d9),
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w700,
                        height: 1.2142857142857142,
                      ),
                      textAlign: TextAlign.right,
                    )
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Row(children: [
                  Container(
                    height: 34,
                    width: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xffF2F3F5),
                    ),
                    child: Icon(ForutonaIcon.coin_1, color: Color(0xff00B2AC),size: 16),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text(
                      '포인트 보상',
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: const Color(0xff3a3e3f),
                        letterSpacing: -0.24,
                        fontWeight: FontWeight.w500,
                        height: 1.4166666666666667,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Spacer(),
                  Text(
                    '$rewardPoint NA',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: const Color(0xff00B2AC),
                      letterSpacing: -0.28,
                      fontWeight: FontWeight.w700,
                      height: 1.2142857142857142,
                    ),
                    textAlign: TextAlign.right,
                  )
                ])
              ]));
        }));
  }
}

class QDPointRewardWidgetViewModel extends ChangeNotifier {}
