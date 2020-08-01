import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:image_picker/image_picker.dart';

class J007ViewModel extends ChangeNotifier {
  final BuildContext context;
  final SingUpUseCaseInputPort _singUpUseCaseInputPort;
  final SignValid _nickNameValid;
  final UserProfileImageUploadUseCaseInputPort
      _userProfileImageUploadUseCaseInputPort;
  final TextEditingController nickNameController;
  final TextEditingController userIntroduceController;

  ImageProvider currentProfileImage;

  int nickNameInputTextLength = 0;

  int userIntroduceInputTextLength = 0;
  String currentCountryCode = "KR";

  File _currentPickProfileImage;
  bool _isChangeProfileImage = false;
  bool _haveNickNameConfirm = false;
  bool _isLoading = false;

  Preference _preference = sl();

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  J007ViewModel(
      {@required
          this.context,
      @required
          SingUpUseCaseInputPort singUpUseCaseInputPort,
      @required
          SignValid nickNameValid,
      @required
          UserProfileImageUploadUseCaseInputPort
              userProfileImageUploadUseCaseInputPort,
      @required
          this.nickNameController,
      @required
          this.userIntroduceController})
      : _singUpUseCaseInputPort = singUpUseCaseInputPort,
        _nickNameValid = nickNameValid,
        _userProfileImageUploadUseCaseInputPort =
            userProfileImageUploadUseCaseInputPort {
    currentCountryCode = _singUpUseCaseInputPort.getCountryCode();
    currentProfileImage =
        NetworkImage(_singUpUseCaseInputPort.getUserProfileImageUrl());
    nickNameController.text = _singUpUseCaseInputPort.getNickName();
    nickNameInputTextLength = nickNameController.text.length;
    userIntroduceController.addListener(__onUserIntroduceControllerListener);
  }

  bool isCanComplete() {
    if (nickNameController.text.length > 0) {
      return true;
    } else {
      return false;
    }
  }

  __onUserIntroduceControllerListener() {
    userIntroduceInputTextLength = userIntroduceController.text.length;
    notifyListeners();
  }

  onEditCompleteNickName() async {
    _setIsLoading(true);
    _haveNickNameConfirm = true;
    await _nickNameValid.valid(nickNameController.text);
    _setIsLoading(false);
  }

  void onChangeNickName(String value) {
    _haveNickNameConfirm = false;
    nickNameInputTextLength = nickNameController.text.length;
    notifyListeners();
  }

  bool hasNickNameError() {
    if (_haveNickNameConfirm) {
      return _nickNameValid.hasError();
    } else {
      return false;
    }
  }

  String nickNameErrorText() {
    return _nickNameValid.errorText();
  }

  void onBackTap() {
    Navigator.of(context).pop();
  }

  void onCompeleteBtnClick() async {
    _setIsLoading(true);
    await _nickNameValid.valid(nickNameController.text);
    _haveNickNameConfirm = true;
    if (_nickNameValid.hasError()) {
      _setIsLoading(false);
      return;
    }
    _singUpUseCaseInputPort.setNickName(nickNameController.text);

    _singUpUseCaseInputPort.setUserIntroduce(userIntroduceController.text);

    if (_isChangeProfileImage) {
      if (_currentPickProfileImage == null) {
        _singUpUseCaseInputPort
            .setUserProfileImageUrl(_preference.basicProfileImageUrl);
      }
    }

    FUserInfoJoinResDto fUserInfoJoinResDto = await _singUpUseCaseInputPort.joinUser();

    if (fUserInfoJoinResDto.joinComplete) {
      if (_currentPickProfileImage != null) {
        await _userProfileImageUploadUseCaseInputPort
            .upload(_currentPickProfileImage);
      }

      Navigator.of(context).popUntil(ModalRoute.withName('/'));
    } else {
      Fluttertoast.showToast(
          msg: "가입 실패",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
    _setIsLoading(false);
  }

  String getCountryName(String isoCode) {
    CodeCountry _codeCountry = CodeCountry();
    return _codeCountry.findCountryName(isoCode);
  }

  void onCountryChange() async {
    var result =
        await Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return CountrySelectPage(countryCode: currentCountryCode);
    }));
    if (result != null) {
      currentCountryCode = result;
      notifyListeners();
    }
  }

  void onChangeProfileImageTab() async {
    await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        pageBuilder:
            (_context, Animation animation, Animation secondaryAnimation) {
          return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                  child: Container(
                      height: 200.00,
                      width: 221.00,
                      child: Column(children: <Widget>[
                        Container(
                          width: 221,
                          child: FlatButton(
                            onPressed: () {
                              _currentPickProfileImage = null;
                              currentProfileImage =
                                  AssetImage("assets/basicprofileimage.png");
                              _isChangeProfileImage = true;
                              notifyListeners();
                              Navigator.of(_context).pop();
                            },
                            child: Text("기본이미지",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xff454f63),
                                )),
                          ),
                        ),
                        didver(_context),
                        Container(
                          width: 221,
                          child: FlatButton(
                            onPressed: () async {
                              File file = await ImagePicker.pickImage(
                                  source: ImageSource.camera);
                              if (file != null) {
                                _currentPickProfileImage = file;
                                currentProfileImage = FileImage(file);
                                _isChangeProfileImage = true;
                                notifyListeners();
                                Navigator.of(_context).pop();
                              }
                            },
                            child: Text("카메라",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xff454f63),
                                )),
                          ),
                        ),
                        didver(_context),
                        Container(
                          width: 221,
                          child: FlatButton(
                            onPressed: () async {
                              File file = await ImagePicker.pickImage(
                                  source: ImageSource.gallery);
                              if (file != null) {
                                _currentPickProfileImage = file;
                                currentProfileImage = FileImage(file);
                                _isChangeProfileImage = true;
                                notifyListeners();
                                Navigator.of(_context).pop();
                              }
                            },
                            child: Text("갤러리",
                                style: TextStyle(
                                  fontFamily: "Noto Sans CJK KR",
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                  color: Color(0xff454f63),
                                )),
                          ),
                        ),
                        didver(_context),
                        Container(
                            width: 221,
                            child: FlatButton(
                                onPressed: () {
                                  Navigator.of(_context).pop();
                                },
                                child: Text("닫기",
                                    style: TextStyle(
                                      fontFamily: "Noto Sans CJK KR",
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: Color(0xffff4f9a),
                                    ))))
                      ]),
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
                      ))));
        });
    textFieldUnFocus();
  }

  textFieldUnFocus() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  Container didver(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffe4e7e8),
    );
  }
}
