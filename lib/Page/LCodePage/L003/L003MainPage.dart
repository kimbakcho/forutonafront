import 'package:flutter/material.dart';
import 'package:forutonafront/ManagerBis/TermsConditions/Domain/UseCase/TermsConditionsUseCaseInputPort.dart';
import 'package:forutonafront/Page/LCodePage/LCodeAppBar/LCodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class L003MainPage extends StatelessWidget {
  final int termsIdx;

  const L003MainPage({Key key, this.termsIdx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L003MainPageViewModel(sl(), this.termsIdx),
        child: Consumer<L003MainPageViewModel>(builder: (_, model, child) {
          return Material(
              color: Colors.white,
              child: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    LCodeAppBar(
                      progressValue: 0,
                      visibleTailButton: false,
                      title: model.termsTitle,
                    ),
                    Expanded(
                        child: Container(
                            padding: EdgeInsets.all(16),
                            color: Color(0xffE4E7E8),
                            child: Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(15.0))),
                                child: WebView(
                                  onWebViewCreated: model.onWebViewCreated,
                                ))))
                  ])));
        }));
  }
}

class L003MainPageViewModel extends ChangeNotifier {
  String termsTitle = "";

  final TermsConditionsUseCaseInputPort _termsConditionsUseCaseInputPort;
  final int termsIdx;

  WebViewController _webViewController;

  L003MainPageViewModel(this._termsConditionsUseCaseInputPort, this.termsIdx);

  init() async {
    var termsConditionsResDto = await this
        ._termsConditionsUseCaseInputPort
        .getTermsConditions(this.termsIdx);
    termsTitle = termsConditionsResDto.termsName;
    notifyListeners();
    String htmlUrl = new Uri.dataFromString(
        '<html><body>${termsConditionsResDto.termsContent}</body></html>',
        mimeType: 'text/html',
        parameters: {'charset': 'utf-8'}).toString();
    this._webViewController.loadUrl(htmlUrl);
  }

  void onWebViewCreated(WebViewController controller) {
    this._webViewController = controller;
    this.init();
  }
}
