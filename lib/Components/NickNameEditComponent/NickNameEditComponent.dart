import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SignValid/BasicUseCase/NickNameValidImpl.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NickNameEditComponent extends StatelessWidget {
  //기존 유저 닉네임 -> 만약 valid 할때 자기 닉네임과 같으면 valid 하지 않기 위해서
  final String userNickName;

  final NickNameEditComponentController nickNameEditComponentController;

  const NickNameEditComponent(
      {Key key, this.userNickName, this.nickNameEditComponentController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => NickNameEditComponentViewModel(
            userNickName: userNickName,
            nickNameEditComponentController: nickNameEditComponentController),
        child: Consumer<NickNameEditComponentViewModel>(
            builder: (_, model, child) {
          return Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(
                  '닉네임 (필수)',
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                  textAlign: TextAlign.left,
                ),
                TextField(
                    controller: model._nickNameEditController,
                    maxLength: 20,
                    decoration: InputDecoration(
                        errorText: model.currentIsError
                            ? model.currentErrorText
                            : null,
                        counterStyle: GoogleFonts.notoSans(
                          fontSize: 10,
                          color: const Color(0xffd4d4d4),
                        ),
                        hintText: "닉네임을 입력해주세요",
                        hintStyle: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: const Color(0xffb1b1b1),
                          letterSpacing: -0.28,
                          fontWeight: FontWeight.w300,
                          height: 1.2142857142857142,
                        )))
              ]));
        }));
  }
}

class NickNameEditComponentViewModel extends ChangeNotifier {
  final String userNickName;

  SignValid _nickNameValid;

  TextEditingController _nickNameEditController;

  NickNameEditComponentController nickNameEditComponentController;

  NickNameEditComponentViewModel(
      {this.userNickName, this.nickNameEditComponentController})
      : _nickNameValid = NickNameValidImpl(fUserRepository: sl()) {
    _nickNameEditController = TextEditingController();
    if (nickNameEditComponentController != null) {
      nickNameEditComponentController._nickNameEditComponentViewModel = this;
    }
    if (nickNameEditComponentController != null &&
        nickNameEditComponentController.onChangeNickNameText != null) {
      _nickNameEditController.addListener(() {
        nickNameEditComponentController
            .onChangeNickNameText(_nickNameEditController.text);
      });
    }
  }

  _valid() async {
    if (userNickName == null) {
      await _nickNameValid.valid(_nickNameEditController.text);
    } else if (userNickName != null &&
        userNickName != _nickNameEditController.text) {
      await _nickNameValid.valid(_nickNameEditController.text);
    }
    notifyListeners();
  }

  bool get currentIsError {
    return _nickNameValid.hasValidTry && _nickNameValid.hasError();
  }

  String get currentErrorText {
    return _nickNameValid.errorText();
  }
}

class NickNameEditComponentController {
  NickNameEditComponentViewModel _nickNameEditComponentViewModel;

  final Function(String) onChangeNickNameText;

  NickNameEditComponentController({this.onChangeNickNameText});


  get nickNameValue {
    return _nickNameEditComponentViewModel._nickNameEditController.text;
  }

  Future<bool> valid() async {
    await _nickNameEditComponentViewModel._valid();
    return _nickNameEditComponentViewModel.currentIsError;
  }
}
