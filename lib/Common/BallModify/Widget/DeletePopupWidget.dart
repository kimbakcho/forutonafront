import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CommonBallModifyWidgetResultType.dart';

class DeletePopupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
      child: Container(
        height: 170.00,
        width: 332.00,
        child: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
                child: Text("Ball 삭제",
                    style: GoogleFonts.notoSans(
                      fontSize: 20,
                      color: Color(0xff000000),
                    ))),
            Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 16),
                alignment: Alignment.center, child: Text("정말로 삭제하시겠습니까?")),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    height: 32.00,
                    width: 120.00,
                    child: FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();

                      },
                      child: Text("취소",
                          style: GoogleFonts.notoSans(
                            fontSize: 15,
                            color: Color(0xff454f63),
                          )),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      border: Border.all(
                        width: 1.00,
                        color: Color(0xff454f63),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0.00, 12.00),
                          color: Color(0xff455b63).withOpacity(0.08),
                          blurRadius: 16,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(5.00),
                    ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  height: 32.00,
                  width: 120.00,
                  child: FlatButton(
                    onPressed: (){
                      Navigator.of(context).pop(CommonBallModifyWidgetResultType.Delete);
                    },
                    child: Text("삭제",
                        style: GoogleFonts.notoSans(
                          fontSize: 15,
                          color: Color(0xff454f63),
                        )),
                  ),
                  decoration: BoxDecoration(
                    color: Color(0xffffffff),
                    border: Border.all(
                      width: 1.00,
                      color: Color(0xff454f63),
                    ),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0.00, 12.00),
                        color: Color(0xff455b63).withOpacity(0.08),
                        blurRadius: 16,
                      ),
                    ],
                    borderRadius: BorderRadius.circular(5.00),
                  ),
                )
              ],
            )
          ],
        ),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          border: Border.all(
            width: 1.00,
            color: Color(0xff000000),
          ),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 3.00),
              color: Color(0xff000000).withOpacity(0.16),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.circular(10.00),
        ),
      ),
    ));
  }
}
