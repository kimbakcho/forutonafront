import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GlobalInitMutex/GlobalInitMutex.dart';
import 'package:forutonafront/Components/TopNav/TopNavExpendGroup/H_I_001/GeoViewSearchManager.dart';
import 'package:forutonafront/Page/HCodePage/H007/H007MainPage.dart';
import 'package:forutonafront/Page/HCodePage/H008/PlaceListFromSearchTextWidget.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'TopH_I_ExtendViewAction.dart';

// ignore: camel_case_types
abstract class TopH_I_001NavExpendAniContentInputPort {
  expended();

  collapsed();
}

// ignore: must_be_immutable, camel_case_types
class TopH_I_001NavExpendAniContent extends StatelessWidget
    implements TopH_I_001NavExpendAniContentInputPort {
  late TopH_I_001NavExpendAniContentViewModel _topH001NavExpendAniContentViewModel;
  final CodeMainPageController? codeMainPageController;
  final GeoViewSearchManagerInputPort? geoViewSearchManager;
  final TopH_I_001NavExpendAniContentController? topH_I_001NavExpendAniContentController;

  TopH_I_001NavExpendAniContent({Key? key, this.geoViewSearchManager, this.codeMainPageController, this.topH_I_001NavExpendAniContentController}) : super(key: key) {
    _topH001NavExpendAniContentViewModel =
        TopH_I_001NavExpendAniContentViewModel(
          codeMainPageController: codeMainPageController,
            fluttertoastAdapter: sl(),
            locationAdapter: sl(),
            geoViewSearchManager: geoViewSearchManager,
            topH_I_001NavExpendAniContentController: topH_I_001NavExpendAniContentController,
            geoLocationUtilForeGroundUseCaseInputPort: sl(),
            globalInitMutex: sl());
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
        value: _topH001NavExpendAniContentViewModel,
        child: Consumer<TopH_I_001NavExpendAniContentViewModel>(
            builder: (_, model, __) {
          model.context = context;
          return Row(children: <Widget>[
            Expanded(
              child: Container(
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20.0))),
                    padding: model.isExpend
                        ? EdgeInsets.fromLTRB(16, 0, 16, 0)
                        : EdgeInsets.all(0),
                    onPressed: () {
                      model.jumpToExtendView(context);
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
          ]);
        }));
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
    implements
        TopH_I_001NavExpendAniContentInputPort,
        H007Listener,
        PlaceListFromSearchTextWidgetListener {
  final GeoLocationUtilForeGroundUseCaseInputPort?
      geoLocationUtilForeGroundUseCaseInputPort;
  final LocationAdapter? locationAdapter;
  final FluttertoastAdapter? fluttertoastAdapter;
  final CodeMainPageController? codeMainPageController;
  final TopH_I_001NavExpendAniContentController? topH_I_001NavExpendAniContentController;

  TopH001NavExpendAniContentViewModelExpendState? currentState =
      TopH001NavExpendAniContentViewModelExpendState.expended;

  final GeoViewSearchManagerInputPort? geoViewSearchManager;

  final GlobalInitMutex? globalInitMutex;

  BuildContext? context;

  Position? currentSearchPosition;

  String searchAddress = "로딩중 입니다.";
  
  bool isLoadPosition = false;

  TopH_I_001NavExpendAniContentViewModel({
    required this.geoLocationUtilForeGroundUseCaseInputPort,
    required this.locationAdapter,
    required this.fluttertoastAdapter,
    required this.geoViewSearchManager,
    required this.codeMainPageController,
    required this.topH_I_001NavExpendAniContentController,
    required this.globalInitMutex
  }) {
    topH_I_001NavExpendAniContentController!._topH_I_001NavExpendAniContentViewModel = this;
    init();
  }

  init() async {
    try {
      // await geoLocationUtilForeGroundUseCaseInputPort.useGpsReq(context);
      fluttertoastAdapter!.showToast(msg: "위치를 확인 중입니다.");
      await loadPosition(await geoLocationUtilForeGroundUseCaseInputPort!
          .getCurrentWithLastPosition());
    } on FlutterError catch (e) {
      this.searchAddress = e.message;
      fluttertoastAdapter!.showToast(msg: e.message);
    }
    notifyListeners();
  }

  loadPosition(Position loadPosition) async {
    isLoadPosition = false;
    try {
      this.searchAddress = await geoLocationUtilForeGroundUseCaseInputPort!
          .getPositionAddress(loadPosition);
    } on FlutterError catch (e) {
      this.searchAddress = e.message;
    }

    this.currentSearchPosition = loadPosition;

    geoViewSearchManager!.search(loadPosition,14.46);
    notifyListeners();
    isLoadPosition = true;
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

  jumpToExtendView(BuildContext context) async {
    if(!isLoadPosition){
      Fluttertoast.showToast(msg: "위치 확인중입니다");
      return;
    }
    
    var currentSearchPosition = geoViewSearchManager!.currentSearchPosition;

    try{
      this.searchAddress = await geoLocationUtilForeGroundUseCaseInputPort!
          .getPositionAddress(currentSearchPosition!);
    }on FlutterError catch (ex) {
      this.searchAddress = ex.message;
    }

    var extendViewAction = TopH_I_ExtendViewAction.create(
        codeMainPageController: codeMainPageController!,
        searchAddress: searchAddress,
        h007listener: this,
        placeListFromSearchTextWidgetListener: this,
        currentSearchPosition: currentSearchPosition!);

    extendViewAction.action(context: context);
  }

  @override
  onH007SearchPosition(Position position, BuildContext context) {
    Navigator.popUntil(context, (route) => route.settings.name == "/");
    loadPosition(position);
  }

  //FROM H010
  @override
  onPlaceListTabPosition(Position position) {
    Navigator.popUntil(context!, (route) => route.settings.name == "/");
    loadPosition(position);
  }
}

// ignore: camel_case_types
class TopH_I_001NavExpendAniContentController {
  // ignore: non_constant_identifier_names
  TopH_I_001NavExpendAniContentViewModel? _topH_I_001NavExpendAniContentViewModel;

  void loadPosition(Position position) {
    _topH_I_001NavExpendAniContentViewModel!.loadPosition(position);
  }
}
