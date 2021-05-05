import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhotoCertificationWithCheckInWidget extends StatelessWidget {
  final Function()? onTap;

  PhotoCertificationWithCheckInWidget({this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PhotoCertificationWithCheckInWidgetViewModel(),
      child: Consumer<PhotoCertificationWithCheckInWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            child: OutlinedButton(
                style: ButtonStyle(
                    padding: MaterialStateProperty.all(EdgeInsets.fromLTRB(8, 6, 8, 6)),
                    side: MaterialStateProperty.all(BorderSide(width: 2,color: Colors.black)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        side: BorderSide(width: 1,color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                    backgroundColor:
                    MaterialStateProperty.all(Color(0xffF6F6F6))),
                onPressed: () {
                  if (onTap != null) {
                    onTap!();
                  }
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Icon(
                        ForutonaIcon.picture2,
                        color: Colors.white,
                        size: 14,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black,
                      ),
                      width: 34,
                      height: 34,
                    ),
                    Expanded(
                        child: Container(
                          margin: EdgeInsets.only(left: 6),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "체크인+인증샷",
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff000000),
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4166666666666667,
                                ),
                              ),
                              Text(
                                "참가자가 특정 위치에서 체크인 후, 사진을 전송해서\n퀘스트 완료를 인증합니다.",
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff3a3e3f),
                                  letterSpacing: -0.24,
                                  height: 1.4166666666666667,
                                ),
                              )
                            ],
                          ),
                        ))
                  ],
                )),
          );
        },
      ),
    );
  }
}

class PhotoCertificationWithCheckInWidgetViewModel extends ChangeNotifier {}
