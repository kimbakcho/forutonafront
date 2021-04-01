import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/SignValid/FireBaseValidErrorUtil.dart';

import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/Components/BackButton/BorderCircleBackButton.dart';
import 'package:forutonafront/Components/CloseButton/BottomSheetCloseButton.dart';
import 'package:forutonafront/Page/LCodePage/L012/L012MainPage.dart';

import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L009BottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => L009BottomSheetViewModel(sl(),sl()),
        child: Consumer<L009BottomSheetViewModel>(builder: (_, model, child) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                  child: Stack(children: [
                SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      Row(
                        children: [
                          Padding(
                              padding: EdgeInsets.only(left: 16, top: 16),
                              child: BorderCircleBackButton()),
                          Padding(
                            padding: EdgeInsets.only(right: 16, top: 16),
                            child: BottomSheetCloseButton(),
                          )
                        ],
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 32),
                          child: Text('이메일 로그인',
                              style: GoogleFonts.notoSans(
                                fontSize: 24,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                              ))),
                      Container(
                          margin: EdgeInsets.only(left: 32),
                          child: Text('가입하신 이메일 주소로 로그인해주세요.',
                              style: GoogleFonts.notoSans(
                                fontSize: 12,
                                color: const Color(0xff3a3e3f),
                                letterSpacing: -0.24,
                                height: 2.0833333333333335,
                              ))),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 32, right: 32),
                        child: TextField(
                          controller: model._emailEditController,
                          decoration: InputDecoration(
                              hintText: "아이디(이메일 주소)",
                              hintStyle: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xffb1b1b1),
                                letterSpacing: 0.28,
                              )),
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: EdgeInsets.only(left: 32, right: 32),
                        child: TextField(
                          controller: model._pwEditController,
                          obscureText: true,
                          decoration: InputDecoration(
                              hintText: "비밀번호",
                              hintStyle: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xffb1b1b1),
                                letterSpacing: 0.28,
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                        Container(
                            margin: EdgeInsets.only(right: 16),
                            child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                    onTap: () {
                                      model._jumpToFindPWPage(context);
                                    },
                                    child: Text('혹시 비밀번호를 분실하셨나요?',
                                        style: GoogleFonts.notoSans(
                                          fontSize: 12,
                                          color: const Color(0xffff4f9a),
                                          letterSpacing: -0.24,
                                          height: 2.0833333333333335,
                                        )))))
                      ]),
                      SizedBox(
                        height: 23,
                      ),
                      Row(children: [
                        Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 16, left: 16),
                                child: Material(
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Color(model._isCanLoginTry
                                                ? 0xff4F72FF
                                                : 0xffE4E7E8),
                                            width: 1),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0))),
                                    color: Color(model._isCanLoginTry
                                        ? 0xff3497FD
                                        : 0xffF2F3F5),
                                    child: InkWell(
                                        onTap: () {
                                          if(model._isCanLoginTry) {
                                            model.login(context);

                                          }

                                        },
                                        customBorder: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(15.0))),
                                        child: Container(
                                            height: 40,
                                            child: Center(
                                                child: Text("로그인",
                                                    style: GoogleFonts.notoSans(
                                                      fontSize: 16,
                                                      color: model._isCanLoginTry ? Colors.white :  Color(0xffb1b1b1),
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ))))))))
                      ])
                    ]))
              ])));
        }));
  }
}

class L009BottomSheetViewModel extends ChangeNotifier {
  TextEditingController _emailEditController;

  TextEditingController _pwEditController;

  String _currentEmailText = "";

  String _currentPwText = "";

  FluttertoastAdapter _fluttertoastAdapter;

  SnsLoginModuleAdapterFactory _snsLoginModuleAdapterFactory;

  L009BottomSheetViewModel(this._snsLoginModuleAdapterFactory,this._fluttertoastAdapter) {

    _emailEditController = TextEditingController();

    _emailEditController.addListener(() {
      _currentEmailText = _emailEditController.text;
      notifyListeners();
    });

    _pwEditController = TextEditingController();

    _pwEditController.addListener(() {
      _currentPwText = _pwEditController.text;
      notifyListeners();
    });

  }

  bool get _isCanLoginTry {
    return _currentEmailText.isNotEmpty && _currentPwText.isNotEmpty;
  }

  Future<void> login(BuildContext context) async{
    LoginUseCaseInputPort loginUseCaseInputPort = LoginUseCase(
      snsLoginModuleAdapter: _snsLoginModuleAdapterFactory.getForutonaLoginAdapterInstance(_currentEmailText, _currentPwText),
      singUpUseCaseInputPort: sl(),
    );
    try{
      await loginUseCaseInputPort.tryLogin();
      Navigator.of(context).popUntil((route) => route.settings.name == '/');
    }catch (ex) {
        FireBaseValidErrorUtil fireBaseValidErrorUtil = FireBaseValidErrorUtil();
       var errorText = fireBaseValidErrorUtil.getErrorText(ex);
       _fluttertoastAdapter.showToast(msg: errorText);
    }
  }

  _jumpToFindPWPage(BuildContext context){
    Navigator.of(context).push(MaterialPageRoute(builder: (_){
      return L012MainPage();
    }));
  }

}
