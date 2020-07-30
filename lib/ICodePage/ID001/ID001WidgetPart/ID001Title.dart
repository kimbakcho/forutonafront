import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

import '../ID001MainPage2ViewModel.dart';

class ID001Title extends StatelessWidget {
  const ID001Title({Key key, this.model}) : super(key: key);

  final ID001MainPage2ViewModel model;

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
              model.getBallTitle(),
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
          )
        ],
      ),
    );
  }
}