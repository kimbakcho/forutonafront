import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';

import 'package:provider/provider.dart';


import 'SearchHistoryView.dart';
import 'H010TopSearchBar.dart';

class H010MainView extends StatelessWidget {

  final SearchHistoryDataSourceKey searchHistoryDataSourceKey;

  final InputSearchBarListener inputSearchBarListener;

  const H010MainView({Key? key,required this.inputSearchBarListener,required this.searchHistoryDataSourceKey })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffF2F0F1),
        body: ChangeNotifierProvider(
            create: (_) => H010MainViewModel(
              searchHistoryViewController: SearchHistoryViewController()

            ),
            child: Consumer<H010MainViewModel>(builder: (_, model, __) {
              return Container(
                color: Colors.white,
                margin:
                    EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                child: Column(
                  children: [
                    H010TopSearchBar(
                      searchHistoryViewController: model.searchHistoryViewController!,
                      inputSearchBarListener: inputSearchBarListener,
                    ),
                    Expanded(
                      child: SearchHistoryView(
                        searchHistoryDataSourceKey: searchHistoryDataSourceKey,
                        inputSearchBarListener: inputSearchBarListener,
                        searchHistoryViewController:
                            model.searchHistoryViewController!,
                      ),
                    )
                  ],
                ),
              );
            })));
  }
}

class H010MainViewModel extends ChangeNotifier{
  final SearchHistoryViewController? searchHistoryViewController;
  H010MainViewModel({this.searchHistoryViewController});

}
