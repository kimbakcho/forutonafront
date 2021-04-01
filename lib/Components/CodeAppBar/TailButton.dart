import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TailButton extends StatelessWidget {
  final bool enable;

  final String label;

  final Function buttonClick;

  const TailButton({Key key, this.enable, this.label, this.buttonClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          if (enable) {
            buttonClick();
          }
        },
        customBorder: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: Container(
          width: 75,
          height: 32,
          child: Center(
            child: Text(
              label,
              style: GoogleFonts.notoSans(
                fontSize: 13,
                color: enable ? Color(0xff000000) : Color(0xffd4d4d4),
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: enable ? Colors.white : Color(0xffF6F6F6),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
                width: enable ? 1 : 0,
                color: enable ? Color(0xff000000) : Color(0xffF6F6F6)),
            boxShadow: enable
                ? [
                    BoxShadow(
                      color: const Color(0x14455b63),
                      offset: Offset(0, 12),
                      blurRadius: 16,
                    ),
                  ]
                : [],
          ),
        ),
      ),
    );
  }
}
