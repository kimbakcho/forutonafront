import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RankingTagChip extends StatelessWidget {
  final String tagName;

  RankingTagChip({Key key, @required this.tagName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 0,maxWidth: 120),
      margin: EdgeInsets.only(left: 16),
      child:RawMaterialButton(
        padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
        constraints: BoxConstraints(),
        onPressed: () {},
        child: Text(
          '#$tagName',
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: const Color(0xff5c5d5f),
            fontWeight: FontWeight.w500,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      decoration: BoxDecoration(
          color: Color(0xffF4F2F6),

          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
