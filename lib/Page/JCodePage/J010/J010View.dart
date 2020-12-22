import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart';
import 'package:forutonafront/Page/JCodePage/J010/J010ViewModel.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:international_phone_input/international_phone_input.dart';
import 'package:provider/provider.dart';

class J010View extends StatelessWidget {
  final TextEditingController authNumberEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => J010ViewModel(
          context: context,
          authNumberEditingController: authNumberEditingController,
          phoneFindValidUseCase:
              PhoneFindValidUseCaseImpl(phoneAuthRepository: sl()),
          pwFindPhoneUseCaseInputPort: sl()
      ),
      child: Consumer<J010ViewModel>(
        builder: (_, model, child) {
          return Stack(children: <Widget>[
            Scaffold(
                backgroundColor: Color(0xffF2F0F1),
                body: Container(
                    padding: EdgeInsets.fromLTRB(
                        0, MediaQuery.of(context).padding.top, 0, 0),
                    child: Stack(children: <Widget>[
                      Column(children: <Widget>[
                        topBar(model),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            padding: EdgeInsets.all(0),
                            children: <Widget>[
                              phoneInputBar(model),
                              phoneAuthNumberInputBar(model),
                              remindTimeDisplayBar(model),
                              authTryBtnBar(context, model)
                            ],
                          ),
                        )
                      ]),
                      joinProgressBar(context)
                    ]))),
            model.getIsLoading() ? CommonLoadingComponent() : Container()
          ]);
        },
      ),
    );
  }

  Positioned joinProgressBar(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      height: 10,
      width: MediaQuery.of(context).size.width,
      child: Container(
        height: 10,
        child: LinearProgressIndicator(
          value: 0.66,
          backgroundColor: Color(0xffCCCCCC),
          valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3497FD)),
        ),
      ),
    );
  }

  Container authTryBtnBar(BuildContext context, J010ViewModel model) {
    return Container(
      height: 50.00,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.fromLTRB(16, 50, 16, 16),
      child: FlatButton(
        onPressed: model.isCanAuthNumberReq() ? model.reqNumberAuthReq : null,
        child: Text("인증번호 확인",
            style: GoogleFonts.notoSans(
              locale: Locale("ko"),
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color:
                  model.isCanAuthNumberReq() ? Colors.white : Color(0xff7a7a7a),
            )),
      ),
      decoration: BoxDecoration(
        color:
            model.isCanAuthNumberReq() ? Color(0xff3497FD) : Color(0xffd4d4d4),
        border: Border.all(
          width: 1.00,
          color: model.isCanAuthNumberReq()
              ? Color(0xff4F72FF)
              : Color(0xffb1b1b1),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(8.00),
      ),
    );
  }

  Container remindTimeDisplayBar(J010ViewModel model) {
    return Container(
      margin: EdgeInsets.only(left: 16),
      child: RichText(
        text: TextSpan(
            text: "인증번호는 30분간 유효합니다.\n인증번호는",
            style: GoogleFonts.notoSans(
              locale: Locale("ko"),
              fontWeight: FontWeight.w300,
              fontSize: 13,
              color: Color(0xff454f63),
            ),
            children: [
              TextSpan(
                  text: "${model.isReqRemindTimeSec()}초 ",
                  style: GoogleFonts.notoSans(
                    locale: Locale("ko"),
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    color: Color(0xffFF4F9A),
                  )),
              TextSpan(
                  text: "후에 다시 요청하실 수 있습니다.",
                  style: GoogleFonts.notoSans(
                    locale: Locale("ko"),
                    fontWeight: FontWeight.w300,
                    fontSize: 13,
                    color: Color(0xff454f63),
                  ))
            ]),
      ),
    );
  }

  Container phoneAuthNumberInputBar(J010ViewModel model) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 0, 16, 10),
        child: Row(
          children: <Widget>[
            Expanded(
                child: Container(
                    height: 50,
                    child: TextField(
                        controller: model.authNumberEditingController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 16),
                            hintText: "인증번호 입력",
                            hintStyle: GoogleFonts.notoSans(
                              locale: Locale("ko"),
                              fontSize: 15,
                              color: Color(0xff78849e).withOpacity(0.56),
                            ),
                            fillColor: Colors.white,
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: Color(0xffF2F0F1)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0, color: Color(0xff3497FD)),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))))))),
            Container(
                margin: EdgeInsets.only(left: 16),
                width: 111,
                height: 50,
                child: FlatButton(
                    onPressed: model.isCanRequest() ? model.reqPhoneAuth : null,
                    padding: EdgeInsets.all(0),
                    child: Text("인증 번호 요청",
                        style: GoogleFonts.notoSans(
                          locale: Locale("ko"),
                          fontSize: 15,
                          color: model.isCanRequest()
                              ? Colors.white
                              : Color(0xff7a7a7a),
                        ))),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: model.isCanRequest()
                        ? Color(0xff3497FD)
                        : Color(0xffD4D4D4),
                    border: Border.all(
                        color: model.isCanRequest()
                            ? Color(0xff3497FD)
                            : Color(0xffB1B1B1))))
          ],
        ));
  }

  Container phoneInputBar(J010ViewModel model) {
    return Container(
        margin: EdgeInsets.fromLTRB(16, 16, 16, 21),
        child: InternationalPhoneInput(
            onPhoneNumberChange: model.onPhoneNumberChange,
            initialPhoneNumber: "",
            hintText: "휴대폰 번호 입력",
            hintStyle: GoogleFonts.notoSans(locale: Locale("ko")),
            errorText: "양식에 맞지 않습니다.",
            initialSelection: "KR"),
        decoration: BoxDecoration(
          color: Color(0xffffffff),
          boxShadow: [
            BoxShadow(
              offset: Offset(0.00, 4.00),
              color: Color(0xff455b63).withOpacity(0.08),
              blurRadius: 16,
            )
          ],
          borderRadius: BorderRadius.circular(12.00),
        ));
  }

  Container topBar(J010ViewModel model) {
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
            child: Text("휴대폰 인증",
                style: TextStyle(
                  fontFamily: "Noto Sans CJK KR",
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                  color: Color(0xff454f63),
                ))),
        Spacer()
      ]),
    );
  }
}
