import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:provider/provider.dart';

import 'SimpleCollectBottomFactory.dart';
import 'SimpleCollectionTopTitleWidget.dart';

class SimpleCollectionWidget extends StatelessWidget {
  final String? searchText;
  final SearchCollectMediator<FUserInfoSimpleResDto> searchCollectMediator;
  final IndexedWidgetBuilder? indexedWidgetBuilder;
  final SimpleCollectionTopNextPageListener? simpleCollectionTopNextPageListener;
  final String? titleDescription;

  const SimpleCollectionWidget(
      {Key? key,
      this.searchText,
      required this.searchCollectMediator,
      this.indexedWidgetBuilder,
      this.simpleCollectionTopNextPageListener,
      this.titleDescription})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SimpleCollectionWidgetViewModel(
            searchText: searchText,
            searchCollectMediator: searchCollectMediator),
        child:
            Consumer<SimpleCollectionWidgetViewModel>(builder: (_, model, __) {
          return Container(
            child: Column(
              children: [
                SimpleCollectionTopTitleWidget(
                  searchText: searchText,
                  simpleCollectionTopNextPageListener:
                      simpleCollectionTopNextPageListener,
                  titleDescription: titleDescription,
                ),
                ListView.separated(
                  separatorBuilder: (_, index) {
                    return Container(height: 1, color: Color(0xffE4E7E8));
                  },
                  padding: EdgeInsets.all(0),
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.itemCount,
                  itemBuilder: indexedWidgetBuilder!,
                ),
                SimpleCollectBottomFactory(
                    moreCollectAction: model.moreCollectAction,
                    searchCollectMediator: model.searchCollectMediator)
              ],
            ),
          );
        }));
  }
}

class SimpleCollectionWidgetViewModel extends ChangeNotifier
    implements SearchCollectMediatorComponent {
  final SearchCollectMediator<FUserInfoSimpleResDto> searchCollectMediator;

  final String? searchText;

  SimpleCollectionWidgetViewModel(
      {required this.searchCollectMediator, required this.searchText}) {
    searchCollectMediator.registerComponent(this);
    searchCollectMediator.searchFirst();
  }

  @override
  void dispose() {
    searchCollectMediator.unregisterComponent(this);
    super.dispose();
  }

  @override
  void onItemListEmpty() {
    notifyListeners();
  }

  @override
  void onItemListUpUpdate() {
    notifyListeners();
  }

  List<FUserInfoSimpleResDto>? get items {
    return searchCollectMediator.itemList;
  }

  int get itemCount {
    return searchCollectMediator.itemList!.length;
  }

  bool? get isLastPage {
    return searchCollectMediator.isLastPage;
  }

  moreCollectAction() {
    searchCollectMediator.searchNext();
  }
}
