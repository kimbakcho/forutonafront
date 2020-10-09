import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:provider/provider.dart';

class TopNavExpendGroup extends StatelessWidget {
  final TopNavBtnMediator topNavBtnMediator;
  final Map<CodeState, Widget> codeStateExpendWidgetMap;

  TopNavExpendGroup(
      {Key key,
      this.topNavBtnMediator,
      this.codeStateExpendWidgetMap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TopNavExpendGroupViewModel(
          codeStateExpendWidgetMap: codeStateExpendWidgetMap,
          topNavBtnMediator: topNavBtnMediator),
      child: Consumer<TopNavExpendGroupViewModel>(builder: (_, model, __) {
        return model._getTopNavExpendComponent();
      }),
    );
  }
}

class TopNavExpendGroupViewModel extends ChangeNotifier {
  final TopNavBtnMediator topNavBtnMediator;
  final Map<CodeState, Widget> codeStateExpendWidgetMap;
  BuildContext context;

  TopNavExpendGroupViewModel(
      {@required this.topNavBtnMediator,
      @required this.codeStateExpendWidgetMap}) {
    topNavBtnMediator.topNavExpendGroupViewModel = this;
  }

  changeExpendWidget() {
    notifyListeners();
  }

  Widget _getTopNavExpendComponent() {
    return codeStateExpendWidgetMap[topNavBtnMediator.currentTopNavRouter];
  }
}
