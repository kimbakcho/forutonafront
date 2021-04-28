import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class H008SearchEmptyRow extends StatelessWidget {
  const H008SearchEmptyRow({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Expanded(
              child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
                  child: Text("조회된 결과가 없습니다.",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff454f63),
                        letterSpacing: -0.28,
                        height: 1.4285714285714286,
                      ))))
        ],
      )
    ]);
  }
}