import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleCollectEmptyBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child:  Row(
        children: [
          Expanded(
            child: Text("조회된 결과가 없습니다",
                style: GoogleFonts.notoSans(
                  fontSize: 12,
                  color: const Color(0xff454f63),
                  letterSpacing: -0.24,
                  height: 1.6666666666666667,
                )),
          )
        ],
      ),
      padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(8),bottomLeft: Radius.circular(8))
      ),
    );
  }
}
