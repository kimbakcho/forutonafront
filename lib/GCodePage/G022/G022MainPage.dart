import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'G022MainPageViewModel.dart';

class G022MainPage extends StatelessWidget {
  String policyTitle;

  String _policyName;

  G022MainPage(this.policyTitle, this._policyName);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G022MainPageViewModel(
          context: context,
          policyName: _policyName,
          policyTitle: policyTitle,
          userPolicyUseCaseInputPort: sl()
        ),
        child: Consumer<G022MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Positioned(
                          top: 0, left: 0, child: topBar(model, context)),
                      Positioned(
                          width: MediaQuery.of(context).size.width,
                          top: 71,
                          left: 0,
                          child: contentBar(model, context)),
                    ])))
          ]);
        }));
  }

  Container contentBar(G022MainPageViewModel model, BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height - 100,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        child: model.userPolicyResDto != null
            ? WebviewScaffold(url: model.htmlUrl)
            : Container(),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16)
          ],
          borderRadius: BorderRadius.circular(12.00),
        ));
  }

  topBar(G022MainPageViewModel model, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 56,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text(model.policyTitle,
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
