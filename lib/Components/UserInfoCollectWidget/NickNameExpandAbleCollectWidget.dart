import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserNickNameWithFullTextMatchIndexUseCase/UserNickNameWithFullTextMatchIndexUseCase.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

import 'UserInfoCollectMediator.dart';

class NickNameExpandAbleCollectWidget extends StatelessWidget {
  final String searchText;

  const NickNameExpandAbleCollectWidget({Key key, this.searchText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => NickNameExpandAbleCollectWidgetViewModel(
            userInfoCollectMediator: UserInfoCollectMediatorImpl()),
        child: Consumer<NickNameExpandAbleCollectWidgetViewModel>(
            builder: (_, model, __) {
          return Container(
            child: Text("tt"),
          );
        }));
  }
}

class NickNameExpandAbleCollectWidgetViewModel extends ChangeNotifier
  implements UserInfoCollectComponent {
  final UserInfoCollectMediator userInfoCollectMediator;

  final String searchText;

  NickNameExpandAbleCollectWidgetViewModel(
      {@required this.userInfoCollectMediator, @required this.searchText}) {
    userInfoCollectMediator.userInfoListUpUseCaseInputPort =
        UserNickNameWithFullTextMatchIndexUseCase(
      searchText: searchText,
      fUserRepository: sl(),
    );
    userInfoCollectMediator.registerComponent(this);
    userInfoCollectMediator.searchFirst();
  }


  @override
  void dispose() {
    userInfoCollectMediator.unregisterComponent(this);
    super.dispose();
  }

  @override
  void onUserInfoEmpty() {
    notifyListeners();
  }

  @override
  void onUserInfoListUp() {
    notifyListeners();
  }
}
