import 'package:flutter/material.dart';
import 'package:forutonafront/Components/UserInfoCollectionWidget/SimpleUserInfoCollectWidget.dart';
import 'package:provider/provider.dart';

import '../KRankingTagListWidget.dart';

class K00100MainPage extends StatelessWidget {
  final String searchText;

  const K00100MainPage({Key key, this.searchText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => K00100MainPageViewModel(),
        child: Consumer<K00100MainPageViewModel>(
          builder: (_, model, __) {
            return Container(
              child: ListView(
                  shrinkWrap: true,
                  padding: EdgeInsets.all(0),
                  children: [
                    KRankingTagListWidget(searchText: searchText),
                    SimpleUserInfoCollectWidget(
                      searchText: searchText,
                    )
                  ]),
              decoration: BoxDecoration(color: Color(0xffF2F0F1)),
            );
          },
        ));
  }
}

class K00100MainPageViewModel extends ChangeNotifier {

}
