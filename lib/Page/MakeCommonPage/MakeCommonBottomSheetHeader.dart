import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'MakePageMode.dart';

class MakeCommonBottomSheetHeader extends StatelessWidget {
  final String ballName;
  final String displayAddress;
  final Function? onNextBtnTap;
  final MakePageMode makePageMode;
  final String? preSetAddress;

  final MakeCommonBottomSheetHeaderController
      makeCommonBottomSheetHeaderController;

  final Widget openHeaderWidget;

  MakeCommonBottomSheetHeader(
      {Key? key,
      required this.displayAddress,
      required this.makeCommonBottomSheetHeaderController,
        required this.ballName,
      this.onNextBtnTap,
      required this.makePageMode,
        required this.openHeaderWidget,
      this.preSetAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MakeCommonBottomSheetHeaderViewModel(
          displayAddress: displayAddress,
          makePageMode: makePageMode,
          makeBottomSheetHeaderController:
              makeCommonBottomSheetHeaderController,
          preSetAddress: preSetAddress),
      child: Consumer<MakeCommonBottomSheetHeaderViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.only(left: 16, right: 16),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0)),
            ),
            height: model._currentMode == MakeCommonBottomSheetHeaderMode.hide
                ? 114
                : 50,
            child: Column(
              children: [
                model._currentMode == MakeCommonBottomSheetHeaderMode.hide ? Container(
                  height: 35,
                  child: Center(
                    child: Container(
                      width: 13,
                      height: 3,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                          color: Color(0xffE4E7E8)),
                    ),
                  ),
                ): openHeaderWidget,
                model._currentMode == MakeCommonBottomSheetHeaderMode.hide
                    ? Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  '$ballName 장소',
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff000000),
                                    letterSpacing: -0.28,
                                    fontWeight: FontWeight.w700,
                                    height: 1.2142857142857142,
                                  ),
                                )),
                                SizedBox(
                                  height: 11,
                                ),
                                Container(
                                    child: Text(
                                  model.displayAddress!,
                                  style: GoogleFonts.notoSans(
                                    fontSize: 14,
                                    color: const Color(0xff3a3e3f),
                                    letterSpacing: -0.28,
                                    fontWeight: FontWeight.w500,
                                    height: 1.2142857142857142,
                                  ),
                                ))
                              ],
                            ),
                          )),
                          FlatButton(
                              padding: EdgeInsets.all(0),
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30.0))),
                              color: Color(0xffE4E7E8),
                              onPressed: () {
                                var nextTapFunc = onNextBtnTap;
                                if(nextTapFunc != null){
                                  nextTapFunc();
                                }
                              },
                              child: Text("다음"))
                        ],
                      )
                    : Container()
              ],
            ),
          );
        },
      ),
    );
  }
}

enum MakeCommonBottomSheetHeaderMode { show, hide }

class MakeCommonBottomSheetHeaderViewModel extends ChangeNotifier {
  final MakePageMode makePageMode;

  final String? preSetAddress;

  MakeCommonBottomSheetHeaderController makeBottomSheetHeaderController;

  MakeCommonBottomSheetHeaderMode? _currentMode;

  String? displayAddress;

  MakeCommonBottomSheetHeaderViewModel(
      {required this.displayAddress,
      required this.makePageMode,
      required this.makeBottomSheetHeaderController,
      this.preSetAddress}) {

    makeBottomSheetHeaderController.bottomSheetHeaderViewModel = this;

    if (makePageMode == MakePageMode.modify) {
      this.displayAddress = preSetAddress;
    }
    _currentMode = MakeCommonBottomSheetHeaderMode.hide;
  }

  changeHeaderMode(MakeCommonBottomSheetHeaderMode mode) {
    _currentMode = mode;
    notifyListeners();
  }

  changeDisplayAddress(String value) {
    if (value.isEmpty) {
      displayAddress = "주소정보 없음";
    } else {
      displayAddress = value;
    }

    notifyListeners();
  }
}

class MakeCommonBottomSheetHeaderController {
  MakeCommonBottomSheetHeaderViewModel? bottomSheetHeaderViewModel;

  changeHeaderMode(MakeCommonBottomSheetHeaderMode mode) {
    bottomSheetHeaderViewModel!.changeHeaderMode(mode);
  }

  changeDisplayAddress(String value) {
    bottomSheetHeaderViewModel!.changeDisplayAddress(value);
  }
}
