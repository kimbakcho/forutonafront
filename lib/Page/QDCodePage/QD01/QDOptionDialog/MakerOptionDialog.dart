import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class MakerOptionDialog extends StatelessWidget {
  final Function? onModify;

  final Function? onDelete;

  MakerOptionDialog({this.onModify, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MakerOptionDialogViewModel(),
      child: Consumer<MakerOptionDialogViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffE4E7E8)),
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                width: 221,
                height: 150,
                child: Column(
                  children: [
                    TextButton(
                        onPressed: () {
                          if (onModify != null) {
                            onModify!();
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0xffE4E7E8)))),
                          height: 48,
                          width: 221,
                          alignment: Alignment.center,
                          child: Text(
                            '수정하기',
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff3a3e3f),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          if (onDelete != null) {
                            onDelete!();
                          }
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom:
                                      BorderSide(color: Color(0xffE4E7E8)))),
                          height: 48,
                          width: 221,
                          alignment: Alignment.center,
                          child: Text(
                            '삭제하기',
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff3a3e3f),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.zero),
                        ),
                        child: Container(
                          height: 48,
                          width: 221,
                          alignment: Alignment.center,
                          child: Text(
                            '닫기',
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff3a3e3f),
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class MakerOptionDialogViewModel extends ChangeNotifier {}
