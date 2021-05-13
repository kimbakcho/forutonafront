import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QualifyingForQuestTextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QualifyingForQuestTextWidgetViewModel(),
      child: Consumer<QualifyingForQuestTextWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("퀘스트 참가자격",
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: const Color(0xff000000),
                      letterSpacing: -0.28,
                      fontWeight: FontWeight.w700,
                      height: 1.2142857142857142,
                    )),
                TextField(
                  decoration: InputDecoration(
                      hintText: "참가자격을 알려주세요!",
                      hintStyle: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xffb1b1b1),
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w300,
                        height: 1.2142857142857142,
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class QualifyingForQuestTextWidgetViewModel extends ChangeNotifier {}
