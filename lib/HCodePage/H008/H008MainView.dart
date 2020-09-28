import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H008/H008TopSearchBar.dart';
import 'package:provider/provider.dart';

import 'PlaceListFromSearchTextWidget.dart';

class H008MainView extends StatelessWidget {

  final String initSearchText;

  const H008MainView({Key key, this.initSearchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>H008MainViewModel(),
      child: Consumer<H008MainViewModel>(
        builder: (_,model,__){
          return Scaffold(
            body:Container(
              margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
              child: Column(
                children: [
                  H008TopSearchBar(initText: initSearchText),
                  Expanded(
                    child: PlaceListFromSearchTextWidget(
                      searchText: initSearchText,
                    ),
                  )
                ],
              ),
            ) ,
          )

            ;
        },
      ),
    );
  }
}
class H008MainViewModel extends ChangeNotifier {

}
