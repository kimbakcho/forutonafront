import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class H007BallSearchBtn extends StatelessWidget {
  final Function onSearch;
  const H007BallSearchBtn({
    Key key, this.onSearch,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width - 32,
      child: FlatButton(
          onPressed: () {
            this.onSearch();
          },
          child: Text(
            '이 근처의 볼을 검색합니다.',
            style: GoogleFonts.notoSans(
              fontSize: 14,
              color: const Color(0xfff9f9f9),
              fontWeight: FontWeight.w500,
            ),
          )),
      decoration: BoxDecoration(
          color: Color(0xff3497FD),
          border: Border.all(color: Color(0xff4F72FF)),
          borderRadius: BorderRadius.all(Radius.circular(30.0)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.16),
            offset: Offset(0,3),
            blurRadius: 6
          )
        ]
      ),
    );
  }
}