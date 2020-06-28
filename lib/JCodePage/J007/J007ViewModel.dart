import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidService.dart';
import 'package:forutonafront/Common/SignValid/SingUpImpl/DefaultSignValidImpl.dart';

import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsSupportServiceFatory.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class J007ViewModel extends ChangeNotifier {
  final BuildContext _context;
  ImageProvider currentProfileImage;

  int nickNameInputTextLength = 0;
  TextEditingController nickNameController = new TextEditingController();
  TextEditingController userIntroduceController = new TextEditingController();
  int userIntroduceInputTextLength = 0;
  String currentCountryCode = "KR";
  SignUpValidService _signValidService = new DefaultSignValidImpl();

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

  J007ViewModel(this._context) {
    GlobalModel globalModel = Provider.of(_context, listen: false);
    if (globalModel.fUserInfoJoinReqDto.countryCode != null) {
      currentCountryCode = globalModel.fUserInfoJoinReqDto.countryCode;
    }
    if (globalModel.fUserInfoJoinReqDto.userProfileImageUrl == null) {
      globalModel.fUserInfoJoinReqDto.userProfileImageUrl = _preference.basicProfileImageUrl;
    }
    currentProfileImage =
        NetworkImage(globalModel.fUserInfoJoinReqDto.userProfileImageUrl);

    if (globalModel.fUserInfoJoinReqDto.nickName != null) {
      nickNameController.text = globalModel.fUserInfoJoinReqDto.nickName;
      nickNameInputTextLength = nickNameController.text.length;
    }

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
    await _signValidService.nickNameValid(nickNameController.text);
    _setIsLoading(false);
  }


  void onChangeNickName(String value) {
    _haveNickNameConfirm = false;
    nickNameInputTextLength = nickNameController.text.length;
    notifyListeners();
  }

  bool hasNickNameError() {
    if(_haveNickNameConfirm) {
      return _signValidService.hasNickNameError();
    }else {
      return false;
    }
  }
  String nickNameErrorText() {
    return _signValidService.nickNameErrorText();
  }
  void onBackTap() {
    Navigator.of(_context).pop();
  }


  void onCompeleteBtnClick() async {
    //닉네임 중복 체크
    _setIsLoading(true);
    await _signValidService.nickNameValid(nickNameController.text);
    _haveNickNameConfirm = true;
    if(_signValidService.hasNickNameError()){
      _setIsLoading(false);
      return ;
    }
    GlobalModel globalModel = Provider.of(_context, listen: false);
    globalModel.fUserInfoJoinReqDto.nickName = nickNameController.text;
    globalModel.fUserInfoJoinReqDto.userIntroduce =
        userIntroduceController.text;
    if (_isChangeProfileImage) {
      if (_currentPickProfileImage == null) {
        globalModel.fUserInfoJoinReqDto.userProfileImageUrl =
            _preference.basicProfileImageUrl;
      }
    }
    SnsLoginService snsLoginService =
        SnsSupportServiceFactory.createSnsSupportService(
            globalModel.fUserInfoJoinReqDto.snsSupportService);
    var fUserInfoJoinResDto =
        await snsLoginService.joinUser(globalModel.fUserInfoJoinReqDto);
    FUserRepository _fUserRepository = new FUserRepository();
    if (fUserInfoJoinResDto.joinComplete) {
      if (_currentPickProfileImage != null) {

        await _fUserRepository.updateUserProfileImage(_currentPickProfileImage);
      }
      await globalModel.setFUserInfoDto();
      Navigator.of(_context).popUntil(ModalRoute.withName('/'));
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
        await Navigator.of(_context).push(MaterialPageRoute(builder: (_) {
      return CountrySelectPage(countryCode: currentCountryCode);
    }));
    if (result != null) {
      currentCountryCode = result;
      notifyListeners();
    }
  }

  void onChangeProfileImageTab() async {
    var result = await showGeneralDialog(
        context: _context,
        barrierDismissible: true,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.3),
        barrierLabel:
            MaterialLocalizations.of(_context).modalBarrierDismissLabel,
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
                              if(file != null){
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
                              if(file != null){
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
  textFieldUnFocus(){
    FocusScope.of(_context).requestFocus(new FocusNode());
  }

  Container didver(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffe4e7e8),
    );
  }





}
