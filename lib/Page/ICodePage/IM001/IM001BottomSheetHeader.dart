import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class IM001BottomSheetHeader extends StatelessWidget {
  final String displayAddress;
  final Function onNextBtnTap;

  final IM001BottomSheetHeaderController im001bottomSheetHeaderController;

  const IM001BottomSheetHeader(
      {Key key, this.displayAddress, this.im001bottomSheetHeaderController, this.onNextBtnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IM001BottomSheetHeaderViewModel(displayAddress,
          im001bottomSheetHeaderController: im001bottomSheetHeaderController),
      child: Consumer<IM001BottomSheetHeaderViewModel>(
        builder: (_, model, child) {
          return Container(

            padding: EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0),
                    topRight: Radius.circular(15.0))),
            height: model._currentMode == IM001BottomSheetHeaderMode.hide
                ? 114
                : 40,
            child: Column(
              children: [
                Container(
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
                ),
                model._currentMode == IM001BottomSheetHeaderMode.hide
                    ? Row(
                        children: [
                          Expanded(
                              child: Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                  '이슈볼 장소',
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
                                  model.displayAddress,
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
                                onNextBtnTap();
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

enum IM001BottomSheetHeaderMode { show, hide }

class IM001BottomSheetHeaderViewModel extends ChangeNotifier {
  IM001BottomSheetHeaderController im001bottomSheetHeaderController;

  IM001BottomSheetHeaderMode _currentMode;

  String displayAddress;

  IM001BottomSheetHeaderViewModel(this.displayAddress,
      {this.im001bottomSheetHeaderController}) {
    if (im001bottomSheetHeaderController != null) {
      im001bottomSheetHeaderController._iM001BottomSheetHeaderViewModel = this;
    }
    _currentMode = IM001BottomSheetHeaderMode.hide;
  }

  changeHeaderMode(IM001BottomSheetHeaderMode mode) {
    _currentMode = mode;
    notifyListeners();
  }

  changeDisplayAddress(String value){
    displayAddress = value;
    notifyListeners();
  }

}

class IM001BottomSheetHeaderController {
  IM001BottomSheetHeaderViewModel _iM001BottomSheetHeaderViewModel;

  changeHeaderMode(IM001BottomSheetHeaderMode mode) {
    _iM001BottomSheetHeaderViewModel.changeHeaderMode(mode);
  }

  changeDisplayAddress(String value){
    _iM001BottomSheetHeaderViewModel.changeDisplayAddress(value);
  }
}
