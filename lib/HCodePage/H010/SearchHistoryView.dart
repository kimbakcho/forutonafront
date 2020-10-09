import 'package:flutter/material.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Domain/UseCase/AddressSearchHistoryUseCaseInputPort.dart';
import 'package:forutonafront/Common/AddressSearchHistory/Dto/AddressSearchHistoryDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../Components/InputSearchBar/InputSearchBar.dart';

class SearchHistoryView extends StatelessWidget {
  final SearchHistoryViewController searchHistoryViewController;
  final InputSearchBarListener inputSearchBarListener;

  const SearchHistoryView(
      {Key key,
      this.searchHistoryViewController,
      this.inputSearchBarListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchHistoryViewModel(
          searchHistoryViewController: searchHistoryViewController,
          searchHistoryUseCaseInputPort: sl()),
      child: Consumer<SearchHistoryViewModel>(
        builder: (_, model, __) {
          return ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              itemCount: model.histories.length,
              itemBuilder: (_, index) {
                return Material(
                  color: Colors.white,
                  child: InkWell(
                    onTap: () {
                      inputSearchBarListener
                          .onSearch(model.histories[index].searchText,context: context);
                    },
                    child: Container(
                        padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                        child: Row(children: [
                          Expanded(
                              child: Container(
                                  child: Text(model.histories[index].searchText,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.notoSans(
                                        fontSize: 14,
                                        color: const Color(0xff454f63),
                                        letterSpacing: -0.28,
                                        height: 1.4285714285714286,
                                      )))),
                          Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: Text(
                                  DateFormat("yy.MM.dd").format(
                                      model.histories[index].searchTime),
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff3497fd),
                                    letterSpacing: -0.28,
                                    height: 1.4285714285714286,
                                  ))),
                          Container(
                              width: 36,
                              height: 36,
                              child: Material(
                                  color: Colors.white,
                                  child: InkWell(
                                    onTap: () {
                                      model.removeHistory(
                                          model.histories[index].searchText);
                                    },
                                    child: Icon(
                                      ForutonaIcon.removepath,
                                      size: 15,
                                    ),
                                  )))
                        ])),
                  ),
                );
              });
        },
      ),
    );
  }
}

class SearchHistoryViewModel extends ChangeNotifier {
  final SearchHistoryUseCaseInputPort searchHistoryUseCaseInputPort;

  final SearchHistoryViewController searchHistoryViewController;

  List<AddressSearchHistoryDto> histories = [];

  SearchHistoryViewModel(
      {this.searchHistoryUseCaseInputPort, this.searchHistoryViewController}) {
    searchHistoryViewController.addressSearchHistoryViewModel = this;
    init();
  }

  Future<void> init() async {
    histories = await searchHistoryUseCaseInputPort.findByAll();
    notifyListeners();
  }

  Future<void> addHistory(String search) async {
    await searchHistoryUseCaseInputPort.save(search);
    histories = await searchHistoryUseCaseInputPort.findByAll();
    notifyListeners();
  }

  Future<void> removeHistory(String search) async {
    await searchHistoryUseCaseInputPort.delete(search);
    histories = await searchHistoryUseCaseInputPort.findByAll();
    notifyListeners();
  }
}

class SearchHistoryViewController {
  SearchHistoryViewModel addressSearchHistoryViewModel;

  Future<void> addHistory(String text) async {
    if (addressSearchHistoryViewModel != null) {
      await addressSearchHistoryViewModel.addHistory(text);
    }
  }
}
