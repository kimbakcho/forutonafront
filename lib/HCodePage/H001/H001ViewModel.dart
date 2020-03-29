import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:forutonafront/Common/Geolocation/GeolocationRepository.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingRepository.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingReqDto.dart';
import 'package:forutonafront/Common/TagRanking/TagRankingWrapDto.dart';

enum H001PageState { H001_01, H003_01 }

class H001ViewModel with ChangeNotifier {
  H001PageState _currentState;
  String _selectPosition = "로 딩 중";
  TagRankingWrapDto _rankingWrapDto;
  SwiperController rankingSwiperController = new SwiperController();
  bool rankingAutoPlay = false;
  bool _inlineRanking = true;

  TagRankingRepository _tagRankingRepository = new TagRankingRepository();
  GeolocationRepository _geolocationRepository = GeolocationRepository();

  H001ViewModel() {
    _currentState = H001PageState.H001_01;
    _rankingWrapDto = new TagRankingWrapDto(DateTime.now(), []);
    init();
  }

  init() async {
    await getCurrentPositionFromGeoLocation();
    var currentPosition =
        await _geolocationRepository.getCurrentPhoneLocation();
    _rankingWrapDto = await _tagRankingRepository.getTagRanking(
        new TagRankingReqDto(
            currentPosition.latitude, currentPosition.longitude, 10));

    rankingSwiperController.move(0);
    rankingAutoPlay = true;
    notifyListeners();
  }

  getCurrentPositionFromGeoLocation() async {
    _selectPosition = await _geolocationRepository.getCurrentPhoneAddress();
    notifyListeners();
    return _selectPosition;
  }

  bool get inlineRanking => _inlineRanking;

  set inlineRanking(bool value) {
    _inlineRanking = value;
    notifyListeners();
  }

  TagRankingWrapDto get rankingWrapDto => _rankingWrapDto;

  set rankingWrapDto(TagRankingWrapDto value) {
    _rankingWrapDto = value;
  }

  String get selectPosition => _selectPosition;

  set selectPosition(String value) {
    _selectPosition = value;
  }

  H001PageState get currentState => _currentState;

  set currentState(H001PageState value) {
    _currentState = value;
  }

  GeolocationRepository get geolocationRepository => _geolocationRepository;

  set geolocationRepository(GeolocationRepository value) {
    _geolocationRepository = value;
  }
}
