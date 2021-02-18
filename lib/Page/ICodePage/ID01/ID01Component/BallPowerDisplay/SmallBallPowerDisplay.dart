import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SmallBallPowerDisplay extends StatelessWidget {
  final int ballPower;

  const SmallBallPowerDisplay({Key key, this.ballPower}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SmallBallPowerDisplayViewModel(),
      child: Consumer<SmallBallPowerDisplayViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.all(6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('${ballPower}',
                    style: GoogleFonts.notoSans(
                      fontSize: 18,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                      height: 1.1111111111111112,
                    )),
                Text(
                  'Ball Power',
                  style: GoogleFonts.notoSans(
                    fontSize: 10,
                    color: const Color(0xff78849e),
                    letterSpacing: -0.45999999999999996,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
                color: Color(0xffF6F6F6),
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          );
        },
      ),
    );
  }
}

class SmallBallPowerDisplayViewModel extends ChangeNotifier {}
