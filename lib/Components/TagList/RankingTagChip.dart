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
            color: const Color(0xff454f63),
            fontWeight: FontWeight.w700,
          ),
          textAlign: TextAlign.left,
        ),
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffCCCCCC), width: 1),
          borderRadius: BorderRadius.all(Radius.circular(12))),
    );
  }
}
