import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/GCodePage/G022/G022MainPage.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/JCodePage/J004/J004View.dart';
import 'package:forutonafront/JCodePage/J007/J007View.dart';
import 'package:provider/provider.dart';


class J002ViewModel extends ChangeNotifier {
  final BuildContext _context;

  J002ViewModel(this._context);

  bool allAgree = false;
  bool serviceUseAgree = false;
  bool serviceManagement = false;
  bool personalInformationCollectionAgree = false;
  bool positionInformationCollectionAgree = false;
  bool marketingInformationReceiveAgree = false;
  bool ageOverAgree = false;

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  void onAllAgreeClick() {
    allAgree = !allAgree;
    if (allAgree) {
      serviceUseAgree = true;
      serviceManagement = true;
      personalInformationCollectionAgree = true;
      positionInformationCollectionAgree = true;
      marketingInformationReceiveAgree = true;
      ageOverAgree = true;
    } else {
      serviceUseAgree = false;
      serviceManagement = false;
      personalInformationCollectionAgree = false;
      positionInformationCollectionAgree = false;
      marketingInformationReceiveAgree = false;
      ageOverAgree = false;
    }
    notifyListeners();
  }

  void onServiceUseAgreeClick() {
    serviceUseAgree = !serviceUseAgree;
    checkAllAgree();
    notifyListeners();
  }

  void onServiceManagementAgreeClick() {
    serviceManagement = !serviceManagement;
    checkAllAgree();
    notifyListeners();
  }

  void onPersonalInformationCollectionAgree() {
    personalInformationCollectionAgree = !personalInformationCollectionAgree;
    checkAllAgree();
    notifyListeners();
  }

  void onPositionInformationCollectionAgree() {
    positionInformationCollectionAgree = !positionInformationCollectionAgree;
    checkAllAgree();
    notifyListeners();
  }

  void onMarketingInformationReceiveAgree() {
    marketingInformationReceiveAgree = !marketingInformationReceiveAgree;
    checkAllAgree();
    notifyListeners();
  }

  void onAgeOverAgree() {
    ageOverAgree = !ageOverAgree;
    checkAllAgree();
    notifyListeners();
  }

  bool checkAllAgree() {
    if (serviceUseAgree &&
        serviceManagement &&
        personalInformationCollectionAgree &&
        positionInformationCollectionAgree &&
        marketingInformationReceiveAgree &&
        ageOverAgree) {
      allAgree = true;
    }else {
      allAgree = false;
    }
    notifyListeners();
  }
  bool nextBtnFlag(){
    if(serviceUseAgree &&
        serviceManagement &&
        personalInformationCollectionAgree &&
        positionInformationCollectionAgree &&
        ageOverAgree){
      return true;
    }else {
      return false;
    }
  }
  void onNextBtnClick(){
    GlobalModel globalModel = Provider.of<GlobalModel>(_context,listen: false);
    globalModel.fUserInfoJoinReqDto.forutonaAgree = serviceUseAgree;
    globalModel.fUserInfoJoinReqDto.forutonaManagementAgree = serviceManagement;
    globalModel.fUserInfoJoinReqDto.martketingAgree = marketingInformationReceiveAgree;
    globalModel.fUserInfoJoinReqDto.positionAgree = positionInformationCollectionAgree;
    globalModel.fUserInfoJoinReqDto.privateAgree = personalInformationCollectionAgree;
    globalModel.fUserInfoJoinReqDto.ageLimitAgree = ageOverAgree;
    globalModel.fUserInfoJoinReqDto.countryCode = "KR";

    Navigator.of(_context).push(MaterialPageRoute(
      builder: (context){
        if(globalModel.fUserInfoJoinReqDto.snsSupportService != SnsSupportService.Forutona){
          return J007View();
        }else {
          return J004View();
        }

      }
    ));
  }

  void onServiceUseAgreePolicyViewer() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G022MainPage("서비스 이용약관 동의","forutonaUseAgreement")
        )
    );
  }

  void onServiceManagementPolicyViewer() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G022MainPage("서비스 운영 정책 동의","forutonaManagement")
        )
    );
  }

  void onPersonalInformationCollectionPolicyViewer() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G022MainPage("개인정보 수집 이용 동의","personalInformationCollection")
        )
    );
  }

  void onPositionInformationCollectionPolicyViewer() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G022MainPage("위치정보 활용 동의","positionInformationProtection")
        )
    );
  }
}
