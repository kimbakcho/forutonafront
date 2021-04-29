import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallListUp/FBallListUpUserMakerBall.dart';
import 'package:forutonafront/Common/PageScrollController/PageScrollController.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/Components/BallListUp/BallListMediator.dart';
import 'package:forutonafront/Components/BallListUp/ListUpBallWidgetFactory.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class UserMakeBallList extends StatelessWidget {
  final String? userUid;

  const UserMakeBallList({Key? key, this.userUid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MakeBallListViewModel(BallListMediatorImpl(),userUid!),
      child: Consumer<MakeBallListViewModel>(
        builder: (_, model, child) {
          return Container(
            child: ListView.builder(
              controller: PageScrollController(
                  scrollController: ScrollController(),
                  onNextPage: model.onNextPage,
                  onRefreshFirst: model.onRefreshFirst).scrollController,
                shrinkWrap: true,
                itemCount: model.ballListMediator.itemList.length,
                padding: EdgeInsets.all(0),
                itemBuilder: (_, index) {
                  return Container(
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 13),
                    key: Key(model.ballListMediator.itemList[index].ballUuid!),
                    child: ListUpBallWidgetFactory.getBallWidget(
                        index, model.ballListMediator, BallStyle.Style2,
                        boxDecoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Color(0xffE4E7E8)),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)))),
                  );
                }),
          );
        },
      ),
    );
  }
}

class MakeBallListViewModel extends ChangeNotifier
    implements SearchCollectMediatorComponent {
  final BallListMediator ballListMediator;
  final String userUid;

  MakeBallListViewModel(this.ballListMediator, this.userUid) {
    this.ballListMediator.registerComponent(this);
    this.ballListMediator.fBallListUpUseCaseInputPort =
        FBallListUpUserMakerBall(fBallRepository: sl(), makerUid: userUid);
    _init();
  }

  void _init() async {
    this.ballListMediator.sort = "makeTime,DESC";
    await this.ballListMediator.searchFirst();
  }

  @override
  void dispose() {
    super.dispose();
    this.ballListMediator.unregisterComponent(this);
  }

  @override
  void onItemListEmpty() {
    notifyListeners();
  }

  @override
  void onItemListUpUpdate() {
    notifyListeners();
  }

  onNextPage() async {
    await this.ballListMediator.searchNext();
  }

  onRefreshFirst() async {
    await this.ballListMediator.searchFirst();
  }
}
