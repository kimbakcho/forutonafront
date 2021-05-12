import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DBallLikeButton extends StatelessWidget {
  final int initCount;

  final int initMyCount;

  final Function()? onTab;

  final IconData icon;

  final Color color;

  final DBallLikeButtonController? controller;

  DBallLikeButton(
      {required this.initCount,
      required this.initMyCount,
      this.controller,
      this.onTab,
      required this.icon,
      this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DBallLikeButtonViewModel(count: initCount, myCount: initMyCount,controller: controller),
        child: Consumer<DBallLikeButtonViewModel>(builder: (_, model, child) {
          return Container(
              width: 50,
              height: 25,
              child: TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(EdgeInsets.zero)),
                  onPressed: () {
                    if (onTab != null) {
                      onTab!();
                    }
                  },
                  child: Stack(
                    children: [
                      Positioned(
                        child: Icon(icon,
                            size: 20,
                            color: model.myCount > 0 ? color : Colors.black),
                        left: 0,
                        bottom: 0,
                      ),
                      Positioned(
                          left: 20,
                          top: 0,
                          child: Container(
                            child: Text(model.getCountText(),
                                style: GoogleFonts.notoSans(
                                  fontSize: 8,
                                  color: model.myCount > 0 ? color : Colors.black,
                                  fontWeight: FontWeight.w700,
                                )),
                          )
                          )
                    ],
                  )));
        }));
  }
}

class DBallLikeButtonViewModel extends ChangeNotifier {
  int count;

  int myCount;

  DBallLikeButtonController? controller;

  DBallLikeButtonViewModel(
      {required this.count, required this.myCount, this.controller}) {
    if (controller != null) {
      this.controller!._viewModel = this;
    }
  }

  String getCountText() {
    String countStr = "";
    if (count < 1000) {
      countStr = countStr + count.toString();
    } else {
      countStr = countStr + (count / 1000).toStringAsFixed(0) + "k";
    }
    if (myCount != 0) {
      countStr = "$countStr ($myCount)";
    }
    return countStr;
  }

  setMyCount(int myCount){
    this.myCount = myCount;
    notifyListeners();
  }
  setCount(int count){
    this.count = count;
    notifyListeners();
  }
}

class DBallLikeButtonController {
  DBallLikeButtonViewModel? _viewModel;

  setMyCount(int myCount){
    if(_viewModel != null){
      this._viewModel!.setMyCount(myCount);
    }
  }

  setCount(int count){
    if(_viewModel != null){
      this._viewModel!.setCount(count);
    }
  }
}
