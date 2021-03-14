import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import 'package:forutonafront/Components/TopNav/MainPageViewModelInputPort.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtn.dart';
import 'package:forutonafront/Components/TopNav/NavBtn/NavBtnSetDto.dart';
import 'package:forutonafront/Components/TopNav/TopNavBar.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/G001/TopG001NavExpandComponent.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/G003/TopG003NavExpandComponent.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/Page/GCodePage/G001/G001MainPage.dart';
import 'package:provider/provider.dart';

class GCodeMainPage extends StatefulWidget {
  @override
  _GCodeMainPageState createState() => _GCodeMainPageState();
}

class _GCodeMainPageState extends State<GCodeMainPage>
    with AutomaticKeepAliveClientMixin {

  TopNavBtnMediator _topNavBtnMediator =
  TopNavBtnMediatorImpl(
      currentTopNavRouter: CodeState.G001CODE,
    isCanNavOpen: false
  );

  SwipeGestureRecognizerController _swipeGestureRecognizerController =
    SwipeGestureRecognizerController();

  CodeMainPageController _codeMainPageController;

  @override
  void initState() {
    super.initState();
    _codeMainPageController = CodeMainPageControllerImpl(
        mapCodeMainPageLink: getMapCodeMainPageLink(),
        topNavBtnMediator: _topNavBtnMediator,
        swipeGestureRecognizerController: _swipeGestureRecognizerController,
        currentState: CodeState.G001CODE);
  }

  Map<CodeState, CodeMainPageLinkDto> getMapCodeMainPageLink() {
    Map<CodeState, CodeMainPageLinkDto> mapCodeMainPageLink = Map();
    mapCodeMainPageLink[CodeState.G001CODE] =
        CodeMainPageLinkDto(pageNumber: 0, gestureFlag: true);
    mapCodeMainPageLink[CodeState.G003CODE] =
        CodeMainPageLinkDto(pageNumber: 1, gestureFlag: true);
    return mapCodeMainPageLink;
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_)=>GCodeMainPageViewModel(_codeMainPageController,_topNavBtnMediator),
      child: Consumer<GCodeMainPageViewModel>(
        builder: (_,model,child){
          return Scaffold(
            body: Container(
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  TopNavBar(
                    codeStateExpendWidgetMap:
                      model.getCodeStateExpendWidgetMap(),
                    codeMainPageController: model._codeMainPageController,
                    topNavBtnMediator: _topNavBtnMediator,
                    navBtnList: model.getNavBtnList(),
                  ),
                  Expanded(
                    child: SwipeGestureRecognizer(
                      swipeGestureRecognizerController:
                      _swipeGestureRecognizerController,
                      onSwipeRight: () {
                        // model.swipeRight();
                      },
                      onSwipeLeft: () {
                        // model.swipeLeft();
                      },
                      child: PageView(
                          physics: NeverScrollableScrollPhysics(),
                          controller: model.pageController,
                          children: <Widget>[
                            G001MainPage(),
                            Container(child: Text("G003")),
                          ]),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class GCodeMainPageViewModel extends ChangeNotifier implements CodeMainPageChangeListener,MainPageViewModelInputPort{
  CodeMainPageController _codeMainPageController;

  TopNavBtnMediator _topNavBtnMediator;

  GCodeMainPageViewModel(this._codeMainPageController,this._topNavBtnMediator){
    _codeMainPageController.addListener(this);
    _topNavBtnMediator.codeMainViewModelInputPort = this;
  }


  Map<CodeState, Widget> getCodeStateExpendWidgetMap() {
    Map<CodeState, Widget> codeStateExpendWidgetMap = Map();
    codeStateExpendWidgetMap[CodeState.G001CODE] = TopG001NavExpandComponent(
      codeMainPageController: _codeMainPageController,
      topNavBtnMediator: _topNavBtnMediator,
    );
    codeStateExpendWidgetMap[CodeState.G003CODE] = TopG003NavExpandComponent(
      codeMainPageController: _codeMainPageController,
      topNavBtnMediator: _topNavBtnMediator,
    );
    return codeStateExpendWidgetMap;
  }

  List<NavBtn> getNavBtnList() {
    List<NavBtn> navBtnList = [];
    navBtnList.add(NavBtn(
      originIndex: 1,
      codeMainPageController: _codeMainPageController,
      navBtnMediator: _topNavBtnMediator,
      navBtnSetDto: NavBtnSetDto(
          btnColor: Color(0xffFCF645),
          btnIcon: Icon(Icons.account_balance_wallet),
          topOnMoveMainPage: CodeState.G003CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 40),
      key: Key("1"),
    ));
    navBtnList.add(NavBtn(
      originIndex: 2,
      codeMainPageController: _codeMainPageController,
      navBtnMediator: _topNavBtnMediator,
      navBtnSetDto: NavBtnSetDto(
          btnColor: Color(0xff45E193),
          btnIcon: Icon(Icons.person_pin_outlined),
          topOnMoveMainPage: CodeState.G001CODE,
          btnSize: 36,
          startOffset: 0,
          endOffset: 0),
      key: Key("2"),
    ));
    return navBtnList;
  }

  void swipeRight() {
    if (_codeMainPageController.currentState == CodeState.G003CODE) {
      _codeMainPageController.movePageFromTo(
          mainTo: CodeState.G001CODE,
          topFrom: CodeState.G003CODE,
          topTo: CodeState.G001CODE);
    }
  }

  void swipeLeft() {
    if (_codeMainPageController.currentState == CodeState.G001CODE) {
      _codeMainPageController.movePageFromTo(
          mainTo: CodeState.G003CODE,
          topFrom: CodeState.G001CODE,
          topTo: CodeState.G003CODE);
    }
  }

  get pageController {
    return _codeMainPageController.pageController;
  }

  get currentState {
    return _codeMainPageController.currentState;
  }

  @override
  onChangeMainPage() {
    notifyListeners();
  }

  @override
  jumpToPage(CodeState pageCode) {
    _codeMainPageController.moveToPage(pageCode);
    notifyListeners();
  }

}