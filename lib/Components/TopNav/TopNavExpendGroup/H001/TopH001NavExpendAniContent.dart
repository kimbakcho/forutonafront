import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

abstract class TopH001NavExpendAniContentInputPort {
  expended();

  collapsed();
}

// ignore: must_be_immutable
class TopH001NavExpendAniContent extends StatelessWidget
    implements TopH001NavExpendAniContentInputPort {
  TopH001NavExpendAniContentViewModel _topH001NavExpendAniContentViewModel;

  TopH001NavExpendAniContent({Key key}) : super(key: key) {
    _topH001NavExpendAniContentViewModel = TopH001NavExpendAniContentViewModel(
        fluttertoastAdapter: sl(),
        locationAdapter: sl(),
        geoLocationUtilForeGroundUseCaseInputPort: sl());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _topH001NavExpendAniContentViewModel,
      child: Consumer<TopH001NavExpendAniContentViewModel>(
        builder: (_, model, __) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      padding: model.isExpend ? EdgeInsets.fromLTRB(16,0,16,0) : EdgeInsets.all(0),
                      onPressed: () {},
                      child: Text(
                        model.disPlayAddress,
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: const Color(0xff454f63),
                          fontWeight: FontWeight.w700,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      color: Color(0xffF6F6F6),
                    )),
              )
            ],
          );
        },
      ),
    );
  }

  @override
  collapsed() {
    _topH001NavExpendAniContentViewModel.collapsed();
  }

  @override
  expended() {
    _topH001NavExpendAniContentViewModel.expended();
  }
}

enum TopH001NavExpendAniContentViewModelExpendState { collapsed, expended }

class TopH001NavExpendAniContentViewModel extends ChangeNotifier
    implements TopH001NavExpendAniContentInputPort {
  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCaseInputPort;
  final LocationAdapter locationAdapter;
  final FluttertoastAdapter fluttertoastAdapter;
  TopH001NavExpendAniContentViewModelExpendState currentState =
      TopH001NavExpendAniContentViewModelExpendState.expended;

  String searchAddress = "로딩중 입니다.";

  TopH001NavExpendAniContentViewModel(
      {this.geoLocationUtilForeGroundUseCaseInputPort,
      this.locationAdapter,
      this.fluttertoastAdapter}) {
    init();
  }

  init() async {
    bool serviceCheck = await this.locationAdapter.serviceEnabled();
    if (!serviceCheck) {
      searchAddress = "위치정보를 사용수가 없습니다.";
      fluttertoastAdapter.showToast(msg: searchAddress);
      return;
    }
    try {
      fluttertoastAdapter.showToast(msg: "위치를 확인 중입니다.");
      this.searchAddress = await geoLocationUtilForeGroundUseCaseInputPort
          .getPositionAddress(await geoLocationUtilForeGroundUseCaseInputPort
              .getCurrentWithLastPosition());
    } on FlutterError catch (e) {
      this.searchAddress = e.message;
      fluttertoastAdapter.showToast(msg: e.message);
    }
    notifyListeners();
  }

  get disPlayAddress {
    if (currentState ==
        TopH001NavExpendAniContentViewModelExpendState.collapsed) {
      return _makeSortAddress(this.searchAddress);
    } else {
      return this.searchAddress;
    }
  }

  _makeSortAddress(String address) {
    if (address.trim().length > 2) {
      return address.substring(0, 2);
    } else {
      return address.trim();
    }
  }
  
  bool get isExpend {
    return currentState == TopH001NavExpendAniContentViewModelExpendState.expended;
  }

  @override
  collapsed() {
    currentState = TopH001NavExpendAniContentViewModelExpendState.collapsed;
    notifyListeners();
  }

  @override
  expended() {
    currentState = TopH001NavExpendAniContentViewModelExpendState.expended;
    notifyListeners();
  }
}
