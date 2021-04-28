import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/Page/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class ID001LikeAction extends StatelessWidget {
  final ValuationMediator? valuationMediator;
  final String? ballUuid;

  ID001LikeAction({this.valuationMediator, this.ballUuid});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID001LikeActionViewModel(
          fireBaseAuthAdapterForUseCase: sl(),
          valuationMediator: valuationMediator,
          ballUuid: ballUuid,
          context: context),
      child: Consumer<ID001LikeActionViewModel>(builder: (_, model, __) {
        return Container(
          child: Row(
            children: <Widget>[

            ],
          ),
        );
      }),
    );
  }
}

class ID001LikeActionViewModel extends ChangeNotifier
    implements ValuationMediatorComponent {
  final ValuationMediator? valuationMediator;
  final BuildContext? context;
  final FireBaseAuthAdapterForUseCase? fireBaseAuthAdapterForUseCase;

  ID001LikeActionViewModel(
      {required this.valuationMediator,
      required this.context,
      required this.ballUuid,
      required this.fireBaseAuthAdapterForUseCase})
      {
    valuationMediator!.registerComponent(this);
  }

  likeAction() async {
    if (await fireBaseAuthAdapterForUseCase!.isLogin()) {
      // valuationMediator.voteAction(this);
    } else {
      // Navigator.of(context!).push(MaterialPageRoute(builder: (_) => J001View()));
    }
  }



  disLikeAction() async {
    if (await fireBaseAuthAdapterForUseCase!.isLogin()) {
      // valuationMediator.disLikeAction(this);
    } else {
      // Navigator.of(context!).push(MaterialPageRoute(builder: (_) => J001View()));
    }
  }

  @override
  String? ballUuid;

  @override
  valuationReqNotification() {
    notifyListeners();
  }

  @override
  void dispose() {
    valuationMediator!.unregisterComponent(this);
    super.dispose();
  }
}
