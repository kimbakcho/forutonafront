
import 'package:flutter/cupertino.dart';
import 'package:forutonafront/JCodePage/JCodeMainPageViewModel.dart';

class J001ViewModel extends ChangeNotifier{
  BuildContext _context;
  JCodeMainPageViewModel _jCodeMainPageViewModel;
  TextEditingController idTextFieldController =  TextEditingController();
  TextEditingController pwTextFieldController =  TextEditingController();
  FocusNode idTextFocusNode = FocusNode();
  FocusNode pwTextFocusNode = FocusNode();

  J001ViewModel(this._context){
    idTextFieldController.addListener(onIdTextFieldController);
    pwTextFieldController.addListener(onPwTextFieldController);
    idTextFocusNode.addListener(onIdTextFocusNode);
    pwTextFocusNode.addListener(onPwTextFocusNode);
  }
  onIdTextFocusNode(){
    notifyListeners();
  }
  onPwTextFocusNode(){
    notifyListeners();
  }
  onIdTextFieldController(){
    notifyListeners();
  }
  onPwTextFieldController(){
    notifyListeners();
  }
  isActiveButton(){
    if(idTextFieldController.text.length > 0 && pwTextFieldController.text.length > 0){
      return true;
    }else {
      return false;
    }
  }




}