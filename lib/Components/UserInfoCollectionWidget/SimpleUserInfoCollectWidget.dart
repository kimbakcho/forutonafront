import 'package:flutter/material.dart';
import 'package:forutonafront/Components/SimpleCollectionWidget/SimpleCollectionWidget.dart';
import 'package:forutonafront/Components/UserProfileBar/UserProfileBar.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserNickNameWithFullTextMatchIndexUseCase/UserNickNameWithFullTextMatchIndexUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'UserInfoCollectMediator.dart';

class SimpleUserInfoCollectWidget extends StatelessWidget {
  final String searchText;

  const SimpleUserInfoCollectWidget({Key key, this.searchText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => SimpleUserInfoCollectWidgetViewModel(
            userInfoCollectMediator: sl(), searchText: searchText),
        child: Consumer<SimpleUserInfoCollectWidgetViewModel>(
            builder: (_, model, __) {
          return Container(
            margin: EdgeInsets.all(16),
            child: SimpleCollectionWidget(
              searchText: searchText,
              searchCollectMediator: model.userInfoCollectMediator,
              indexedWidgetBuilder: model.getIndexedWidgetBuilder(),
            ),
          ) 
            ;
        }));
  }
}

class SimpleUserInfoCollectWidgetViewModel extends ChangeNotifier {
  final String searchText;
  final UserInfoCollectMediator userInfoCollectMediator;

  SimpleUserInfoCollectWidgetViewModel(
      {@required this.searchText, @required this.userInfoCollectMediator}) {
    userInfoCollectMediator.userInfoListUpUseCaseInputPort =
        UserNickNameWithFullTextMatchIndexUseCase(
      fUserRepository: sl(),
      searchText: searchText,
    );
  }

  IndexedWidgetBuilder getIndexedWidgetBuilder() {
    return (_, index) {
      return UserProfileBar(
          key: Key(userInfoCollectMediator.itemList[index].uid),
          fUserInfoSimpleResDto: userInfoCollectMediator.itemList[index]);
    };
  }
}
