import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BallDeletePopup extends StatelessWidget {

  final Function actionDelete;

  const BallDeletePopup({Key key, this.actionDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BallDeletePopupViewModel(),
      child: Consumer<BallDeletePopupViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                width: 328,
                height: 174,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text("이슈볼 삭제",
                              style: GoogleFonts.notoSans(
                                fontSize: 16,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                height: 2.75,
                              )),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 16),
                          child: Text("정말로 삭제하시겠습니까?",
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff3a3e3f),
                                fontWeight: FontWeight.w300,
                                height: 0.5714285714285714,
                              )),
                        )
                      ],
                    ),
                    Spacer(),
                    Divider(
                      height: 1,
                      color: Color(0xffE4E7E8),
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("취소",
                                  style: GoogleFonts.notoSans(
                                    fontSize: 15,
                                    color: const Color(0xff3a3e3f),
                                    fontWeight: FontWeight.w500,
                                    height: 1.3333333333333333,
                                  )),
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Color(0xffE4E7E8), width: 1))),
                            ),
                          ),
                        )),
                        Expanded(
                            child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              actionDelete();
                            },
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text("삭제",
                                  style: GoogleFonts.notoSans(
                                    fontSize: 15,
                                    color: const Color(0xffff4f9a),
                                    fontWeight: FontWeight.w500,
                                    height: 1.3333333333333333,
                                  )),
                            ),
                          ),
                        ))
                      ],
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: Colors.white),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BallDeletePopupViewModel extends ChangeNotifier {}
