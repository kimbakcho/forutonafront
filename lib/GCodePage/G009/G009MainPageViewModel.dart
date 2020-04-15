import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/GCodePage/G010/G010MainPage.dart';

class G009MainPageViewModel extends ChangeNotifier{
  final BuildContext _context;
  G009MainPageViewModel(this._context);


  void onBackTap() {
    Navigator.of(_context).pop();
  }

  void goAccountSettingPage() {
    Navigator.of(_context).push(MaterialPageRoute(
      builder: (_)=>G010MainPage(),
      settings: RouteSettings(
        name: "G010"
      )
    ));
  }
}