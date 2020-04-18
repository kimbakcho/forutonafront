import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/GCodePage/G019/G019MainPageViewModel.dart';
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
                      Positioned(top: 0, left: 0, child: topBar(model)),
                      Positioned(top: 65.h, left: 0, child: qAndABtnBar()),
                      Positioned(top: 121.h, left: 0, child: policyColumn(model)),
                      Positioned(
                        top: 324.h,
                        left: 0,
                        child: companyIntroductionBar(model),
                      )
                    ])))
          ]);
        }));
  }

  Container companyIntroductionBar(G019MainPageViewModel model) {
    return Container(
        height: 48.00.h,
        width: 360.00.w,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goCompanyIntroduce,
            child: Container(
                height: 48.00.h,
                width: 360.00.w,
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                alignment: Alignment.centerLeft,
                child: Text("회사소개",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Column policyColumn(G019MainPageViewModel model) {
    return Column(
      children: <Widget>[
        forutonaUseAgreementBtnBar(model),
        personalInformationProtectionPolicyBtnBar(model),
        positionInformationProtectionPolicyBtnBar(model),
        openSourceProtectionPolicyBtnBar(model),
      ],
    );
  }

  Container openSourceProtectionPolicyBtnBar(G019MainPageViewModel model) {
    return Container(
        height: 48.00.h,
        width: 360.00.w,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goOpenSourceProtectionPolicy,
            child: Container(
                height: 48.00.h,
                width: 360.00.w,
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                alignment: Alignment.centerLeft,
                child: Text("오픈소스 라이센스",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Container positionInformationProtectionPolicyBtnBar(G019MainPageViewModel model) {
    return Container(
        height: 48.00.h,
        width: 360.00.w,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goPositionInformationProtectionPolicy,
            child: Container(
                height: 48.00.h,
                width: 360.00.w,
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                alignment: Alignment.centerLeft,
                child: Text("위치정보 보호정책",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Container personalInformationProtectionPolicyBtnBar(G019MainPageViewModel model) {
    return Container(
        height: 48.00.h,
        width: 360.00.w,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goPersonalInformationProtectionPolicy,
            child: Container(
                height: 48.00.h,
                width: 360.00.w,
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                alignment: Alignment.centerLeft,
                child: Text("개인정보 보호정책",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Container forutonaUseAgreementBtnBar(G019MainPageViewModel model) {
    return Container(
        height: 48.00.h,
        width: 360.00.w,
        child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: model.goforutonaUseAgreementPolicy,
            child: Container(
                height: 48.00.h,
                width: 360.00.w,
                padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
                alignment: Alignment.centerLeft,
                child: Text("포루투나 이용약관",
                    style: TextStyle(
                      fontFamily: "Noto Sans CJK KR",
                      fontWeight: FontWeight.w500,
                      fontSize: 16.sp,
                      color: Color(0xff454f63),
                    )))),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            border: Border(
                bottom: BorderSide(color: Color(0xfff2f0f1), width: 1.h))));
  }

  Container qAndABtnBar() {
    return Container(
      height: 48.00.h,
      width: 360.00.w,
      child: FlatButton(
          padding: EdgeInsets.all(0),
          onPressed: () {},
          child: Container(
              height: 48.00.h,
              width: 360.00.w,
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 0),
              alignment: Alignment.centerLeft,
              child: Text("Q&A",
                  style: TextStyle(
                    fontFamily: "Noto Sans CJK KR",
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                    color: Color(0xff454f63),
                  )))),
      color: Color(0xffffffff),
    );
  }

  topBar(G019MainPageViewModel model) {
    return Container(
      width: 360.w,
      height: 56.h,
      color: Colors.white,
      child: Row(children: [
        Container(
            child: FlatButton(
                padding: EdgeInsets.all(0),
                onPressed: model.onBackTap,
                child: Icon(Icons.arrow_back)),
            width: 48.w),
        Container(
            child: Text("설정",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20.sp,
                  color: Color(0xff454f63),
                )))
      ]),
    );
  }
}
