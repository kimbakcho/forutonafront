import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/Components/CountrySelect/CountrySelectButton.dart';
import 'package:forutonafront/Components/GenderSelectComponent/GenderSelectComponent.dart';
import 'package:forutonafront/Components/GenderSelectComponent/GenderType.dart';
import 'package:forutonafront/Components/NickNameEditComponent/NickNameEditComponent.dart';
import 'package:forutonafront/Components/ProfileImageEditComponent/ProfileImageEditComponent.dart';
import 'package:forutonafront/Components/SelfIntroduceEditComponent/SelfIntroduceEditComponent.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/MainPage/MainPageView.dart';
import 'package:forutonafront/Page/GCodePage/G001/G001MainPage.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class G010MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => G010MainPageViewModel(sl(), sl(),sl(),sl(),sl()),
      child: Consumer<G010MainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
            body: Container(
              padding: MediaQuery
                  .of(context)
                  .padding,
              child: Column(
                children: [
                  CodeAppBar(
                    title: "계정",
                    visibleTailButton: true,
                    tailButtonLabel: "완료",
                    progressValue: 0,
                    onTailButtonClick: () {
                      model.updateUserInfo(context);
                    },
                    enableTailButton: model.isCanComplete,
                  ),
                  Expanded(
                      child:
                      model._loaded ?
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileImageEditComponent(
                              initProfileImageUrl: model.profileImageUrl,
                              initBackGroundImageUrl: model.backGroundImageUrl,
                              profileImageEditComponentController:
                              model._profileImageEditComponentController,
                            ),
                            SizedBox(height: 33),
                            Container(
                              margin: EdgeInsets.only(left: 16, right: 16),
                              child: NickNameEditComponent(
                                initNickName: model.currentNickNameText,
                                userNickName: model.currentNickNameText,
                                nickNameEditComponentController: model
                                    ._nickNameEditComponentController,
                              ),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 16, right: 16),
                                child: Row(children: [
                                  Expanded(
                                      child: CountrySimpleSelectButton(
                                        initCountryItem: model.initCountryItem,
                                        countrySelectButtonController:
                                        model._countrySelectButtonController,
                                      )),
                                  SizedBox(
                                    width: 26,
                                  ),
                                  Expanded(
                                    child: GenderSelectComponent(
                                      initGender: model.initGender,
                                      genderSelectComponentController:
                                      model._genderSelectComponentController,
                                    ),
                                  )
                                ])),
                            SizedBox(
                              height: 30,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 16, right: 16),
                              child: SelfIntroduceEditComponent(
                                initSelfIntroduce: model.initSelfIntroduce,
                                selfIntroduceEditController:
                                model._selfIntroduceEditController,
                              ),
                            )
                          ],
                        ),
                      ) : CommonLoadingComponent()
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class G010MainPageViewModel extends ChangeNotifier {

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  ProfileImageEditComponentController _profileImageEditComponentController;

  NickNameEditComponentController _nickNameEditComponentController;

  CountrySelectButtonController _countrySelectButtonController;

  GenderSelectComponentController _genderSelectComponentController;

  SelfIntroduceEditController _selfIntroduceEditController;

  final FlutterImageCompressAdapter _flutterImageCompressAdapter;

  final UpdateAccountUserInfoUseCaseInputPort _updateAccountUserInfoUseCaseInputPort;

  final MainPageViewModelController _mainPageViewModelController;

  G001MainPageViewModelController _g001mainPageViewModelController;

  bool _loaded = false;

  String _currentNickName ="";

  G010MainPageViewModel(this._signInUserInfoUseCaseInputPort,
      this._flutterImageCompressAdapter,this._updateAccountUserInfoUseCaseInputPort,this._mainPageViewModelController,this._g001mainPageViewModelController) {
    _profileImageEditComponentController =
        ProfileImageEditComponentController();
    _nickNameEditComponentController = NickNameEditComponentController(
        onChangeNickNameText: (value) {
          _currentNickName = value;
        }
    );
    _countrySelectButtonController = CountrySelectButtonController(
        onCurrentCountryItem: (value) {
          notifyListeners();
        }
    );
    _selfIntroduceEditController = SelfIntroduceEditController(
        onChangesSelfIntroduceText: (value) {
          notifyListeners();
        }
    );
    _genderSelectComponentController = GenderSelectComponentController();
    _init();
  }

  FUserInfoResDto _fUserInfoResDto;

  _init() async {
    _fUserInfoResDto =
    await _signInUserInfoUseCaseInputPort.saveSignInInfoInMemoryFromAPiServer();
    _currentNickName = _fUserInfoResDto.nickName;
    _loaded = true;

    notifyListeners();
  }

  String get currentNickNameText {
    return _fUserInfoResDto.nickName;
  }

  CountryItem get initCountryItem {
    return CodeCountry().countryList().firstWhere((element) =>
    element.code == _fUserInfoResDto.isoCode);
  }

  GenderType get initGender {
    return _fUserInfoResDto.gender;
  }

  String get profileImageUrl {
    return _fUserInfoResDto.profilePictureUrl;
  }

  String get backGroundImageUrl {
    return _fUserInfoResDto.backGroundImageUrl;
  }

  String get initSelfIntroduce {
    return _fUserInfoResDto.selfIntroduction;
  }

   bool get isCanComplete {
    return _currentNickName.isNotEmpty;
  }

  updateUserInfo(BuildContext context) async {
    _loaded = false;
    notifyListeners();

    FUserAccountUpdateReqDto fUserAccountUpdateReqDto = FUserAccountUpdateReqDto();

    var isError = await _nickNameEditComponentController.valid();
    if (isError) {
      _loaded = false;
      notifyListeners();
      return ;
    } else {
      fUserAccountUpdateReqDto.nickName =
          _nickNameEditComponentController.nickNameValue;
    }


    List<int> profileImage;
    if (_profileImageEditComponentController.getProfileImageProvider() !=
        null) {
      profileImage = await _profileImageEditComponentController
          .getProfileImageProvider()
          .file
          .readAsBytes();
      profileImage =
      await _flutterImageCompressAdapter.compressImage(profileImage, 70);
    }

    if (_profileImageEditComponentController.getProfileImageProvider() ==
        null &&
        _profileImageEditComponentController.getProfileImageUrlProvider() ==
            null) {
      fUserAccountUpdateReqDto.profileImageIsEmpty = true;
    } else {
      fUserAccountUpdateReqDto.profileImageIsEmpty = false;
    }


    List<int> backGroundImage;
    if (_profileImageEditComponentController.getBackgroundImageProvider() !=
        null) {
      backGroundImage = await _profileImageEditComponentController
          .getBackgroundImageProvider()
          .file
          .readAsBytes();
      backGroundImage =
      await _flutterImageCompressAdapter.compressImage(backGroundImage, 70);
    }

    if (_profileImageEditComponentController.getBackgroundImageUrlProvider() ==
        null &&
        _profileImageEditComponentController.getBackgroundImageProvider() ==
            null) {
      fUserAccountUpdateReqDto.backGroundIsEmpty = true;
    } else {
      fUserAccountUpdateReqDto.backGroundIsEmpty = false;
    }

    fUserAccountUpdateReqDto.gender =
        _genderSelectComponentController.currentGenderType;

    fUserAccountUpdateReqDto.isoCode = _countrySelectButtonController.getCurrentCountryItem().code;

    fUserAccountUpdateReqDto.selfIntroduction = _selfIntroduceEditController.selfIntroduceText;

    await _updateAccountUserInfoUseCaseInputPort.updateAccountUserInfo(fUserAccountUpdateReqDto, profileImage, backGroundImage);

    _loaded = true;

    _g001mainPageViewModelController.reloadUserProfile();

    Navigator.of(context).pop();

  }


}
