import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';
import 'package:forutonafront/HCodePage/H010/H010MainView.dart';
import 'package:forutonafront/KCodePage/KCodeMainPage.dart';
import 'package:provider/provider.dart';

class KPageNavBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => KPageNavBtnViewModel(context: context),
        child: Consumer<KPageNavBtnViewModel>(builder: (_, model, __) {
          return Container(
              child: FlatButton(
            onPressed: () {
              model.jumpToSearchPage();
            },
            child: Icon(
              Icons.search,
              color: Color(0xffE4E7E8),
            ),
          ));
        }));
  }
}

class KPageNavBtnViewModel extends ChangeNotifier
    implements InputSearchBarListener {
  final BuildContext context;

  KPageNavBtnViewModel({this.context});

  jumpToSearchPage() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => H010MainView(
              inputSearchBarListener: this,
              searchHistoryDataSourceKey:
                  SearchHistoryDataSourceKey.KPartSearchHistoryDataSource,
            )));
  }

  @override
  Future<void> onSearch(String search, {BuildContext context}) async {
    Navigator.popUntil(context, (route) => route.settings.name == "MAIN");

    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "K001"),
        builder: (_) => KCodeMainPage()));
  }
}
