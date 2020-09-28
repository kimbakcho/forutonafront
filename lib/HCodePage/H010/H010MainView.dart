import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/HCodePage/H008/H008MainView.dart';
import 'package:provider/provider.dart';

import '../../Components/AddressInputSearchBar/AddressInputSearchBar.dart';
import 'AddressSearchHistoryView.dart';
import 'H010TopSearchBar.dart';

class H010MainView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F0F1),
        body: ChangeNotifierProvider(
            create: (_) => H010MainViewModel(
              context: context,
              addressSearchHistoryViewController: AddressSearchHistoryViewController()
            ),
            child: Consumer<H010MainViewModel>(builder: (_, model, __) {
              return Container(
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    H010TopSearchBar(
                    ),
                    Expanded(
                      child: AddressSearchHistoryView(
                        onListTapItem: model.onAddressSearch,
                        addressSearchHistoryViewController: model.addressSearchHistoryViewController,
                      ),
                    )
                  ],
                ),
              );
            })));
  }
}

class H010MainViewModel extends ChangeNotifier implements AddressInputSearchBarListener{

  final BuildContext context;

  final AddressSearchHistoryViewController addressSearchHistoryViewController;

  H010MainViewModel( {this.addressSearchHistoryViewController,this.context});

  @override
  onAddressSearch(String search) async {
    await addressSearchHistoryViewController.addHistory(search);
    Navigator.of(context).push(MaterialPageRoute(
      settings: RouteSettings(name: "/H008"),
      builder: (_)=>H008MainView(initSearchText: search)
    ));

  }
}
