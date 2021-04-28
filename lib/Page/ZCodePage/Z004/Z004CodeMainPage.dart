import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/DottedLine/DottedLine.dart';
import 'package:forutonafront/MainPage/MainPageView.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:android_intent/android_intent.dart';

class Z004CodeMainPage extends StatefulWidget {
  @override
  _Z004CodeMainPageState createState() => _Z004CodeMainPageState();
}

class _Z004CodeMainPageState extends State<Z004CodeMainPage>
    with WidgetsBindingObserver {
  Z004CodeMainPageViewModel? model;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Z004CodeMainPageViewModel(sl(), context),
      child: Consumer<Z004CodeMainPageViewModel>(
        builder: (_, model, child) {
          this.model = model;
          return Scaffold(
            body: Container(
              padding: MediaQuery.of(context).padding,
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text(
                                  '위치 접근권한이 거부상태입니다.',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 20,
                                    color: const Color(0xff000000),
                                    letterSpacing: -0.4,
                                    fontWeight: FontWeight.w700,
                                    height: 1.1,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text.rich(
                                  TextSpan(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      letterSpacing: -0.28,
                                      height: 1.4285714285714286,
                                    ),
                                    children: [
                                      TextSpan(
                                        text:
                                            '포루투나 서비스를 사용하기 위해서는\n위치정보 접근 권한이 필요합니다.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 228,
                                width: 189,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            "assets/MainImage/positionpermission.png"))),
                              )
                            ],
                          ),
                          SizedBox(height: 16),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Text.rich(
                                  TextSpan(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      letterSpacing: -0.28,
                                      height: 1.4285714285714286,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '위치 권한을',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' \'허용\'',
                                        style: TextStyle(
                                          color: const Color(0xff3497fd),
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '으로 설정해주세요.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      side:
                                          BorderSide(color: Color(0xff3A3E3F))),
                                  minWidth: 232,
                                  height: 34,
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  onPressed: () async {
                                    await model.gotoAppDetailSettingPage();
                                  },
                                  child: Text(
                                    '위치 액세스 권한 설정으로 이동',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff3a3e3f),
                                      letterSpacing: -0.7000000000000001,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5714285714285714,
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FlatButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0)),
                                      side:
                                          BorderSide(color: Color(0xff3A3E3F))),
                                  minWidth: 232,
                                  height: 34,
                                  padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                                  onPressed: () {
                                    model.reqGpsWithAppStart();
                                  },
                                  child: Text(
                                    '위치정보 접근 동의',
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff3a3e3f),
                                      letterSpacing: -0.7000000000000001,
                                      fontWeight: FontWeight.w500,
                                      height: 1.5714285714285714,
                                    ),
                                    textAlign: TextAlign.center,
                                  ))
                            ],
                          )
                        ],
                      ),
                    ),
                  )),
                  Container(
                    padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                    child: DottedLine(
                      dashColor: Color(0xffDADBDD),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Material(
                    color: model.hasAllPositionPermission
                        ? Color(0xff3497FD)
                        : Color(0xfff2f3f5),
                    borderRadius: BorderRadius.circular(26.0),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(26.0),
                      onTap: () {
                        model.reqGpsWithAppStart();
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width - 32,
                        height: 52,
                        alignment: Alignment.center,
                        child: Text(
                          '포루투나 입장하기',
                          style: GoogleFonts.notoSans(
                            fontSize: 16,
                            color: model.hasAllPositionPermission ? Colors.white : Color(0xffb1b1b1),
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(26.0),
                          border: Border.all(
                              width: 1.0,
                              color: model.hasAllPositionPermission
                                  ? Color(0xff4F72FF)
                                  : Color(0xffe4e7e8)),
                          boxShadow: [
                            BoxShadow(
                              color: model.hasAllPositionPermission ? Color(0x29000000) : Color(0x14455b63),
                              offset: Offset(0, 4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 26,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (this.model != null) {
      model!.checkPermission();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
}

class Z004CodeMainPageViewModel extends ChangeNotifier {
  final GeoLocationUtilForeGroundUseCaseInputPort
      geoLocationUtilForeGroundUseCaseInputPort;

  final BuildContext context;

  bool hasAllPositionPermission = false;

  Z004CodeMainPageViewModel(
      this.geoLocationUtilForeGroundUseCaseInputPort, this.context) {
    init();
  }

  gotoAppDetailSettingPage() async {
    var _androidIntent = AndroidIntent(
      data: "package:co.kr.forutonafront",
      action: "action_application_details_settings",
    );
    await _androidIntent.launch();
  }

  reqGpsWithAppStart() async {
    var isCanUseGps =
        await geoLocationUtilForeGroundUseCaseInputPort.useGpsReq();
    if (isCanUseGps) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: "/"),
          builder: (_) {
            return MainPageView();
          }));
    } else {
      Fluttertoast.showToast(msg: "위치정보 접근에 동의해 주세요.");
    }
  }

  void init() async {
    var isCanUseGps =
        await geoLocationUtilForeGroundUseCaseInputPort.useGpsReq();
    if (isCanUseGps) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          settings: RouteSettings(name: "/"),
          builder: (_) {
            return MainPageView();
          }));
    }
  }

  void checkPermission() async {
    this.hasAllPositionPermission =
        await geoLocationUtilForeGroundUseCaseInputPort
            .hasAllPositionPermission();
    notifyListeners();
  }
}
