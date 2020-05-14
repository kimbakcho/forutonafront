import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:provider/provider.dart';

class MainModel with ChangeNotifier {
  final BuildContext _context;
  MainModel(this._context){
    init();
  }
  init() async {
    GlobalModel globalModel = Provider.of(_context);
    globalModel.setFUserInfoDto();
  }
}