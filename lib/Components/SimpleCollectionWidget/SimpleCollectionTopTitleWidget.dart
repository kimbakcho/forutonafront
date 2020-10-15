import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SimpleCollectionTopTitleWidget extends StatelessWidget {
  final String searchText;

  const SimpleCollectionTopTitleWidget({Key key, this.searchText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
      ),
      child: Container(
        padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1,color: Color(0xffE4E7E8)))
        ),
        child: Row(
          children: [
            Expanded(
              child: RichText(
                text: TextSpan(
                    text: "\"$searchText\"",
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff3497fd),
                      fontWeight: FontWeight.w700,
                    ),
                    children: [
                      TextSpan(
                          text: "관련 닉네임",
                          style: GoogleFonts.notoSans(
                            fontSize: 12,
                            color: const Color(0xff454f63),
                            fontWeight: FontWeight.w500,
                          ))
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
