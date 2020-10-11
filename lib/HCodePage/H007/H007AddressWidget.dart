import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';
import 'package:forutonafront/HCodePage/H008/H008MainView.dart';
import 'package:forutonafront/HCodePage/H008/PlaceListFromSearchTextWidget.dart';
import 'package:forutonafront/HCodePage/H010/H010MainView.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class H007AddressWidget extends StatelessWidget {
  final String address;
  final PlaceListFromSearchTextWidgetListener
      placeListFromSearchTextWidgetListener;

  const H007AddressWidget({
    Key key,
    this.address,
    this.placeListFromSearchTextWidgetListener,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H007AddressWidgetViewModel(
            context: context,
            placeListFromSearchTextWidgetListener:
                placeListFromSearchTextWidgetListener),
        child: Consumer<H007AddressWidgetViewModel>(builder: (_, model, __) {
          return Container(
            height: 36,
            width: MediaQuery.of(context).size.width - 136,
            child: FlatButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    settings: RouteSettings(name: "H010"),
                    builder: (_) =>
                        H010MainView(inputSearchBarListener: model,
                          searchHistoryDataSourceKey: SearchHistoryDataSourceKey
                              .AddressSearchHistoryDataSource,
                        )));
              },
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              child: Text(address,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff454f63),
                    fontWeight: FontWeight.w700,
                  )),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
          );
        }));
  }
}

class H007AddressWidgetViewModel extends ChangeNotifier
    implements InputSearchBarListener {
  final BuildContext context;
  final PlaceListFromSearchTextWidgetListener
      placeListFromSearchTextWidgetListener;

  H007AddressWidgetViewModel(
      {this.context, this.placeListFromSearchTextWidgetListener});

  @override
  Future<void> onSearch(String search, {BuildContext context}) async {
    Navigator.of(context).push(MaterialPageRoute(
        settings: RouteSettings(name: "/H008"),
        builder: (_) => H008MainView(
            initSearchText: search,
            placeListFromSearchTextWidgetListener:
                placeListFromSearchTextWidgetListener)));
  }
}
