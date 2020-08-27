import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/ICodePage/ID001/Value/BallLikeState.dart';
import 'package:forutonafront/JCodePage/J001/J001View.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class ID001LikeAction extends StatelessWidget {
  final ValuationMediator _valuationMediator;
  final String ballUuid;

  ID001LikeAction({ValuationMediator valuationMediator, this.ballUuid})
      : _valuationMediator = valuationMediator;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID001LikeActionViewModel(
          fireBaseAuthAdapterForUseCase: sl(),
          valuationMediator: _valuationMediator,
          ballUuid: ballUuid,
          context: context),
      child: Consumer<ID001LikeActionViewModel>(builder: (_, model, __) {
        return Container(
          child: Row(
            children: <Widget>[
              RawMaterialButton(
                onPressed: () {
                  model.likeAction();
                },
                constraints: BoxConstraints(minHeight: 35, minWidth: 35),
                child: Icon(ForutonaIcon.thumbsup,
                    color: model.ballLikeState == BallLikeState.Up
                        ? Colors.lightBlueAccent
                        : Colors.grey),
              ),
              RawMaterialButton(
                onPressed: () {
                  model.disLikeAction();
                },
                constraints: BoxConstraints(minHeight: 35, minWidth: 35),
                child: Icon(ForutonaIcon.thumbsdown,
                    color: model.ballLikeState == BallLikeState.Down
                        ? Colors.lightBlueAccent
                        : Colors.grey),
              )
            ],
          ),
        );
      }),
    );
  }
}

class ID001LikeActionViewModel extends ChangeNotifier
    implements ValuationMediatorComponent {
  final ValuationMediator _valuationMediator;
  final BuildContext context;
  final FireBaseAuthAdapterForUseCase _fireBaseAuthAdapterForUseCase;

  ID001LikeActionViewModel(
      {ValuationMediator valuationMediator,
      this.context,
      this.ballUuid,
      FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase})
      : _valuationMediator = valuationMediator,
        _fireBaseAuthAdapterForUseCase = fireBaseAuthAdapterForUseCase {
    _valuationMediator.registerComponent(this);
  }

  likeAction() async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      _valuationMediator.likeAction(this);
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J001View()));
    }
  }

  BallLikeState get ballLikeState {
    return _valuationMediator.ballLikeState;
  }

  disLikeAction() async {
    if (await _fireBaseAuthAdapterForUseCase.isLogin()) {
      _valuationMediator.disLikeAction(this);
    } else {
      Navigator.of(context).push(MaterialPageRoute(builder: (_) => J001View()));
    }
  }

  @override
  String ballUuid;

  @override
  reqNotification() {
    notifyListeners();
  }

  @override
  void dispose() {
    _valuationMediator.unregisterComponent(this);
    super.dispose();
  }
}
