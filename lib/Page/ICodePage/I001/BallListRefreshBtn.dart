import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BallListRefreshBtn extends StatelessWidget {
  final Function onRefresh;

  const BallListRefreshBtn({Key key, this.onRefresh}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 145,
        height: 36,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.16),
              offset: Offset(0,3),
              blurRadius: 6
            )
          ]
        ),
        child: Material(
            color: Colors.white.withOpacity(0.9),
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            child: InkWell(
                onTap: () {
                  if (onRefresh != null) {
                    onRefresh();
                  }
                },
                child: Row(children: [
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    child:
                        Icon(Icons.refresh, color: Color(0xff454F63), size: 15),
                  ),
                  SizedBox(width: 4),
                  Container(
                      child: Text("이 지역 다시 검색",
                          style: GoogleFonts.notoSans(
                            fontSize: 12,
                            color: const Color(0xff454f63),
                            fontWeight: FontWeight.w700,
                          )))
                ]))));
  }
}
