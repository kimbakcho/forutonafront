import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QTimeLimitWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QTimeLimitWidgetViewModel(),
      child: Consumer<QTimeLimitWidgetViewModel>(
        builder: (_, model, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  '제한시간',
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.only(left: 16),
                child: Text(
                  '참가자는 설정된 시간 안에 퀘스트를 완료해야 합니다.',
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff7a7a7a),
                    letterSpacing: -0.24,
                    height: 1.1666666666666667,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 16),
                  TextButton(
                      style: model.getBtnStyle(
                          model.currentMode == LimitTimeBtnSelectMode.MIN30),
                      onPressed: () {
                        model.selectBtn(LimitTimeBtnSelectMode.MIN30);
                      },
                      child: Container(child: Text("30분",style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                        fontWeight: FontWeight.w500,
                      ),))),
                  SizedBox(width: 16),
                  TextButton(
                      style: model.getBtnStyle(
                          model.currentMode == LimitTimeBtnSelectMode.MIN60),
                      onPressed: () {
                        model.selectBtn(LimitTimeBtnSelectMode.MIN60);
                      },
                      child: Container(child: Text("1시간",style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                        fontWeight: FontWeight.w500,
                      )))),
                  SizedBox(width: 16),
                  TextButton(
                      style: model.getBtnStyle(
                          model.currentMode == LimitTimeBtnSelectMode.MIN120),
                      onPressed: () {
                        model.selectBtn(LimitTimeBtnSelectMode.MIN120);
                      },
                      child: Container(child: Text("2시간",style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                        fontWeight: FontWeight.w500,
                      )))),
                  SizedBox(width: 16),
                  TextButton(
                      style: model.getBtnStyle(
                          model.currentMode == LimitTimeBtnSelectMode.Custom),
                      onPressed: () {
                        model.selectBtn(LimitTimeBtnSelectMode.Custom);
                      },
                      child: Container(child: Text("직접설정",style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                        fontWeight: FontWeight.w500,
                      )))),
                ],
              )
            ],
          );
        },
      ),
    );
  }
}

enum LimitTimeBtnSelectMode { MIN30, MIN60, MIN120, Custom }

class QTimeLimitWidgetViewModel extends ChangeNotifier {
  LimitTimeBtnSelectMode currentMode = LimitTimeBtnSelectMode.MIN30;

  selectBtn(LimitTimeBtnSelectMode mode){
    this.currentMode = mode;
    notifyListeners();

  }

  ButtonStyle? getBtnStyle(bool selected) {
    return ButtonStyle(
        side: selected
            ? MaterialStateProperty.all(
                BorderSide(width: 2, color: Colors.black))
            : MaterialStateProperty.all(
                BorderSide(width: 2, color: Color(0xffF6F6F6))),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)))),
        backgroundColor: MaterialStateProperty.all(Color(0xffF6F6F6)));
  }
}
