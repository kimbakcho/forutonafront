import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/HCodePage/H010/H010MainView.dart';
import 'package:forutonafront/Page/KCodePage/KCodeMainPage.dart';
import 'package:google_fonts/google_fonts.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(ForutonaIcon.compass),
                Text(
                  '탐색',
                  style: GoogleFonts.notoSans(
                    fontSize: 9,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
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
    Navigator.popUntil(context, (route) => route.settings.name == "/");

    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "K001"),
        builder: (_) => KCodeMainPage(
          searchText: search,
        )));
  }
}
