import 'package:flutter/material.dart';
import 'package:forutonafront/Page/JCodePage/J009/J009View.dart';
import 'package:forutonafront/Page/JCodePage/J012/J012View.dart';

class J008ViewModel extends ChangeNotifier {

  final BuildContext _context;
  J008ViewModel(this._context);

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  void jumpToJ009Page() {
    Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>J009View()));
  }

  void jumpToJ012Page() {
    Navigator.of(_context).push(MaterialPageRoute(builder: (_)=>J012View()));
  }
}