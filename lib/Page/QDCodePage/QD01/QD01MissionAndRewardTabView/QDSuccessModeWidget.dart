import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'QDPointWidget.dart';

class QDSuccessModeWidget extends StatelessWidget {

  final String descriptionText;

  final bool hasCheckIn;

  final Position? checkInPosition;

  final String? checkInAddress;

  QDSuccessModeWidget({required this.descriptionText,required this.hasCheckIn,this.checkInPosition,this.checkInAddress});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDPhotoCertificationWidgetViewModel(),
      child: Consumer<QDPhotoCertificationWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 34,
                      width: 34,
                      decoration: BoxDecoration(
                          color: Colors.black, shape: BoxShape.circle),
                      child: Icon(
                        ForutonaIcon.camera1,
                        color: Colors.white,
                        size: 17,
                      ),
                    ),
                    Expanded(
                        child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '인증샷',
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
                            '사진을 보내 퀘스트 완료를 인증합니다.',
                            style: GoogleFonts.notoSans(
                              fontSize: 12,
                              color: const Color(0xff3a3e3f),
                              letterSpacing: -0.24,
                              height: 1.4166666666666667,
                            ),
                            textAlign: TextAlign.left,
                          )
                        ],
                      ),
                    ))
                  ],
                ),
                hasCheckIn?  SizedBox(
                  height: 16,
                ): Container(),
                hasCheckIn? QDPointWidget(
                    title: "체크인 장소",
                    icon: Icon(
                      ForutonaIcon.checkin2,
                      size: 16,
                      color: Color(0xff6B46FF),
                    ),
                    onTap: (position, address) {},
                    position: checkInPosition!,
                    address: checkInAddress!
                ):Container(),
                SizedBox(
                  height: 16,
                ),
                Text(
                  descriptionText,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff3a3e3f),
                    letterSpacing: -0.28,
                    height: 1.2857142857142858,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class QDPhotoCertificationWidgetViewModel extends ChangeNotifier {}
