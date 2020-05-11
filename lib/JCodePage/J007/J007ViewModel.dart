import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/ForutonaUser/Service/FaceBookLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/ForutonaLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/KakaoLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/NaverLoginService.dart';
import 'package:forutonafront/ForutonaUser/Service/SnsLoginService.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/Preference.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class J007ViewModel extends ChangeNotifier {
  final BuildContext _context;
  CodeCountry _codeCountry = CodeCountry();
  String currentCountryCode = "KR";
  GlobalModel _globalModel;
  File _currentPickProfileImage;
  ImageProvider currentProfileImage;
  bool _isChangeProfileImage = false;

  FUserRepository _fUserRepository = new FUserRepository();

  bool isCanNotUseNickNameDisPlay = false;
  int nickNameInputTextLength = 0;
  TextEditingController nickNameController = new TextEditingController();

  TextEditingController userIntroduceController = new TextEditingController();
  int userIntroduceInputTextLength = 0;



  J007ViewModel(this._context) {
    GlobalModel globalModel = Provider.of(_context,listen: false);
    _globalModel = Provider.of(_context, listen: false);
    if (_globalModel.fUserInfoJoinReqDto.countryCode != null) {
      currentCountryCode = _globalModel.fUserInfoJoinReqDto.countryCode;
    }
    if(globalModel.fUserInfoJoinReqDto.userProfileImageUrl == null){
      globalModel.fUserInfoJoinReqDto.userProfileImageUrl = "https://storage.googleapis.com/publicforutona/profileimage/basicprofileimage.png";
    }
    currentProfileImage =
        NetworkImage(_globalModel.fUserInfoJoinReqDto.userProfileImageUrl);

    if (_globalModel.fUserInfoJoinReqDto.nickName != null) {
      nickNameController.text = _globalModel.fUserInfoJoinReqDto.nickName;
      nickNameInputTextLength = nickNameController.text.length;
    }
    nickNameController.addListener(_onNickNameControllerListener);
    userIntroduceController.addListener(__onUserIntroduceControllerListener);
  }

  bool isValidComplete() {
    if (nickNameController.text.length > 0 && !isCanNotUseNickNameDisPlay) {
      return true;
    } else {
      return false;
    }
  }

  __onUserIntroduceControllerListener() {
    userIntroduceInputTextLength = userIntroduceController.text.length;
    notifyListeners();
  }

  _onNickNameControllerListener() {
    nickNameInputTextLength = nickNameController.text.length;
    isCanNotUseNickNameDisPlay = false;
    notifyListeners();
  }

  onEditCompleteNickName() async {
    RegExp regExp1 = new RegExp(r'^(?=.*?[!@#\$&*~\s])');
    if (regExp1.hasMatch(nickNameController.text)) {
      isCanNotUseNickNameDisPlay = true;
      notifyListeners();
      return isCanNotUseNickNameDisPlay;
    }
    var nickNameDuplicationCheckResDto = await _fUserRepository
        .checkNickNameDuplication(nickNameController.text);
    if (nickNameDuplicationCheckResDto.haveNickName) {
      isCanNotUseNickNameDisPlay = true;
      notifyListeners();
      return isCanNotUseNickNameDisPlay;
    } else {
      isCanNotUseNickNameDisPlay = false;
    }
    notifyListeners();
    return isCanNotUseNickNameDisPlay;
  }

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  void onCompeleteBtnClick() async {
    //닉네임 중복 체크
    if(await onEditCompleteNickName()){
      return ;
    }
    GlobalModel globalModel = Provider.of(_context,listen: false);
    globalModel.fUserInfoJoinReqDto.nickName = nickNameController.text;
    globalModel.fUserInfoJoinReqDto.userIntroduce = userIntroduceController.text;
    if(_isChangeProfileImage){
      if(_currentPickProfileImage == null){
        globalModel.fUserInfoJoinReqDto.userProfileImageUrl = Preference.basicProfileImageUrl;
      }
    }
    SnsLoginService snsLoginService;
    if(globalModel.fUserInfoJoinReqDto.snsSupportService == SnsSupportService.FaceBook){
      snsLoginService = FaceBookLoginService();
    }else if(globalModel.fUserInfoJoinReqDto.snsSupportService == SnsSupportService.Naver){
      snsLoginService = NaverLoginService();
    }else if(globalModel.fUserInfoJoinReqDto.snsSupportService == SnsSupportService.Kakao){
      snsLoginService = KakaoLoginService();
    }else if(globalModel.fUserInfoJoinReqDto.snsSupportService == SnsSupportService.Forutona){
      snsLoginService = ForutonaLoginService();
    }else {
      snsLoginService = ForutonaLoginService();
    }
    var fUserInfoJoinResDto = await snsLoginService.joinUser(globalModel.fUserInfoJoinReqDto);
    if(fUserInfoJoinResDto.joinComplete){
      if(_currentPickProfileImage!=null){
        await _fUserRepository.updateUserProfileImage(_currentPickProfileImage);
      }
      Navigator.of(_context).popUntil(ModalRoute.withName('/'));
    }else {
      Fluttertoast.showToast(
          msg: "가입 실패",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 1,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
    }
  }

  String getCountryName(String isoCode) {
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
                              _currentPickProfileImage = file;
                              currentProfileImage = FileImage(file);
                              _isChangeProfileImage = true;
                              notifyListeners();
                              Navigator.of(_context).pop();
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
                              _currentPickProfileImage = file;
                              currentProfileImage = FileImage(file);
                              _isChangeProfileImage = true;
                              notifyListeners();
                              Navigator.of(_context).pop();
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
  }

  Container didver(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffe4e7e8),
    );
  }
}
