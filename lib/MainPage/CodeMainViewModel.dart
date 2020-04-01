import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingDto.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingRepository.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingReqDto.dart';

enum HCodeState { HCDOE, ICODE, JCODE, KCODE, LCODE }

class CodeMainViewModel with ChangeNotifier {
  PageController _pageController;
  HCodeState _currentState;

  CodeMainViewModel(){
    _pageController = new PageController();
    _currentState = HCodeState.HCDOE;
  }

  jumpToPage(HCodeState pageCode){
    _currentState = pageCode;
    switch(_currentState){
      case HCodeState.HCDOE:
        _pageController.jumpToPage(0);
        break;
      case HCodeState.ICODE:
        _pageController.jumpToPage(1);
        break;
      case HCodeState.JCODE:
        _pageController.jumpToPage(2);
        break;
      case HCodeState.KCODE:
        _pageController.jumpToPage(3);
        break;
      case HCodeState.LCODE:
        _pageController.jumpToPage(4);
        break;
    }
    notifyListeners();
  }

  PageController get pageController => _pageController;

  set pageController(PageController value) {
    _pageController = value;
  }

  HCodeState get currentState => _currentState;

  set currentState(HCodeState value) {
    _currentState = value;
  }
}