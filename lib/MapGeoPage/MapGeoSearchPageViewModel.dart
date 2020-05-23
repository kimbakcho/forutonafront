import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Preference.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart';
import 'package:uuid/uuid.dart';

import 'MapSearchGeoDto.dart';

class MapGeoSearchPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  final String _initAddress;
  final Position _initPosition;

  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchTextController = new TextEditingController();
  bool hasSearchTextFocus = true;
  bool searchClearButtonActive = false;
  bool searchClearButtonShow = true;
  String sessionToken;

  GooglePlace _googlePlace = GooglePlace(Preference.kGoogleApiKey);

  List<AutocompletePrediction> predictions = [];

  MapGeoSearchPageViewModel(this._initAddress, this._initPosition,this._context) {
    sessionToken = Uuid().v4();
    searchFocusNode.addListener(onSearchFocusNode);
    init();
  }

  init() async {
    searchTextController.addListener(onSearchTextListener);
    searchTextController.text = _initAddress;
  }

  ///주소 선택시 리턴값으로 detailsResponse.result 상세 정보를 리턴
  onPredictionTab(AutocompletePrediction prediction) async {
    DetailsResponse detailsResponse = await _googlePlace.details.get(prediction.placeId,language: "ko",sessionToken:sessionToken);
    MapSearchGeoDto mapSearchGeoDto = MapSearchGeoDto();
    mapSearchGeoDto.descriptionAddress = prediction.description;
    mapSearchGeoDto.latLng = LatLng(detailsResponse.result.geometry.location.lat,detailsResponse.result.geometry.location.lng);
    mapSearchGeoDto.address = detailsResponse.result.adrAddress;
    searchTextController.removeListener(onSearchTextListener);
    Navigator.of(_context).pop(mapSearchGeoDto);
  }

  onSearchTextListener() async {
    if (searchTextController.text.trim().length == 0) {
      predictions = [];
    } else {
      Component kr = Component("country","kr");
      AutocompleteResponse response = await _googlePlace.autocomplete.get(
          searchTextController.text,
          language: "ko",
          components: [kr],
          origin: LatLon(_initPosition.latitude, _initPosition.longitude),
          location: LatLon(_initPosition.latitude, _initPosition.longitude));
      predictions = response.predictions;
    }
    notifyListeners();
  }

  getSearchHintText() {
    if (hasSearchTextFocus) {
      return "검색어를 입력해주세요";
    } else {
      if (searchTextController.text.length > 0) {
        return searchTextController.text;
      } else {
        return "검색어를 입력해주세요";
      }
    }
  }

  clearSearchText() {
    this.searchTextController.clear();
    notifyListeners();
  }

  onSearch(value) async {}

  onSearchFocusNode() {
    hasSearchTextFocus = searchFocusNode.hasFocus;
    notifyListeners();
  }

  bool isClearButtonShow() {
    if (hasSearchTextFocus && searchTextController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  bool isClearButtonActive() {
    if (searchTextController.text.length == 0) {
      return false;
    } else {
      return true;
    }
  }

  void onSubmit(String value) {
    if(predictions.length == 0){
      Fluttertoast.showToast(
          msg: "검색결과가 없습니다.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }
}
