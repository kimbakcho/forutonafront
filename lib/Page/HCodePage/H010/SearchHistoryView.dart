import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Common/SearchHistory/Data/Repository/SearchHistoryRepositoryImpl.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/Repository/SearchHistoryRepository.dart';
import 'package:forutonafront/Common/SearchHistory/Domain/UseCase/SearchHistoryUseCaseInputPort.dart';
import 'package:forutonafront/Common/SearchHistory/Dto/SearchHistoryDto.dart';
import 'package:forutonafront/Components/InputSearchBar/InputSearchBar.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SearchHistoryView extends StatelessWidget {
  final SearchHistoryViewController? searchHistoryViewController;
  final InputSearchBarListener? inputSearchBarListener;
  final SearchHistoryDataSourceKey? searchHistoryDataSourceKey;

  const SearchHistoryView(
      {Key? key,
      this.searchHistoryViewController,
      this.inputSearchBarListener,
      this.searchHistoryDataSourceKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SearchHistoryViewModel(
          searchHistoryViewController: searchHistoryViewController,
          searchHistoryUseCaseInputPort: SearchHistoryUseCase(
              searchHistoryRepository: SearchHistoryRepositoryImpl(
                  sharedPreferencesAdapter: sl(),
                  searchHistoryDataSourceKey: searchHistoryDataSourceKey)),
          signInUserInfoUseCaseInputPort: sl()),
      child: Consumer<SearchHistoryViewModel>(
        builder: (_, model, __) {
          return model.histories.length > 0
              ? ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: model.histories.length,
                  itemBuilder: (_, index) {
                    return Container(
                      child: Material(
                          color: Colors.white,
                          child: InkWell(
                              onTap: () {
                                inputSearchBarListener!.onSearch(
                                    model.histories[index].searchText!,
                                    context: context);
                              },
                              child: Container(
                                  padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                                  child: Row(children: [
                                    Expanded(
                                        child: Container(
                                            child: Text(
                                                model.histories[index]
                                                    .searchText!,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff454f63),
                                                  letterSpacing: -0.28,
                                                  height: 1.4285714285714286,
                                                )))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            left: 16, right: 16),
                                        child: Text(
                                            DateFormat("yy.MM.dd").format(model
                                                .histories[index].searchTime!),
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
                                                model.removeHistory(model
                                                    .histories[index]
                                                    .searchText!);
                                              },
                                              child: Icon(
                                                ForutonaIcon.x_circle,
                                                size: 22,
                                              ),
                                            )))
                                  ])))),
                      decoration: BoxDecoration(
                          border: Border(
                              bottom: BorderSide(
                                  color: Color(0xffE4E7E8), width: 1))),
                    );
                  })
              : Column(children: [
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(color: Colors.white),
                        padding: EdgeInsets.fromLTRB(16, 16, 0, 16),
                        child: Text("최근 검색어 내역이 없습니다.",
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff454f63),
                              letterSpacing: -0.28,
                              height: 1.4285714285714286,
                            )),
                      ))
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  )
                ]);
        },
      ),
    );
  }
}

class SearchHistoryViewModel extends ChangeNotifier {
  final SearchHistoryUseCaseInputPort? searchHistoryUseCaseInputPort;

  final SearchHistoryViewController? searchHistoryViewController;

  final SignInUserInfoUseCaseInputPort? signInUserInfoUseCaseInputPort;

  List<SearchHistoryDto> histories = List.empty();

  SearchHistoryViewModel(
      {this.searchHistoryUseCaseInputPort,
      this.searchHistoryViewController,
      this.signInUserInfoUseCaseInputPort}) {
    searchHistoryViewController!.addressSearchHistoryViewModel = this;
    init();
  }

  Future<void> init() async {
    String uid = "";
    if (signInUserInfoUseCaseInputPort!.isLogin!) {
      uid = signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory()!.uid!;
    }
    histories = await searchHistoryUseCaseInputPort!.findByAll(uid);
    notifyListeners();
  }

  Future<void> addHistory(String search) async {
    String uid = "";
    if (signInUserInfoUseCaseInputPort!.isLogin!) {
      uid = signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory()!.uid!;
    }
    await searchHistoryUseCaseInputPort!.save(search, uid);
    histories = await searchHistoryUseCaseInputPort!.findByAll(uid);
    notifyListeners();
  }

  Future<void> removeHistory(String search) async {
    String uid = "";
    if (signInUserInfoUseCaseInputPort!.isLogin!) {
      uid = signInUserInfoUseCaseInputPort!.reqSignInUserInfoFromMemory()!.uid!;
    }
    await searchHistoryUseCaseInputPort!.delete(search, uid);
    histories = await searchHistoryUseCaseInputPort!.findByAll(uid);
    notifyListeners();
  }
}

class SearchHistoryViewController {
  SearchHistoryViewModel? addressSearchHistoryViewModel;

  Future<void> addHistory(String text) async {
    if (addressSearchHistoryViewModel != null) {
      await addressSearchHistoryViewModel!.addHistory(text);
    }
  }
}
