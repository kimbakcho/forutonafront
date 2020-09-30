import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/HCodePage/H001/H001Manager.dart';
import 'package:forutonafront/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

// ignore: camel_case_types
abstract class TopH_I_001NavExpendAniContentInputPort {
  expended();

  collapsed();
}

// ignore: must_be_immutable, camel_case_types
class TopH_I_001NavExpendAniContent extends StatelessWidget
    implements TopH_I_001NavExpendAniContentInputPort {
  TopH_I_001NavExpendAniContentViewModel _topH001NavExpendAniContentViewModel;

  TopH_I_001NavExpendAniContent({Key key}) : super(key: key) {
    _topH001NavExpendAniContentViewModel = TopH_I_001NavExpendAniContentViewModel(
        fluttertoastAdapter: sl(),
        locationAdapter: sl(),
        h001manager: sl(),
        geoLocationUtilForeGroundUseCaseInputPort: sl());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _topH001NavExpendAniContentViewModel,
      child: Consumer<TopH_I_001NavExpendAniContentViewModel>(
        builder: (_, model, __) {
          return Row(
            children: <Widget>[
              Expanded(
                child: Container(
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                      padding: model.isExpend
                          ? EdgeInsets.fromLTRB(16, 0, 16, 0)
                          : EdgeInsets.all(0),
                      onPressed: () {
                        model.jumpToMapExtendView(context);
                      },
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

// ignore: camel_case_types
class TopH_I_001NavExpendAniContentViewModel extends ChangeNotifier
    implements TopH_I_001NavExpendAniContentInputPort,H007Listener {

  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCaseInputPort;
  final LocationAdapter locationAdapter;
  final FluttertoastAdapter fluttertoastAdapter;
  TopH001NavExpendAniContentViewModelExpendState currentState =
      TopH001NavExpendAniContentViewModelExpendState.expended;

  final H001ManagerInputPort h001manager;

  Position currentSearchPosition;

  String searchAddress = "로딩중 입니다.";

  TopH_I_001NavExpendAniContentViewModel(
      {@required this.geoLocationUtilForeGroundUseCaseInputPort,
      @required this.locationAdapter,
      @required this.fluttertoastAdapter,
      @required this.h001manager,
      }) {
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
      await geoLocationUtilForeGroundUseCaseInputPort.useGpsReq();
      fluttertoastAdapter.showToast(msg: "위치를 확인 중입니다.");
      await loadPosition(await geoLocationUtilForeGroundUseCaseInputPort
          .getCurrentWithLastPosition());
    } on FlutterError catch (e) {
      this.searchAddress = e.message;
      fluttertoastAdapter.showToast(msg: e.message);
    }
    notifyListeners();
  }

  loadPosition(Position loadPosition) async {
    try {
      this.currentSearchPosition = loadPosition;
      this.searchAddress = await geoLocationUtilForeGroundUseCaseInputPort
          .getPositionAddress(loadPosition);
      h001manager.search(loadPosition);
      notifyListeners();
    } on FlutterError catch (e) {
      throw e;
    }
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
    return currentState ==
        TopH001NavExpendAniContentViewModelExpendState.expended;
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
  jumpToMapExtendView(BuildContext context)  async {
    var currentSearchPosition = h001manager.currentSearchPosition;
    this.searchAddress = await geoLocationUtilForeGroundUseCaseInputPort
        .getPositionAddress(currentSearchPosition);
    Navigator.of(context).push(MaterialPageRoute(
      settings: RouteSettings(name: "H007"),
      builder: (_)  {
        return H007MainPage(h007listener: this,initPosition: currentSearchPosition,address: searchAddress);
      }
    ));
  }

  @override
  onSearchPosition(Position position,BuildContext context) {
    Navigator.popUntil(context, (route) => route.settings.name == "MAIN");
    loadPosition(position);
  }
}
