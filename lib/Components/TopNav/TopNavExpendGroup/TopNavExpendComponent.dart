import '../TopNavBtnMediator.dart';

abstract class TopNavExpendComponent {
  TopNavBtnMediator topNavBtnMediator;
  openExpandNav();
  closeExpandNav();
  getTopNavRouterType();
  getAnimation();
}