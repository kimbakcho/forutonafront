import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/Page/GCodePage/G022/G022MainPage.dart';
import 'package:forutonafront/Page/JCodePage/J004/J004View.dart';
import 'package:forutonafront/Page/JCodePage/J007/J007View.dart';


class J002ViewModel extends ChangeNotifier {
  final BuildContext context;

  final SingUpUseCaseInputPort _singUpUseCaseInputPort;

  J002ViewModel(
      {@required this.context,
      @required SingUpUseCaseInputPort singUpUseCaseInputPort})
      : _singUpUseCaseInputPort = singUpUseCaseInputPort;

  bool allAgree = false;
  bool serviceUseAgree = false;
  bool serviceManagement = false;
  bool personalInformationCollectionAgree = false;
  bool positionInformationCollectionAgree = false;
  bool marketingInformationReceiveAgree = false;
  bool ageOverAgree = false;

  void onBackTap() {
    Navigator.of(context).pop();
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

  void checkAllAgree() {
    if (isAllAgree()) {
      allAgree = true;
    } else {
      allAgree = false;
    }
    notifyListeners();
  }

  bool isAllAgree() {
    return serviceUseAgree &&
        serviceManagement &&
        personalInformationCollectionAgree &&
        positionInformationCollectionAgree &&
        marketingInformationReceiveAgree &&
        ageOverAgree;
  }

  bool nextBtnFlag() {
    if (isSatisfied()) {
      return true;
    } else {
      return false;
    }
  }

  bool isSatisfied() {
    return serviceUseAgree &&
        serviceManagement &&
        personalInformationCollectionAgree &&
        positionInformationCollectionAgree &&
        ageOverAgree;
  }

  void onNextBtnClick() {
    // _singUpUseCaseInputPort.setForutonaAgree(serviceUseAgree);
    // _singUpUseCaseInputPort.setForutonaManagementAgree(serviceManagement);
    // _singUpUseCaseInputPort.setMartketingAgree(marketingInformationReceiveAgree);
    // _singUpUseCaseInputPort.setPositionAgree(positionInformationCollectionAgree);
    // _singUpUseCaseInputPort.setPrivateAgree(personalInformationCollectionAgree);
    // _singUpUseCaseInputPort.setAgeLimitAgree(ageOverAgree);
    // _singUpUseCaseInputPort.setCountryCode("KR");
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      if (isForutonaSignUpSelect()) {
        return J007View();
      } else {
        return J004View();
      }
    }));
  }

  bool isForutonaSignUpSelect() {
    // return _singUpUseCaseInputPort.getSnsSupportService() !=
    //     SnsSupportService.Forutona;
    //temp
    return false;
  }

  void onServiceUseAgreePolicyViewer() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G022MainPage("서비스 이용약관 동의", "forutonaUseAgreement")));
  }

  void onServiceManagementPolicyViewer() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => G022MainPage("서비스 운영 정책 동의", "forutonaManagement")));
  }

  void onPersonalInformationCollectionPolicyViewer() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            G022MainPage("개인정보 수집 이용 동의", "personalInformationCollection")));
  }

  void onPositionInformationCollectionPolicyViewer() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) =>
            G022MainPage("위치정보 활용 동의", "positionInformationProtection")));
  }
}