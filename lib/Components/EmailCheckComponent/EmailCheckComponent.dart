import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailCheckComponent extends StatelessWidget {
  final EmailCheckComponentController emailCheckComponentController;

  final SignValid emailValid;

  const EmailCheckComponent(
      {Key key, this.emailCheckComponentController, this.emailValid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => EmailCheckComponentViewModel(emailValid: emailValid,emailCheckComponentController: emailCheckComponentController),
        child:
            Consumer<EmailCheckComponentViewModel>(builder: (_, model, child) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  "아이디",
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                ),
                Row(children: [
                  Expanded(
                      child: Stack(children: [
                    TextField(
                        controller: model._emailEditingController,
                        decoration: InputDecoration(
                            errorText:
                                model._hasError ? model._errorText : null,
                            hintText: "이메일주소",
                            hintStyle: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xffb1b1b1),
                              letterSpacing: -0.28,
                              fontWeight: FontWeight.w300,
                              height: 1.2142857142857142,
                            )),
                        keyboardType: TextInputType.emailAddress,
                    ),
                    model._satisfied
                        ? Positioned(
                            right: 0,
                            top: 13,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                            ))
                        : Container()
                  ]))
                ])
              ]));
        }));
  }
}

class EmailCheckComponentViewModel extends ChangeNotifier {
  TextEditingController _emailEditingController;

  SignValid emailValid;

  final EmailCheckComponentController emailCheckComponentController;

  String _errorText = "";

  bool _tryValid = false;

  bool _hasError = false;

  EmailCheckComponentViewModel(
      {this.emailCheckComponentController, this.emailValid})
      : _emailEditingController = TextEditingController() {
    if (this.emailCheckComponentController != null) {
      this.emailCheckComponentController._emailCheckComponentViewModel = this;
    }
    _emailEditingController.addListener(() {
      onChangeEditText(_emailEditingController.text);
    });
  }

  onChangeEditText(String value) {
    if (emailCheckComponentController != null &&
        emailCheckComponentController.onChangeEditText != null) {
      emailCheckComponentController.onChangeEditText(value);
    }
  }

  Future<bool> _valid() async {
    _tryValid = true;
    if (emailValid == null) {
      return false;
    }
    await emailValid.valid(_emailEditingController.text);
    _errorText = emailValid.errorText();
    _hasError = emailValid.hasError();
    return !_hasError;
  }

  bool get _satisfied {
    if (_tryValid && !_hasError) {
      return true;
    } else {
      return false;
    }
  }
}

class EmailCheckComponentController {
  EmailCheckComponentViewModel _emailCheckComponentViewModel;

  Function(String) onChangeEditText;

  EmailCheckComponentController({this.onChangeEditText});

  String get emailValue {
    if (_emailCheckComponentViewModel == null) {
      return "";
    } else {
      return _emailCheckComponentViewModel._emailEditingController.text;
    }
  }

  Future<bool> valid() async {
    var result = await _emailCheckComponentViewModel._valid();

    _emailCheckComponentViewModel.notifyListeners();

    return result;
  }
}
