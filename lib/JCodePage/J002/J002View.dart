import 'package:flutter/material.dart';
import 'package:forutonafront/Common/ProgressIndicator/CommonLinearProgressIndicator.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/JCodePage/J002/J002ViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class J002View extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => J002ViewModel(context: context,singUpUseCaseInputPort: sl()),
        child: Consumer<J002ViewModel>(builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
              backgroundColor: Color(0xffF2F0F1),
                body: Container(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Column(children: <Widget>[
                          topBar(model),
                          allAgreeBtnBar(context, model),
                          detailAgreeBar(context, model),
                        ]),
                        joinProgressBar(context)
                      ],
                    )))
          ]);
        }));
  }

  Positioned joinProgressBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      height: 9,
      width: MediaQuery.of(context).size.width,
      child: CommonLinearProgressIndicator(0.25),
    );
  }

  Container detailAgreeBar(BuildContext context, J002ViewModel model) {
    return Container(
        height: 330.00,
        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
        width: MediaQuery.of(context).size.width,
        child: Column(children: <Widget>[
          serviceUseAgreeBar(context, model),
          didver(context),
          serviceManagementAgreeBar(context, model),
          didver(context),
          personalInformationCollectionAgreeBar(context, model),
          didver(context),
          positionInformationCollectionAgreeBar(context, model),
          didver(context),
          marketingInformationReceiveAgreeBar(context, model),
          didver(context),
          ageOverAgreeBar(context, model)
        ]),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16,
              ),
            ],
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container didver(BuildContext context) {
    return Container(
      height: 1.00,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffe4e7e8),
    );
  }

  Container ageOverAgreeBar(BuildContext context, J002ViewModel model) {
    return Container(
        height: 54.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            onPressed: model.onAgeOverAgree,
            padding: EdgeInsets.all(0),
            child: Stack(children: <Widget>[
              Positioned(
                  left: 16,
                  top: 14,
                  child: Container(
                      width: 28,
                      height: 28,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: -2,
                            right: -2,
                            child: Icon(ForutonaIcon.check,
                                color: Colors.white, size: 30))
                      ]),
                      decoration: BoxDecoration(
                          color: model.ageOverAgree
                              ? Color(0xff3497FD)
                              : Color(0xffB1B1B1),
                          shape: BoxShape.circle))),
              Positioned(
                top: 0,
                left: 52,
                child: Container(
                    margin: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("만 14세 이상입니다.",
                        style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454f63)))),
              ),
              Positioned(
                top: 40,
                left: 52,
                child: Container(
                    child: Text("만 14세 미만의 어린이는 가입을 제한하고 있습니다.",
                        style: TextStyle(
                          fontFamily: "Noto Sans CJK KR",
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                          color: Color(0xff78849e),
                        ))),
              )
            ])),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container marketingInformationReceiveAgreeBar(
      BuildContext context, J002ViewModel model) {
    return Container(
        height: 52.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            onPressed: model.onMarketingInformationReceiveAgree,
            padding: EdgeInsets.all(0),
            child: Stack(children: <Widget>[
              Positioned(
                  left: 16,
                  top: 14,
                  child: Container(
                      width: 28,
                      height: 28,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: -2,
                            right: -2,
                            child: Icon(ForutonaIcon.check,
                                color: Colors.white, size: 30))
                      ]),
                      decoration: BoxDecoration(
                          color: model.marketingInformationReceiveAgree
                              ? Color(0xff3497FD)
                              : Color(0xffB1B1B1),
                          shape: BoxShape.circle))),
              Positioned(
                top: 0,
                left: 52,
                child: Container(
                    margin: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("마케팅 정보 메일 수신 동의(선택)",
                        style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454f63)))),
              ),
            ])),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container positionInformationCollectionAgreeBar(
      BuildContext context, J002ViewModel model) {
    return Container(
        height: 52.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            onPressed: model.onPositionInformationCollectionAgree,
            padding: EdgeInsets.all(0),
            child: Stack(children: <Widget>[
              Positioned(
                  left: 16,
                  top: 14,
                  child: Container(
                      width: 28,
                      height: 28,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: -2,
                            right: -2,
                            child: Icon(ForutonaIcon.check,
                                color: Colors.white, size: 30))
                      ]),
                      decoration: BoxDecoration(
                          color: model.positionInformationCollectionAgree
                              ? Color(0xff3497FD)
                              : Color(0xffB1B1B1),
                          shape: BoxShape.circle))),
              Positioned(
                top: 0,
                left: 52,
                child: Container(
                    margin: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("위치정보 활용 동의",
                        style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454f63)))),
              ),
              Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                      width: 24,
                      height: 24,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed:
                              model.onPositionInformationCollectionPolicyViewer,
                          child: Icon(
                            ForutonaIcon.chevron_right,
                            color: Color(0xff454F63),
                            size: 24,
                          ))))
            ])),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container personalInformationCollectionAgreeBar(
      BuildContext context, J002ViewModel model) {
    return Container(
        height: 52.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            onPressed: model.onPersonalInformationCollectionAgree,
            padding: EdgeInsets.all(0),
            child: Stack(children: <Widget>[
              Positioned(
                  left: 16,
                  top: 14,
                  child: Container(
                      width: 28,
                      height: 28,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: -2,
                            right: -2,
                            child: Icon(ForutonaIcon.check,
                                color: Colors.white, size: 30))
                      ]),
                      decoration: BoxDecoration(
                          color: model.personalInformationCollectionAgree
                              ? Color(0xff3497FD)
                              : Color(0xffB1B1B1),
                          shape: BoxShape.circle))),
              Positioned(
                top: 0,
                left: 52,
                child: Container(
                    margin: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("개인정보 수집 이용 동의",
                        style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454f63)))),
              ),
              Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                      width: 24,
                      height: 24,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed:
                              model.onPersonalInformationCollectionPolicyViewer,
                          child: Icon(
                            ForutonaIcon.chevron_right,
                            color: Color(0xff454F63),
                            size: 24,
                          ))))
            ])),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container serviceManagementAgreeBar(
      BuildContext context, J002ViewModel model) {
    return Container(
        height: 52.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            onPressed: model.onServiceManagementAgreeClick,
            padding: EdgeInsets.all(0),
            child: Stack(children: <Widget>[
              Positioned(
                  left: 16,
                  top: 14,
                  child: Container(
                      width: 28,
                      height: 28,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: -2,
                            right: -2,
                            child: Icon(ForutonaIcon.check,
                                color: Colors.white, size: 30))
                      ]),
                      decoration: BoxDecoration(
                          color: model.serviceManagement
                              ? Color(0xff3497FD)
                              : Color(0xffB1B1B1),
                          shape: BoxShape.circle))),
              Positioned(
                top: 0,
                left: 52,
                child: Container(
                    margin: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("서비스 운영 정책 동의",
                        style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454f63)))),
              ),
              Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                      width: 24,
                      height: 24,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: model.onServiceManagementPolicyViewer,
                          child: Icon(
                            ForutonaIcon.chevron_right,
                            color: Color(0xff454F63),
                            size: 24,
                          ))))
            ])),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container serviceUseAgreeBar(BuildContext context, J002ViewModel model) {
    return Container(
        height: 52.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            onPressed: model.onServiceUseAgreeClick,
            padding: EdgeInsets.all(0),
            child: Stack(children: <Widget>[
              Positioned(
                  left: 16,
                  top: 14,
                  child: Container(
                      width: 28,
                      height: 28,
                      child: Stack(children: <Widget>[
                        Positioned(
                            top: -2,
                            right: -2,
                            child: Icon(ForutonaIcon.check,
                                color: Colors.white, size: 30))
                      ]),
                      decoration: BoxDecoration(
                          color: model.serviceUseAgree
                              ? Color(0xff3497FD)
                              : Color(0xffB1B1B1),
                          shape: BoxShape.circle))),
              Positioned(
                top: 0,
                left: 52,
                child: Container(
                    margin: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("서비스 이용약관 동의",
                        style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454f63)))),
              ),
              Positioned(
                  right: 16,
                  top: 16,
                  child: Container(
                      width: 24,
                      height: 24,
                      child: FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: model.onServiceUseAgreePolicyViewer,
                          child: Icon(
                            ForutonaIcon.chevron_right,
                            color: Color(0xff454F63),
                            size: 24,
                          ))))
            ])),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container allAgreeBtnBar(BuildContext context, J002ViewModel model) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 16),
        height: 52.00,
        width: MediaQuery.of(context).size.width,
        child: FlatButton(
            onPressed: model.onAllAgreeClick,
            padding: EdgeInsets.all(0),
            child: Stack(children: <Widget>[
              Positioned(
                  left: 16,
                  top: 14,
                  child: Container(
                    width: 28,
                    height: 28,
                    child: Stack(children: <Widget>[
                      Positioned(
                          top: -2,
                          right: -2,
                          child: Icon(ForutonaIcon.check,
                              color: Colors.white, size: 30))
                    ]),
                    decoration: BoxDecoration(
                        color: model.allAgree
                            ? Color(0xff3497FD)
                            : Color(0xffB1B1B1),
                        shape: BoxShape.circle),
                  )),
              Positioned(
                top: 0,
                left: 52,
                child: Container(
                    margin: EdgeInsets.only(top: 16,bottom: 16),
                    child: Text("모든 약관에 동의합니다.",
                        style: TextStyle(
                            fontFamily: "Noto Sans CJK KR",
                            fontSize: 14,
                            color: Color(0xff454F63 )))),
              )
            ])),
        decoration: BoxDecoration(
            color: Color(0xffffffff),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 4.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16,
              )
            ],
            borderRadius: BorderRadius.circular(12.00)));
  }

  Container topBar(J002ViewModel model) {
    return Container(
      height: 56,
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
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer(),
        Container(
          height: 32.00,
          width: 75.00,
          margin: EdgeInsets.only(right: 16),
          child: FlatButton(
            onPressed: model.nextBtnFlag() ? model.onNextBtnClick : null,
            child: Text("다음",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: model.nextBtnFlag() ? Colors.black : Color(0xffb1b1b1),
                )),
          ),
          decoration: BoxDecoration(
            color: model.nextBtnFlag() ? Colors.white : Color(0xffd4d4d4),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.00, 12.00),
                color: Color(0xff455b63).withOpacity(0.08),
                blurRadius: 16,
              ),
            ],
            border: model.nextBtnFlag()
                ? Border.all(color: Colors.black, width: 1)
                : null,
            borderRadius: BorderRadius.circular(5.00),
          ),
        )
      ]),
    );
  }
}
