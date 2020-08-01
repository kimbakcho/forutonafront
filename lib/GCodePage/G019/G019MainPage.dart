
import 'package:flutter/material.dart';
import 'package:forutonafront/GCodePage/G019/G019MainPageViewModel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class G019MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => G019MainPageViewModel(context),
        child: Consumer<G019MainPageViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Positioned(
                          top: 0, left: 0, child: topBar(model, context)),
                      Positioned(top: 65, left: 0, child: qAndABtnBar(context)),
                      Positioned(top: 121, left: 0, child: policyColumn(model,context)),
                      Positioned(
                        top: 320,
                        left: 0,
                        child: companyIntroductionBar(model,context),
                      )
                    ])))
          ]);
        }));
  }

  Container companyIntroductionBar(G019MainPageViewModel model,BuildContext context) {
    return Container(
        height: 48.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goCompanyIntroduce,
            child: Container(
                height: 48.00,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                alignment: Alignment.centerLeft,
                child: Text("회사소개",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1))));
  }

  Column policyColumn(G019MainPageViewModel model,BuildContext context) {
    return Column(
      children: <Widget>[
        forutonaUseAgreementBtnBar(model,context),
        personalInformationProtectionPolicyBtnBar(model,context),
        positionInformationProtectionPolicyBtnBar(model,context),
        openSourceProtectionPolicyBtnBar(model,context),
      ],
    );
  }

  Container openSourceProtectionPolicyBtnBar(G019MainPageViewModel model,BuildContext context) {
    return Container(
        height: 48.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goOpenSourceProtectionPolicy,
            child: Container(
                height: 48.00,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                alignment: Alignment.centerLeft,
                child: Text("오픈소스 라이센스",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1))));
  }

  Container positionInformationProtectionPolicyBtnBar(
      G019MainPageViewModel model,BuildContext context) {
    return Container(
        height: 48.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goPositionInformationProtectionPolicy,
            child: Container(
                height: 48.00,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                alignment: Alignment.centerLeft,
                child: Text("위치정보 보호정책",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1))));
  }

  Container personalInformationProtectionPolicyBtnBar(
      G019MainPageViewModel model,BuildContext context) {
    return Container(
        height: 48.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goPersonalInformationProtectionPolicy,
            child: Container(
                height: 48.00,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                alignment: Alignment.centerLeft,
                child: Text("개인정보 보호정책",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1))));
  }

  Container forutonaUseAgreementBtnBar(G019MainPageViewModel model,BuildContext context) {
    return Container(
        height: 48.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goforutonaUseAgreementPolicy,
            child: Container(
                height: 48.00,
                padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                alignment: Alignment.centerLeft,
                child: Text("포루투나 이용약관",
                    style: GoogleFonts.notoSans(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1))));
  }

  Container qAndABtnBar(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 48.00,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Container(
              height: 48.00,
              padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
              alignment: Alignment.centerLeft,
              child: Text("Q&A",
                  style: GoogleFonts.notoSans(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Color(0xff454f63),
                  )))),
      color: Color(0xffffffff),
    );
  }

  topBar(G019MainPageViewModel model, BuildContext context) {
    return Container(
      height: 56,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48),
        Container(
            child: Text("설정",
                style: GoogleFonts.notoSans(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
