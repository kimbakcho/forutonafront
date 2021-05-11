import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CheckInPositionOpenWidget extends StatelessWidget {

  final CheckInPositionOpenWidgetController? controller;


  CheckInPositionOpenWidget({this.controller});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CheckInPositionOpenWidgetViewModel(
        controller: controller
      ),
      child: Consumer<CheckInPositionOpenWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("위치 공개",
                    style: GoogleFonts.notoSans(
                      fontSize: 14,
                      color: const Color(0xff000000),
                      letterSpacing: -0.28,
                      fontWeight: FontWeight.w700,
                      height: 1.2142857142857142,
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '체크인 위치가 유저에게 공개됩니다.',
                      style: GoogleFonts.notoSans(
                        fontSize: 12,
                        color: const Color(0xff7a7a7a),
                        letterSpacing: -0.24,
                        height: 1.1666666666666667,
                      ),
                      textAlign: TextAlign.left,
                    ), FlutterSwitch(
                      width: 45.0,
                      height: 20.0,
                      toggleSize: 15.0,
                      value: model.state,
                      borderRadius: 30.0,
                      padding: 2,
                      showOnOff: false,
                      onToggle: (val) {
                        model.toggle();
                      },
                    )
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class CheckInPositionOpenWidgetViewModel extends ChangeNotifier {

  final CheckInPositionOpenWidgetController? controller;


  CheckInPositionOpenWidgetViewModel({this.controller}){
    if(this.controller != null){
      this.controller!._viewModel = this;
    }
  }

  bool state = true;

  toggle() {
    state = !state;
    notifyListeners();
  }
}

class CheckInPositionOpenWidgetController {

  CheckInPositionOpenWidgetViewModel? _viewModel;

  bool getState(){
    if(_viewModel != null){
      return _viewModel!.state;
    }else {
      return false;
    }

  }



}
