import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class QuestSuccessSelect extends StatelessWidget {
  final Function()? onTap;

  QuestSuccessSelect({this.onTap});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          QuestSuccessSelectViewModel(
          ),
      child: Consumer<QuestSuccessSelectViewModel>(
        builder: (_, model, child) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                  onPressed: () {
                    if (onTap != null) {
                      onTap!();
                    }
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      backgroundColor:
                      MaterialStateProperty.all(Color(0xffF6F6F6)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(15))))),
                  child: Container(
                    child: Text(
                      '여기를 눌러 퀘스트 완료조건을 선택해주세요',
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                        letterSpacing: -0.28,
                        fontWeight: FontWeight.w500,
                        height: 1.2142857142857142,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    alignment: Alignment.center,
                    height: 46,
                    constraints: BoxConstraints(
                        minWidth: double.infinity, maxWidth: double.infinity),
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  ))
            ],
          );
        },
      ),
    );
  }
}

class QuestSuccessSelectViewModel extends ChangeNotifier {
}
