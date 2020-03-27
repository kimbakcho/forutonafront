import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingDto.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingRepository.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingReqDto.dart';

enum HCodeState { H001, T004, T007, T009, T011 }

class HCodeMainViewModel with ChangeNotifier {
  PageController _pageController;
  HCodeState _currentState;

  HCodeMainViewModel(){
    _pageController = new PageController();
    _currentState = HCodeState.H001;
  }

  jumpToPage(HCodeState pageCode){
    _currentState = pageCode;
    switch(_currentState){
      case HCodeState.H001:
        _pageController.jumpToPage(0);
        break;
      case HCodeState.T004:
        _pageController.jumpToPage(1);
        break;
      case HCodeState.T007:
        _pageController.jumpToPage(2);
        break;
      case HCodeState.T009:
        _pageController.jumpToPage(3);
        break;
      case HCodeState.T011:
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