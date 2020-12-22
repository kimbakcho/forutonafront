import 'package:flutter/material.dart';
import 'package:forutonafront/Page/BCodePage/BCodeMainPageViewModel.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/Preference.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BCodeMainPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BCodeMainPageViewModel(),
        lazy: false,
        builder: (context, _) {
          return Stack(children: <Widget>[
            Scaffold(
              body: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  Expanded(
                    child: WebView(
                      initialUrl: Preference.officialSite,
                    ),
                  ),
                  BottomNavigation(),
                ],
              ),
            )
          ]);
        });
  }

}
