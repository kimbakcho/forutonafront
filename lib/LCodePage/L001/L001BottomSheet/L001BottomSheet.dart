import 'package:flutter/material.dart';
import 'package:forutonafront/Components/CloseButton/BottomSheetCloseButton.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L001BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L001BottomSheetViewModel(),
        child: Consumer<L001BottomSheetViewModel>(builder: (_, model, child) {
          return Container(
            height: MediaQuery.of(context).size.height -
                MediaQuery.of(context).padding.top -
                16,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            child: Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [BottomSheetCloseButton()],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    '로그인',
                    style: GoogleFonts.notoSans(
                      fontSize: 24,
                      color: const Color(0xff000000),
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
          );
        }));
  }
}

class L001BottomSheetViewModel extends ChangeNotifier {}
