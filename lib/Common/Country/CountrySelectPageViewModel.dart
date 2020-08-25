import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'CountryItem.dart';

// 해당 View의 역활의 목적은 ISO 코드를 Navigtor로 Return 해주는것.
class CountrySelectPageViewModel extends ChangeNotifier{
  final BuildContext _context;
  String initCountryCode;
  CodeCountry _codeCountry = new CodeCountry();
  List<CountryItem> countryList;
  int selectCountryIndex = 0;
  ScrollController listViewScroller  = new ScrollController();

  CountrySelectPageViewModel(this._context,{this.initCountryCode}){
    countryList = _codeCountry.countryList();
    if(initCountryCode != null){
      selectCountryIndex = countryList.indexWhere((x){
        return x.code == initCountryCode;
      });
      if(selectCountryIndex> 0){
//        listViewScroller.jumpTo(300);
      }
    }
    notifyListeners();
    Future.delayed(Duration(milliseconds: 100),(){
      listViewScroller.jumpTo(49.0*selectCountryIndex-(49*6));
      notifyListeners();
    });
  }

  onSelectCountry(int index){
    Navigator.of(_context).pop(countryList[index].code);
  }


  onBackBtnClick(){
    Navigator.of(_context).pop();
  }


}