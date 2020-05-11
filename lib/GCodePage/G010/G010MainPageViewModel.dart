import 'dart:io';

import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountrySelectPage.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FuserAccountUpdateReqdto.dart';
import 'package:forutonafront/ForutonaUser/Repository/FUserRepository.dart';
import 'package:forutonafront/GlobalModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Preference.dart';

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




  G010MainPageViewModel(this._context) {
    currentProfileImage = AssetImage("assets/basicprofileimage.png");
    _init();
    nickNameController.addListener(_onNickNameControllerListener);
    userIntroduceController.addListener(__onUserIntroduceControllerListener);
  }


  _init() async {
    _fUserInfoResDto = await _fUserRepository.getForutonaGetMe();
    currentProfileImage = NetworkImage(_fUserInfoResDto.profilePictureUrl);
    _currentIsoCode = _fUserInfoResDto.isoCode;
    nickNameController.text = _fUserInfoResDto.nickName;
    userIntroduceController.text = _fUserInfoResDto.selfIntroduction;
    notifyListeners();
  }

  onCompleteTap() async {
    //닉네임 중복 체크
    if(await onEditCompleteNickName()){
      return ;
    }

    FuserAccountUpdateReqdto reqDto = new FuserAccountUpdateReqdto(_currentIsoCode,nickNameController.text,userIntroduceController.text);

    //프로필 이미지 변경 체크 및 업데이트
    if(_isChangeProfileImage && _currentPickProfileImage != null){
      String imageUrl = await _fUserRepository.updateUserProfileImage(_currentPickProfileImage);
      reqDto.userProfileImageUrl = imageUrl;
    }else if(_isChangeProfileImage && _currentPickProfileImage == null){
      reqDto.userProfileImageUrl = Preference.basicProfileImageUrl;
    }else {
      reqDto.userProfileImageUrl = _fUserInfoResDto.profilePictureUrl;
    }

    var result = await _fUserRepository.updateAccountUserInfo(reqDto);
    if(result == 1){
      GlobalModel globalModel = Provider.of(_context, listen: false);
      globalModel.setFUserInfoDto();
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


  onEditCompleteNickName() async {
    RegExp regExp1 = new RegExp(r'^(?=.*?[!@#\$&*~\s])');
    if(regExp1.hasMatch(nickNameController.text)){
      isCanNotUseNickNameDisPlay = true;
      notifyListeners();
      return isCanNotUseNickNameDisPlay;
    }
    if((_fUserInfoResDto.nickName != nickNameController.text) && !isCanNotUseNickNameDisPlay ){
      var nickNameDuplicationCheckResDto = await _fUserRepository.checkNickNameDuplication(nickNameController.text);
      if(nickNameDuplicationCheckResDto.haveNickName){
        isCanNotUseNickNameDisPlay = true;
        notifyListeners();
        return isCanNotUseNickNameDisPlay;
      }else {
        isCanNotUseNickNameDisPlay = false;
      }
      notifyListeners();
    }
    notifyListeners();
    return isCanNotUseNickNameDisPlay;
  }

  __onUserIntroduceControllerListener() {
    userIntroduceInputTextLength = userIntroduceController.text.length;
    notifyListeners();
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
    _currentIsoCode = isoCode;
    notifyListeners();
  }
  Container didver(BuildContext context) {
    return Container(
      height: 1,
      width: MediaQuery.of(context).size.width,
      color: Color(0xffe4e7e8),
    );
  }
}
