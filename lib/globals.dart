import 'package:flutter/material.dart';
import 'package:forutonafront/Auth/UserInfoMain.dart';

class GolobalStateContainer extends StatefulWidget {
  final Widget child;
  GolobalStateContainer({@required this.child});

  static _GolobalStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  _GolobalStateContainerState createState() => _GolobalStateContainerState();
}

class _GolobalStateContainerState extends State<GolobalStateContainer> {
  GlobalState state = new GlobalState();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _GolobalStateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);
  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}

class GlobalState {
  UserInfoMain userInfoMain;
  GlobalState({
    this.userInfoMain,
  });
  factory GlobalState.loading() =>
      new GlobalState(userInfoMain: new UserInfoMain());
}
