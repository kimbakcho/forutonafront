import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/Common/SignValid/SingUp/SignUpValidService.dart';
import 'package:forutonafront/Common/SignValid/SingUpImpl/DefaultSignValidImpl.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';


class G010MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  FUserRepository _fUserRepository = new FUserRepository();
  FUserInfoResDto _fUserInfoResDto;
  CodeCountry _countryCode = new CodeCountry();
  File _currentPickProfileImage;
  String _currentIsoCode;

  bool _isChangeProfileImage = false;
  TextEditingController nickNameController = new TextEditingController();
  TextEditingController userIntroduceController = new TextEditingController();
  int nickNameInputTextLength = 0;
  int userIntroduceInputTextLength = 0;
  bool isCanNotUseNickNameDisPlay = false;
  ImageProvider currentProfileImage;
  SignUpValidService _signValidService = new DefaultSignValidImpl();
  bool _haveNickNameConfirm = false;

  FocusNode nickNameFocusNode = FocusNode();

  Preference _preference = sl();

  bool _isLoading = false;
  getIsLoading(){
    return _isLoading;
  }
  _setIsLoading(bool value){
    _isLoading = value;
    notifyListeners();
  }
  G010MainPageViewModel(this._context) {
    currentProfileImage = AssetImage("assets/basicprofileimage.png");
    _init();
    nickNameController.addListener(_onNickNameControllerListener);
    userIntroduceController.addListener(__onUserIntroduceControllerListener);
  }

  _init() async {
    _setIsLoading(true);
    _fUserInfoResDto = await _fUserRepository.getForutonaGetMe();
    currentProfileImage = NetworkImage(_fUserInfoResDto.profilePictureUrl);
    _currentIsoCode = _fUserInfoResDto.isoCode;
    nickNameController.text = _fUserInfoResDto.nickName;
    userIntroduceController.text = _fUserInfoResDto.selfIntroduction;
    _setIsLoading(false);
  }

  onCompleteTap() async {
    //닉네임 중복 체크
    _setIsLoading(true);
    GlobalModel globalModel = Provider.of(_context,listen: false);
    if(globalModel.fUserInfoDto.nickName != nickNameController.text){
      await _signValidService.nickNameValid(nickNameController.text);
      _haveNickNameConfirm = true;
      if(_signValidService.hasNickNameError()){
        _setIsLoading(false);
        return ;
      }
    }

    FuserAccountUpdateReqdto reqDto = new FuserAccountUpdateReqdto(_currentIsoCode,nickNameController.text,userIntroduceController.text);
    //프로필 이미지 변경 체크 및 업데이트
    if(_isChangeProfileImage && _currentPickProfileImage != null){
      String imageUrl = await _fUserRepository.updateUserProfileImage(_currentPickProfileImage);
      reqDto.userProfileImageUrl = imageUrl;
    }else if(_isChangeProfileImage && _currentPickProfileImage == null){
      reqDto.userProfileImageUrl = _preference.basicProfileImageUrl;
    }else {
      reqDto.userProfileImageUrl = _fUserInfoResDto.profilePictureUrl;
    }

    var result = await _fUserRepository.updateAccountUserInfo(reqDto);
    if(result == 1){
      GlobalModel globalModel = Provider.of(_context, listen: false);
      globalModel.setFUserInfoDto();
      Fluttertoast.showToast(
          msg: "수정 되었습니다.",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIos: 4,
          backgroundColor: Color(0xff454F63),
          textColor: Colors.white,
          fontSize: 12.0);
      Navigator.of(_context).pop();
    }
  }

  _onNickNameControllerListener() {
    nickNameInputTextLength = nickNameController.text.length;
    isCanNotUseNickNameDisPlay = false;
    notifyListeners();
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


  onEditCompleteNickName() async {
    GlobalModel globalModel = Provider.of(_context,listen: false);
    if(globalModel.fUserInfoDto.nickName == nickNameController.text){

      return ;
    }
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

  __onUserIntroduceControllerListener() {
    userIntroduceInputTextLength = userIntroduceController.text.length;
    notifyListeners();
  }

  textFieldUnFocus(){
    FocusScope.of(_context).requestFocus(new FocusNode());
  }

  bool isValidComplete() {
    if (nickNameController.text.length > 0 && !isCanNotUseNickNameDisPlay) {
      return true;
    } else {
      return false;
    }
  }

  void onBackBtnTap() {
    Navigator.of(_context).pop();
  }


  String getUserCountry() {
    if (_fUserInfoResDto != null) {
      return _countryCode.findCountryName(_currentIsoCode);
    } else {
      return "";
    }
  }

  jumpCountrySelect() async {
    String isoCode = await Navigator.of(_context).push(MaterialPageRoute(
        builder: (_) => CountrySelectPage(
              countryCode: _fUserInfoResDto.isoCode,
            )));
    if(isoCode != null){
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


}
