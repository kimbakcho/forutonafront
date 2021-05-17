import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class QDLimitTimeWidget extends StatelessWidget {

  final int seconds;


  QDLimitTimeWidget({required this.seconds});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDLimitTimeWidgetViewModel(
        seconds: seconds
      ),
      child: Consumer<QDLimitTimeWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                  Text(
                    '제한시간',
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: const Color(0xff000000),
                      letterSpacing: -0.28,
                      fontWeight: FontWeight.w700,
                      height: 1.2142857142857142,
                    ),
                    textAlign: TextAlign.left,
                  ),

                Text(
                  model.getLimitTimeStr,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff5c5d5f),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                  textAlign: TextAlign.right,
                )
              ],
            ),
            decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(color: Color(0xffE4E7E8), width: 1))),
          );
        },
      ),
    );
  }
}

class QDLimitTimeWidgetViewModel extends ChangeNotifier {

  final int seconds;


  QDLimitTimeWidgetViewModel({required this.seconds});

  String get getLimitTimeStr{
    return _printDuration(Duration(seconds: seconds));
  }


  String _printDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

}
