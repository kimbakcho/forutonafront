import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QuestActionDialog extends StatelessWidget {
  final String title;

  final String content;

  final Color activeColor;

  final String activeText;

  final Size size;

  final Function? onAgree;

  QuestActionDialog(
      {required this.title,
      required this.content,
      required this.activeColor,
      required this.activeText,
      required this.size,
      this.onAgree});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QuestActionDialogViewModel(),
      child: Consumer<QuestActionDialogViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                height: size.height,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(title,
                          style: GoogleFonts.notoSans(
                            fontSize: 20,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                            height: 2.25,
                          )),
                    )
                    ,
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text(content,
                          style: GoogleFonts.notoSans(
                            fontSize: 14,
                            color: const Color(0xff3a3e3f),
                            fontWeight: FontWeight.w300,
                            height: 1.5714285714285714,
                          )),
                    )
                    ,
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border(
                              top: BorderSide(color: Color(0xffE4E7E8), width: 1))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      right: BorderSide(
                                          color: Color(0xffE4E7E8), width: 1))),
                              child: TextButton(
                                  onPressed: () {
                                    if(onAgree != null){
                                      onAgree!();
                                    }
                                  },
                                  child: Text(activeText,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 13,
                                        color: activeColor,
                                        fontWeight: FontWeight.w700,
                                        height: 1.5384615384615385,
                                      ))),
                            ),
                          ),
                          Expanded(
                              child: Container(
                                child: TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("닫기",
                                      style: GoogleFonts.notoSans(
                                        fontSize: 13,
                                        color: const Color(0xffff4f9a),
                                        fontWeight: FontWeight.w700,
                                        height: 1.5384615384615385,
                                      )),
                                ),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
            ,
          )
            ;
        },
      ),
    );
  }
}

class QuestActionDialogViewModel extends ChangeNotifier {}
