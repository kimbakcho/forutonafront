import 'package:flutter/material.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Domain/UseCase/TermsConditionsUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TermsTextLink extends StatelessWidget {
  final String label;

  final String linkTitle;

  final int idx;

  TermsTextLink(
      {Key key,
      @required this.label,
      @required this.idx,
      @required this.linkTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => TermsTextLinkViewModel(this.linkTitle, this.idx, sl()),
        child: Consumer<TermsTextLinkViewModel>(builder: (_, model, child) {
          return Container(
              child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      onTap: () {
                        //TODO 여기서 부터 개발
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
  final String linkTitle;

  final int idx;

  final TermsConditionsUseCaseInputPort termsConditionsUseCaseInputPort;

  TermsTextLinkViewModel(
      this.linkTitle, this.idx, this.termsConditionsUseCaseInputPort);
}
