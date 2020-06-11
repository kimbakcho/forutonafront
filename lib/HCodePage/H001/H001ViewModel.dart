import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/ValueDisplayUtil/NomalValueDisplay.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Presentation/Widget/BallStyle/Style1/BallStyle1Widget.dart';
import 'package:forutonafront/HCodePage/H001/H001Controller.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/TagRankingDto.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel
    with ChangeNotifier
    implements
        FBallListUpFromInfluencePowerUseCaseOutputPort,
        TagRankingFromBallInfluencePowerUseCaseOutputPort {

  final BuildContext context;
  String selectPositionAddress = "";
  bool rankingAutoPlay = false;

  SwiperController rankingSwiperController = new SwiperController();
  ScrollController h001CenterListViewController = new ScrollController();

  bool addressDisplayShowFlag = true;
  bool makeButtonDisplayShowFlag = true;

  List<BallStyle1Widget> ballWidgetLists = [];

  bool _inlineRanking = true;

  H001Controller h001controller;

  bool isLoading = false;

  List<TagRankingDto> tagRankingDtos;

  onShowLoading(){
    isLoading = true;
    notifyListeners();
  }

  onHideLoading(){
    isLoading = false;
    notifyListeners();
  }

  H001ViewModel(this.context) {
    h001controller = H001Controller(context: context,h001viewModel: this);
  }

  @override
  onListUpBallFromBallInfluencePower(
      {@required List<FBallResDto> fBallResDtos}) async {
    this.ballWidgetLists.addAll(fBallResDtos
        .map((x) => BallStyle1Widget.create(
              fBallResDto: x,
            ))
        .toList());
    notifyListeners();
  }

  onBallClear(){
    this.ballWidgetLists.clear();
  }

  onShowAddressDisplay() {
    addressDisplayShowFlag = true;
    notifyListeners();
  }

  onHiedAddressDisplay(){
    addressDisplayShowFlag = false;
    notifyListeners();
  }

  bool isBallEmpty() => this.ballWidgetLists.length == 0;

  void onAddressText(String address) {
    this.selectPositionAddress = address;
    notifyListeners();
  }

  get currentBallWidgetCount {
    return ballWidgetLists.length;
  }

  Future<void> onMoveScrollerDown() {
    return h001CenterListViewController.animateTo(
        h001CenterListViewController.offset +
            (MediaQuery.of(context).size.height / 2),
        duration: Duration(milliseconds: 300),
        curve: Curves.linear);
  }

  onShowMakeButtonDisplay() {
    makeButtonDisplayShowFlag = true;
    notifyListeners();
  }

  onHiedMakeButtonDisplay() {
    makeButtonDisplayShowFlag = false;
    notifyListeners();
  }

  @override
  void onTagRankingFromBallInfluencePower(List<TagRankingDto> tagRankingDtos) {
    this.tagRankingDtos = tagRankingDtos;
    rankingSwiperController.move(0);
    rankingAutoPlay = true;
    notifyListeners();
  }

  isFoldTagRanking() {
    return _inlineRanking;
  }

  String changeTagValueDisplay(double value) {
    return NomalValueDisplay.changeIntDisplaystr(value);
  }

  void onShowUnInlineRankingWidget() {
    _inlineRanking = false;
    notifyListeners();
  }

  void onShowInlineRankingWidget() {
    _inlineRanking = true;
    notifyListeners();
  }
}
