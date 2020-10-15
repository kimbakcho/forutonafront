import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';


import 'package:forutonafront/MainPage/CodeMainPageController.dart';


import 'package:provider/provider.dart';

import '../TopNavBtnMediator.dart';
import 'NavBtnAction.dart';
import 'TopNavBtnComponent.dart';

class NavBtnComponent extends StatefulWidget {
  final NavBtnSetDto navBtnSetDto;
  final TopNavBtnMediator navBtnMediator;
  final CodeMainPageController codeMainPageController;

  NavBtnComponent({Key key,
    @required this.navBtnSetDto,@required this.navBtnMediator,@required this.codeMainPageController}) : super(key: key);

  @override
  _NavBtnComponentState createState() =>
      _NavBtnComponentState(navBtnSetDto: navBtnSetDto, navBtnMediator: navBtnMediator,codeMainPageController: codeMainPageController);
}

class _NavBtnComponentState extends State<NavBtnComponent>
    with SingleTickerProviderStateMixin
    implements TopNavBtnComponent {
  final NavBtnSetDto navBtnSetDto;
  final CodeMainPageController codeMainPageController;
  AnimationController _controller;

  final TopNavBtnMediator navBtnMediator;

  _NavBtnComponentState({this.navBtnSetDto,this.codeMainPageController ,this.navBtnMediator});

  @override
  void initState() {
    initAnimation();
    super.initState();
    navBtnMediator.topNavBtnRegisterComponent(this);
  }

  initAnimation() {
    _controller = AnimationController(
        vsync: this, duration: navBtnMediator.animationDuration);
    _controller.addStatusListener((status) {
      navBtnMediator.onNavBtnAniStatusListener(
          status, navBtnSetDto.topOnMoveMainPage);
    });
  }

  Animation<double> getAnimation() {
    return Tween<double>(
            begin: navBtnSetDto.startOffset, end: navBtnSetDto.endOffset)
        .animate(_controller);
  }

  @override
  void dispose() {
    navBtnMediator.topNavBtnUnRegisterComponent(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NavBtnAniComponent(
      child: NavBtnContent(
        codeMainPageController: codeMainPageController,
        navBtnMediator: navBtnMediator,
        btnColor: navBtnSetDto.btnColor,
        btnIcon: navBtnSetDto.btnIcon,
        topOnMoveMainPage: navBtnSetDto.topOnMoveMainPage,
        navBtnAction: navBtnSetDto.navBtnAction,
      ),
      animation: getAnimation(),
      btnSize: navBtnSetDto.btnSize,
    );
  }

  @override
  aniForward() {
    _controller.forward();
  }

  @override
  aniReverse() {
    _controller.reverse();
  }

  @override
  getTopNavRouterType() {
    return navBtnSetDto.topOnMoveMainPage;
  }
}

class NavBtnContent extends StatelessWidget implements NavBtnContentInputPort {
  final Color btnColor;
  final Icon btnIcon;
  final CodeState topOnMoveMainPage;
  final TopNavBtnMediator navBtnMediator;
  final NavBtnAction navBtnAction;
  final CodeMainPageController codeMainPageController;

  NavBtnContent(
      {Key key,
      this.btnColor,
      this.btnIcon,
      this.topOnMoveMainPage,
      @required this.navBtnMediator,
      this.navBtnAction, @required this.codeMainPageController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NavBtnContentViewModel(
          codeMainPageController: codeMainPageController, topOnMoveMainPage: topOnMoveMainPage),
      child: Consumer<NavBtnContentViewModel>(builder: (_, model, __) {
        return Container(
            decoration: BoxDecoration(
              border: Border.all(
                  color: Color(0xff454F63), width: model.isMyPage() ? 2 : 0),
              color: model.isMyPage() ? btnColor : Color(0xffF6F6F6),
              shape: BoxShape.circle,
            ),
            child: FlatButton(
              shape: CircleBorder(),
              padding: EdgeInsets.all(0),
              onPressed: () {
                onNavTopBtnTop();
              },
              child: btnIcon,
            ));
      }),
    );
  }

  @override
  void onNavTopBtnTop() {
    _navListControl();
    _changePageAction();
    _btnAction();
  }

  void _btnAction() {
    if (navBtnMediator.aniState == NavBtnMediatorState.Close) {
      if (navBtnAction != null) {
        navBtnAction.onCloseClick();
      }
    } else {
      if (navBtnAction != null) {
        navBtnAction.onOpenClick();
      }
    }
  }

  void _changePageAction() {
    if (navBtnMediator.aniState == NavBtnMediatorState.Close) {
      navBtnMediator.changeMainPage(topOnMoveMainPage);
    } else {}
  }

  void _navListControl() {
    if (navBtnMediator.aniState == NavBtnMediatorState.Close) {
      navBtnMediator.openNavList(navRouterType: topOnMoveMainPage);
    } else {
      navBtnMediator.closeNavList(navRouterType: topOnMoveMainPage);
    }
  }
}

class NavBtnContentViewModel extends ChangeNotifier {
  final CodeMainPageController codeMainPageController;
  final CodeState topOnMoveMainPage;

  NavBtnContentViewModel(
      {this.codeMainPageController, this.topOnMoveMainPage}) {
    this
        .codeMainPageController
        .pageController
        .addListener(_onCodeMainPageChange);
  }

  _onCodeMainPageChange() {
    notifyListeners();
  }

  bool isMyPage() {
    return codeMainPageController.currentState == topOnMoveMainPage;
  }
}

abstract class NavBtnContentInputPort {
  onNavTopBtnTop();
}

class NavBtnAniComponent extends StatelessWidget {
  final Widget child;
  final Animation<double> animation;
  final double btnSize;

  const NavBtnAniComponent({Key key, this.animation, this.child, this.btnSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Positioned(
        left: animation.value,
        width: btnSize,
        height: btnSize,
        child: child,
      ),
      child: child,
    );
  }
}
