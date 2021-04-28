import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BallMakeButton extends StatelessWidget {
  final ImageProvider? leftImage;
  final String? ballName;
  final Icon? icon;
  final Color? mainColor;
  final String? text;
  final Function? onTap;

  const BallMakeButton(
      {Key? key,
      this.leftImage,
      this.ballName,
      this.icon,
      this.mainColor,
      this.text, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => BallMakeButtonViewModel(),
      child: Consumer<BallMakeButtonViewModel>(
        builder: (_, model, child) {
          return Material(
            color: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
            child: InkWell(
              customBorder: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
              onTap: (){
                onTap!();
              },
              child: Container(
                decoration: BoxDecoration(

                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints.tightForFinite(width: 50),
                      decoration:
                      BoxDecoration(image: DecorationImage(image: leftImage!)),
                    ),
                    Expanded(
                        child: Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 16, 16),
                          child: Column(
                            children: [
                              Row(children: [
                                Expanded(
                                    child: Text(ballName!,
                                        style: GoogleFonts.notoSans(
                                          fontSize: 12,
                                          color: mainColor,
                                          fontWeight: FontWeight.w700,
                                        ))),
                                Container(
                                  width: 18,
                                  height: 18,
                                  child: icon,
                                  decoration: BoxDecoration(
                                      color: mainColor, shape: BoxShape.circle),
                                )
                              ]),
                              Expanded(
                                  child: Container(
                                      child: Text(text!,
                                          style: GoogleFonts.notoSans(
                                            fontSize: 14,
                                            color: const Color(0xff2f3035),
                                            letterSpacing: -0.28,
                                            fontWeight: FontWeight.w700,
                                            height: 1.2857142857142858,
                                          ))))
                            ],
                          ),
                        ))
                  ],
                ),
              ),
            ),
          )

            ;
        },
      ),
    );
  }
}

class BallMakeButtonViewModel extends ChangeNotifier {}
