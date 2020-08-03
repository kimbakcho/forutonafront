import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ID001MainPage2ViewModel.dart';

class ID001Title extends StatelessWidget {
  final String ballTitle;
  final String hits;
  final String makeTime;
  const ID001Title({Key key,
    this.ballTitle,
    this.hits,
    this.makeTime
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              '이슈볼',
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: const Color(0xffdc3e57),
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Text(
              ballTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.notoSans(
                fontSize: 18,
                color: const Color(0xff000000),
                fontWeight: FontWeight.w700,
                height: 1.3888888888888888,
              ),
              textAlign: TextAlign.left,
            ),
          ),
          Container(
            child: Text(
              "조회수 "+hits+"회 • 등록일자 "+makeTime,
              style: GoogleFonts.notoSans(
                fontSize: 12,
                color: const Color(0xff78849e),
              ),
              textAlign: TextAlign.left,
            ),
          )
        ],
      ),
    );
  }
}