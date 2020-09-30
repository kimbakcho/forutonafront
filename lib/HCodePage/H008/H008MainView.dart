import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H008/H008TopSearchBar.dart';
import 'package:provider/provider.dart';

import 'PlaceListFromSearchTextWidget.dart';

class H008MainView extends StatelessWidget {
  final String initSearchText;
  final PlaceListFromSearchTextWidgetListener
      placeListFromSearchTextWidgetListener;

  const H008MainView(
      {Key key,
      this.initSearchText,
      this.placeListFromSearchTextWidgetListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H008MainViewModel(),
        child: Consumer<H008MainViewModel>(builder: (_, model, __) {
          return Scaffold(
              body: Container(
                  margin:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: Column(children: [
                    H008TopSearchBar(initText: initSearchText),
                    Expanded(
                        child: PlaceListFromSearchTextWidget(
                      searchText: initSearchText,
                      placeListFromSearchTextWidgetListener:
                          placeListFromSearchTextWidgetListener,
                    ))
                  ])));
        }));
  }
}

class H008MainViewModel extends ChangeNotifier {}
