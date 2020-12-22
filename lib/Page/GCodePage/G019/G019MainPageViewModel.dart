import 'package:flutter/material.dart';
import 'package:forutonafront/Page/GCodePage/G022/G022MainPage.dart';

import 'package:forutonafront/Page/GCodePage/G023/G023MainPage.dart';

class G019MainPageViewModel extends ChangeNotifier{
  final BuildContext _context;
  G019MainPageViewModel(this._context);

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  void goforutonaUseAgreementPolicy() {
    Navigator.of(_context).push(
      MaterialPageRoute(
        builder: (_)=>G022MainPage("포루투나 이용약관","forutonaUseAgreement")
      )
    );
  }

  void goPersonalInformationProtectionPolicy() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G022MainPage("개인정보 보호정책","personalInformationProtection")
        )
    );
  }

  goPositionInformationProtectionPolicy() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G022MainPage("위치정보 보호정책","positionInformationProtection")
        )
    );
  }

  void goOpenSourceProtectionPolicy() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G022MainPage("오픈소스 라이센스","openSourceProtection")
        )
    );
  }

  void goCompanyIntroduce() {
    Navigator.of(_context).push(
        MaterialPageRoute(
            builder: (_)=>G023MainPage()
        )
    );
  }
}