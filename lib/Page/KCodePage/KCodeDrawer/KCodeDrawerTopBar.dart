import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KCodeDrawerTopBar extends StatelessWidget {
  const KCodeDrawerTopBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Container(
              padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: Text(
                "정렬 방식",
                style: GoogleFonts.notoSans(
                  fontSize: 14,
                  color: const Color(0xff2f3035),
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))),
            ),
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(width: 1, color: Color(0xffCCCCCC)))),
          ),
        )
      ],
    );
  }
}
