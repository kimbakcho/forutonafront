import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class G010MainPageViewModel extends ChangeNotifier
    implements SignInUserInfoUseCaseOutputPort {
  final BuildContext context;
  final SignValid _nickNameValid;
  final TextEditingController nickNameController;
  final TextEditingController userIntroduceController;
  final SignInUserInfoUseCase _signInUserInfoUseCase;
  final UserProfileImageUploadUseCaseInputPort
      _userProfileImageUploadUseCaseInputPort;
  final UpdateAccountUserInfoUseCaseInputPort
      _updateAccountUserInfoUseCaseInputPort;

  FUserInfoResDto _fUserInfoResDto;
  CodeCountry _countryCode = new CodeCountry();
  File _currentPickProfileImage;
  String _currentIsoCode;
  bool _isChangeProfileImage = false;
  int nickNameInputTextLength = 0;
  int userIntroduceInputTextLength = 0;
  bool isCanNotUseNickNameDisPlay = false;
  ImageProvider currentProfileImage;

  Preference _preference = sl();

  bool _isLoading = false;

  getIsLoading() {
    return _isLoading;
  }

  _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  G010MainPageViewModel(
      {@required
          this.context,
      @required
          SignValid nickNameValid,
      @required
          this.nickNameController,
      @required
          this.userIntroduceController,
      @required
          SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort,
      @required
          UserProfileImageUploadUseCaseInputPort
              userProfileImageUploadUseCaseInputPort,
      @required
          UpdateAccountUserInfoUseCaseInputPort
              updateAccountUserInfoUseCaseInputPort})
      : _nickNameValid = nickNameValid,
        _signInUserInfoUseCase = signInUserInfoUseCaseInputPort,
        _userProfileImageUploadUseCaseInputPort =
            userProfileImageUploadUseCaseInputPort,
        _updateAccountUserInfoUseCaseInputPort =
            updateAccountUserInfoUseCaseInputPort {
    nickNameController.addListener(_onNickNameControllerListener);
    userIntroduceController.addListener(_onUserIntroduceControllerListener);
    _signInUserInfoUseCase.reqSignInUserInfoFromMemory(outputPort: this);
  }

  onCompleteTap() async {
    _setIsLoading(true);
    FUserAccountUpdateReqDto reqDto = new FUserAccountUpdateReqDto();
    await setNickName(reqDto);

    if (_nickNameValid.hasError()) {
      isCanNotUseNickNameDisPlay = true;
      return;
    } else {
      isCanNotUseNickNameDisPlay = false;
    }

    await setProfileImage(reqDto);

    setSelfIntroduce(reqDto);

    reqDto.isoCode = _currentIsoCode;

    _fUserInfoResDto = await _updateAccountUserInfoUseCaseInputPort.updateAccountUserInfo(reqDto);

    Fluttertoast.showToast(
        msg: "수정 되었습니다.",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIos: 4,
        backgroundColor: Color(0xff454F63),
        textColor: Colors.white,
        fontSize: 12.0);

    Navigator.of(context).pop();
  }

  void setSelfIntroduce(FUserAccountUpdateReqDto reqDto) {
    reqDto.selfIntroduction = userIntroduceController.text;
  }

  Future setProfileImage(FUserAccountUpdateReqDto reqDto) async {
    if (_isChangeProfileImage && _currentPickProfileImage != null) {
      reqDto.userProfileImageUrl = await _userProfileImageUploadUseCaseInputPort
          .upload(_currentPickProfileImage);
    } else if (_isChangeProfileImage && _currentPickProfileImage == null) {
      reqDto.userProfileImageUrl = _preference.basicProfileImageUrl;
    } else {
      reqDto.userProfileImageUrl = _fUserInfoResDto.profilePictureUrl;
    }
  }

  Future setNickName(FUserAccountUpdateReqDto reqDto) async {
    if (isChangeNickName()) {
      await _nickNameValid.valid(nickNameController.text);
      if (!_nickNameValid.hasError()) {
        reqDto.nickName = nickNameController.text;
      }
    } else {
      reqDto.nickName = _fUserInfoResDto.nickName;
    }
  }

  bool isChangeNickName() =>
      nickNameController.text != _fUserInfoResDto.nickName;

  _onNickNameControllerListener() {
    nickNameInputTextLength = nickNameController.text.length;
    isCanNotUseNickNameDisPlay = false;
    notifyListeners();
  }

  void onChangeProfileImageTab() async {
    var result = await showGeneralDialog(
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
                              currentProfileImage = NetworkImage(
                                  _preference.basicProfileImageUrl);
                              _isChangeProfileImage = true;
                              notifyListeners();
                              Navigator.of(_context).pop();
                            },
                            child: Text("기본이미지",
                                style: GoogleFonts.notoSans(
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
                                style: GoogleFonts.notoSans(
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

  onEditCompleteNickName() async {
    _setIsLoading(true);
    await _nickNameValid.valid(nickNameController.text);
    isCanNotUseNickNameDisPlay = _nickNameValid.hasError() ? true : false;
    _setIsLoading(false);
  }

  bool hasNickNameError() {
    return _nickNameValid.hasError();
  }

  String nickNameErrorText() {
    return _nickNameValid.errorText();
  }

  _onUserIntroduceControllerListener() {
    userIntroduceInputTextLength = userIntroduceController.text.length;
    notifyListeners();
  }

  textFieldUnFocus() {
    FocusScope.of(context).requestFocus(new FocusNode());
  }

  bool isValidComplete() {
    if (nickNameController.text.length > 0 && !isCanNotUseNickNameDisPlay) {
      return true;
    } else {
      return false;
    }
  }

  void onBackBtnTap() {
    Navigator.of(context).pop();
  }

  String getUserCountry() {
    if (_fUserInfoResDto != null) {
      return _countryCode.findCountryName(_currentIsoCode);
    } else {
      return "";
    }
  }

  jumpCountrySelect() async {
    String isoCode = await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CountrySelectPage(
              countryCode: _fUserInfoResDto.isoCode,
            )));
    if (isoCode != null) {
      _currentIsoCode = isoCode;
      notifyListeners();
    }
  }

  Container didver(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffe4e7e8),
    );
  }

  @override
  void onSignInUserInfoFromMemory(FUserInfoResDto fUserInfoResDto) {
    _fUserInfoResDto = fUserInfoResDto;
    currentProfileImage = NetworkImage(_fUserInfoResDto.profilePictureUrl);
    _currentIsoCode = _fUserInfoResDto.isoCode;
    nickNameController.text = _fUserInfoResDto.nickName;
    userIntroduceController.text = _fUserInfoResDto.selfIntroduction;
  }
}
