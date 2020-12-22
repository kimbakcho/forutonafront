import 'package:flutter/cupertino.dart';

class G023MainPageViewModel extends ChangeNotifier {

  final BuildContext _context;
  G023MainPageViewModel(this._context);



  void onBackTap() {
    Navigator.of(_context).pop();
  }
}