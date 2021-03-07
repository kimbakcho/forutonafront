import 'package:flutter/material.dart';
import 'package:forutonafront/Page/LCodePage/L003/L003MainPage.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TermsTextLink extends StatelessWidget {
  final String label;

  final int termsIdx;

  final bool gotoPageFlag;

  TermsTextLink(
      {Key key,
      @required this.label,
      @required this.termsIdx, this.gotoPageFlag=true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TermsTextLinkViewModel(),
        child: Consumer<TermsTextLinkViewModel>(builder: (_, model, child) {
          return Container(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        if(gotoPageFlag){
                          Navigator.of(context).push(MaterialPageRoute(builder: (_){
                            return L003MainPage(termsIdx: this.termsIdx);
                          }));
                        }
                      },
                      child: Text(
                        label,
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: const Color(0xff000000),
                          letterSpacing: 0.28,
                          decoration: TextDecoration.underline,
                        ),
                        textAlign: TextAlign.left,
                      ))));
        }));
  }
}

class TermsTextLinkViewModel extends ChangeNotifier {

}
