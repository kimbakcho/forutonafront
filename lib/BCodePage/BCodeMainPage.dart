import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:forutonafront/BCodePage/BCodeMainPageViewModel.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class BCodeMainPage extends StatelessWidget {

  final Preference _preference = sl();

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
                    child: WebviewScaffold(
                      url: _preference.officialSite,
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
