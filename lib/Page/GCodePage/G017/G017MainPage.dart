import 'package:flutter/material.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/ManagerBis/Notice/Domain/NoticeUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class G017MainPage extends StatelessWidget {

  final String appBarTitle;

  final int idx;

  const G017MainPage({Key key, this.appBarTitle, this.idx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G017MainPageViewModel(sl(),idx),
        child: Consumer<G017MainPageViewModel>(builder: (_, model, child) {
          return Scaffold(
            body: Container(
              color: Color(0xffF2F3F5),
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  CodeAppBar(
                    title: appBarTitle,
                    progressValue: 0,
                    visibleTailButton: false,
                  ),
                  Expanded(
                      child: Container(

                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xffE4E7E8)),
                         borderRadius: BorderRadius.all(Radius.circular(15))
                        ),
                        child: WebView(
                          onWebViewCreated: model.onWebViewCreated,
                        ),
                      )
                  )
                ],
              ),
            ),
          );
        }));
  }
}

class G017MainPageViewModel extends ChangeNotifier {

  String _initUrl = "";

  WebViewController _webViewController;

  NoticeUseCaseInputPort _noticeUseCaseInputPort;

  int idx;


  G017MainPageViewModel(this._noticeUseCaseInputPort,this.idx);

  init() async {

    var noticeResDto = await this._noticeUseCaseInputPort.getNotice(idx);

    String htmlUrl = new Uri.dataFromString(
        '<html><body>${noticeResDto.content}</body></html>',
        mimeType: 'text/html',
        parameters: {'charset': 'utf-8'}).toString();

    _webViewController.loadUrl(htmlUrl);
  }


  void onWebViewCreated(WebViewController controller) {
    this._webViewController = controller;
    this.init();
  }


}
