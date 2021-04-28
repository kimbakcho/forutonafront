import 'package:flutter/material.dart';
import 'package:forutonafront/Components/SimpleCollectionWidget/SimpleCollectionTopTitleWidget.dart';
import 'package:forutonafront/Components/SimpleCollectionWidget/SimpleCollectionWidget.dart';
import 'package:forutonafront/Components/UserProfileBar/UserProfileBar.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserNickNameWithFullTextMatchIndexUseCase/UserNickNameWithFullTextMatchIndexUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'UserInfoCollectMediator.dart';

class SimpleUserInfoCollectWidget extends StatelessWidget {
  final String? searchText;
  final SimpleUserInfoCollectListener? simpleUserInfoCollectListener;

  const SimpleUserInfoCollectWidget(
      {Key? key, this.searchText, this.simpleUserInfoCollectListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SimpleUserInfoCollectWidgetViewModel(
            userInfoCollectMediator: sl(),
            searchText: searchText!,
            simpleUserInfoCollectListener: simpleUserInfoCollectListener!),
        child: Consumer<SimpleUserInfoCollectWidgetViewModel>(
            builder: (_, model, __) {
          return Container(
            margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: SimpleCollectionWidget(
              searchText: searchText,
              searchCollectMediator: model.userInfoCollectMediator,
              indexedWidgetBuilder: model.getIndexedWidgetBuilder(),
              simpleCollectionTopNextPageListener: model,
              titleDescription: "관련 닉네임",
            ),
          );
        }));
  }
}

class SimpleUserInfoCollectWidgetViewModel extends ChangeNotifier
    implements SimpleCollectionTopNextPageListener {
  final String searchText;
  final UserInfoCollectMediator userInfoCollectMediator;
  final SimpleUserInfoCollectListener? simpleUserInfoCollectListener;

  SimpleUserInfoCollectWidgetViewModel(
      {required this.searchText,
      required this.userInfoCollectMediator,
      this.simpleUserInfoCollectListener}) {
    userInfoCollectMediator.userInfoListUpUseCaseInputPort =
        UserNickNameWithFullTextMatchIndexUseCase(
      fUserRepository: sl(),
      searchText: searchText,
    );
  }

  IndexedWidgetBuilder getIndexedWidgetBuilder() {
    return (_, index) {
      return UserProfileBar(
          key: Key(userInfoCollectMediator.itemList![index].uid!),
          fUserInfoSimpleResDto: userInfoCollectMediator.itemList![index]);
    };
  }

  @override
  void onNextPage(String searchText) {
    if (simpleUserInfoCollectListener != null) {
      simpleUserInfoCollectListener!.onSimpleUserInfoCollectNextPage(searchText);
    }
  }
}

abstract class SimpleUserInfoCollectListener {
  void onSimpleUserInfoCollectNextPage(String searchText);
}
