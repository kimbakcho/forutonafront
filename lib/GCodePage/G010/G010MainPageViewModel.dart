import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/Common/SignValid/SignValid.dart';
import 'package:forutonafront/ForutonaUser/Data/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseOutputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCaeInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class G010MainPageViewModel extends ChangeNotifier
    implements SignInUserInfoUseCaseOutputPort {
  final BuildContext context;
  final SignValid _nickNameValid;
  final TextEditingController nickNameController;
  final TextEditingController userIntroduceController;
  final SignInUserInfoUseCase _signInUserInfoUseCase;
  final UserProfileImageUploadUseCaseInputPort
      _userProfileImageUploadUseCaseInputPort;
  final UserInfoUpdateUseCaeInputPort _userInfoUpdateUseCaeInputPort;

  FUserInfo _fUserInfo;
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
          UserInfoUpdateUseCaeInputPort userInfoUpdateUseCaeInputPort})
      : _nickNameValid = nickNameValid,
        _signInUserInfoUseCase = signInUserInfoUseCaseInputPort,
        _userProfileImageUploadUseCaseInputPort =
            userProfileImageUploadUseCaseInputPort,
        _userInfoUpdateUseCaeInputPort = userInfoUpdateUseCaeInputPort {
    nickNameController.addListener(_onNickNameControllerListener);
    userIntroduceController.addListener(__onUserIntroduceControllerListener);
    _signInUserInfoUseCase.reqSignInUserInfoFromMemory(outputPort: this);
  }

  _init() async {
    _setIsLoading(true);

    _setIsLoading(false);
  }

  onCompleteTap() async {
    _setIsLoading(true);
    FuserAccountUpdateReqdto reqDto = new FuserAccountUpdateReqdto();
    await setNickName(reqDto);

    if(_nickNameValid.hasError() ){
      isCanNotUseNickNameDisPlay = true;
      return ;
    }else {
      isCanNotUseNickNameDisPlay = false;
    }

    await setProfileImage(reqDto);

    setSelfIntroduce(reqDto);

    var result = await _userInfoUpdateUseCaeInputPort.updateAccountUserInfo(reqDto);

    if (result == 1) {
      await _signInUserInfoUseCase.saveSignInInfoInMemoryFromAPiServer(_fUserInfo.uid);
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
  }

  void setSelfIntroduce(FuserAccountUpdateReqdto reqDto) {
    reqDto.selfIntroduction = userIntroduceController.text;
  }

  Future setProfileImage(FuserAccountUpdateReqdto reqDto) async {
    if (_isChangeProfileImage && _currentPickProfileImage != null) {
      reqDto.userProfileImageUrl = await _userProfileImageUploadUseCaseInputPort
          .upload(_currentPickProfileImage);
    } else if (_isChangeProfileImage && _currentPickProfileImage == null) {
      reqDto.userProfileImageUrl = _preference.basicProfileImageUrl;
    } else {
      reqDto.userProfileImageUrl = _fUserInfo.profilePictureUrl;
    }
  }

  Future setNickName(FuserAccountUpdateReqdto reqDto) async {
    if (isChangeNickName()) {
      await _nickNameValid.valid(nickNameController.text);
      if (!_nickNameValid.hasError()) {
        reqDto.nickName = nickNameController.text;
      }
    } else {
      reqDto.nickName = _fUserInfo.nickName;
    }
  }

  bool isChangeNickName() => nickNameController.text != _fUserInfo.nickName;

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
                              currentProfileImage =
                                  NetworkImage(_preference.basicProfileImageUrl);
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

  __onUserIntroduceControllerListener() {
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
    if (_fUserInfo != null) {
      return _countryCode.findCountryName(_currentIsoCode);
    } else {
      return "";
    }
  }

  jumpCountrySelect() async {
    String isoCode = await Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => CountrySelectPage(
              countryCode: _fUserInfo.isoCode,
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
  void onSignInUserInfoFromMemory(FUserInfo fUserInfo) {
    _fUserInfo = fUserInfo;
    currentProfileImage = NetworkImage(_fUserInfo.profilePictureUrl);
    _currentIsoCode = _fUserInfo.isoCode;
    nickNameController.text = _fUserInfo.nickName;
    userIntroduceController.text = _fUserInfo.selfIntroduction;
  }
}
