import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';

class IMB001TopAppBar extends StatelessWidget {
  const IMB001TopAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            constraints: BoxConstraints(),
            padding: EdgeInsets.all(0),
            child: Icon(Icons.clear,color: Color(0xff454f63),),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          Expanded(
            child: Container(
              child: Text("위치",
                  style: GoogleFonts.notoSans(
                    fontSize: 20,
                    color: const Color(0xff454f63),
                    letterSpacing: -0.4,
                    fontWeight: FontWeight.w700,
                    height: 1.3,
                  )),
            ),
          )

        ],
      ),
    );
  }
}
