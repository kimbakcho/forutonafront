import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class KCodeDrawerBottom extends StatelessWidget {
  const KCodeDrawerBottom({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(bottom: 16),
              color: Colors.white,
              child: RawMaterialButton(
                elevation: 0,
                constraints: BoxConstraints(minWidth: 72,minHeight: 42),
                fillColor: Color(0xffE4E7E8),
                onPressed: (){
                  Navigator.of(context).pop();
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Text("닫 기",
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: const Color(0xff2f3035),
                    fontWeight: FontWeight.w500,
                  ),),
              )),
        )
      ],
    );
  }
}