import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/Common/Country/CodeCountry.dart';
import 'package:forutonafront/Common/Country/CountryItem.dart';
import 'package:forutonafront/Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'package:forutonafront/Components/CountrySelect/CountrySelectButton.dart';
import 'package:forutonafront/Components/GenderSelectComponent/GenderSelectComponent.dart';
import 'package:forutonafront/Components/NickNameEditComponent/NickNameEditComponent.dart';
import 'package:forutonafront/Components/ProfileImageEditComponent/ProfileImageEditComponent.dart';
import 'package:forutonafront/Components/SelfIntroduceEditComponent/SelfIntroduceEditComponent.dart';
import 'package:forutonafront/Components/CodeAppBar/CodeAppBar.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class L008MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => L008MainPageViewModel(sl(), sl(), sl(),sl()),
      child: Consumer<L008MainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
              body: Container(
                  padding: MediaQuery.of(context).padding,
                  child: Column(children: [
                    CodeAppBar(
                      enableTailButton: model.isCanNext,
                      progressValue: 1,
                      onTailButtonClick: () {
                        if (model.isCanNext) {
                          model._validWithNextPage(context);
                        }
                      },
                      visibleTailButton: true,
                      title: "프로필 입력",
                      tailButtonLabel: "완료",
                    ),
                    Expanded(
                        child: SingleChildScrollView(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 16),
                                child: Text.rich(
                                  TextSpan(
                                    style: GoogleFonts.notoSans(
                                      fontSize: 14,
                                      color: const Color(0xff000000),
                                      letterSpacing: -0.28,
                                      height: 1.4285714285714286,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: '마지막으로 프로필을 작성해주세요.\n',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      TextSpan(
                                        text: '프로필 정보는 다시 변경할 수 있습니다.',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          ProfileImageEditComponent(
                            initProfileImageUrl: model.profileImageUrl,
                            profileImageEditComponentController:
                                model._profileImageEditComponentController,
                          ),
                          SizedBox(height: 33),
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16),
                            child: NickNameEditComponent(
                              initNickName: model.currentNickNameText,
                              nickNameEditComponentController:
                                  model._nickNameEditComponentController,
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
                              selfIntroduceEditController:
                                  model._selfIntroduceEditController,
                            ),
                          )
                        ])))
                  ])));
        },
      ),
    );
  }
}

class L008MainPageViewModel extends ChangeNotifier {
  ProfileImageEditComponentController _profileImageEditComponentController;

  NickNameEditComponentController _nickNameEditComponentController;

  CountrySelectButtonController _countrySelectButtonController;

  String currentNickNameText = "";

  String currentSelfIntroduce = "";

  CountryItem initCountryItem;

  GenderSelectComponentController _genderSelectComponentController;

  SelfIntroduceEditController _selfIntroduceEditController;

  final FUserInfoJoinReqDto _fUserInfoJoinReqDto;

  FlutterImageCompressAdapter _flutterImageCompressAdapter;

  SingUpUseCaseInputPort _singUpUseCaseInputPort;

  FireBaseAuthAdapterForUseCase fireBaseAuthAdapterForUseCase;

  L008MainPageViewModel(this._fUserInfoJoinReqDto,
      this._flutterImageCompressAdapter, this._singUpUseCaseInputPort,this.fireBaseAuthAdapterForUseCase) {
    if (_fUserInfoJoinReqDto.nickName != null) {
      currentNickNameText = _fUserInfoJoinReqDto.nickName;
    }

    _profileImageEditComponentController =
        ProfileImageEditComponentController();
    _nickNameEditComponentController =
        NickNameEditComponentController(onChangeNickNameText: (String value) {
      this.currentNickNameText = value;
      notifyListeners();
    });

    _countrySelectButtonController = CountrySelectButtonController();

    _genderSelectComponentController = GenderSelectComponentController();

    _selfIntroduceEditController =
        SelfIntroduceEditController(onChangesSelfIntroduceText: (value) {
      currentSelfIntroduce = value;
      notifyListeners();
    });

    CodeCountry codeCountry = CodeCountry();

    initCountryItem = codeCountry.countryList().firstWhere(
        (element) => element.code == _fUserInfoJoinReqDto.countryCode);
  }

  get profileImageUrl {
    return _fUserInfoJoinReqDto.profileImageUrl;
  }

  get isCanNext {
    return currentNickNameText.isNotEmpty && currentSelfIntroduce.isNotEmpty;
  }

  _validWithNextPage(BuildContext context) async {
    var nickNameResult = await _nickNameEditComponentController.valid();

    if (nickNameResult) {
      return;
    }

    _fUserInfoJoinReqDto.nickName =
        _nickNameEditComponentController.nickNameValue;

    var currentGenderType = _genderSelectComponentController.currentGenderType;

    _fUserInfoJoinReqDto.gender = currentGenderType;

    var currentCountryItem =
        _countrySelectButtonController.getCurrentCountryItem();

    _fUserInfoJoinReqDto.countryCode = currentCountryItem.code;

    var selfIntroduceText = _selfIntroduceEditController.selfIntroduceText;

    _fUserInfoJoinReqDto.userIntroduce = selfIntroduceText;

    var profileImageProvider =
        _profileImageEditComponentController.getProfileImageProvider();
    List<int> profileImage;
    if (profileImageProvider != null) {
      profileImage = await profileImageProvider.file.readAsBytes();

      profileImage =
          await _flutterImageCompressAdapter.compressImage(profileImage, 70);
    }

    if (_profileImageEditComponentController.getProfileImageProvider() ==
            null &&
        _profileImageEditComponentController.getProfileImageUrlProvider() ==
            null) {
      _fUserInfoJoinReqDto.profileImageUrl = null;
    }

    var backGroundImageProvider =
        _profileImageEditComponentController.getBackgroundImageProvider();
    List<int> backGroundImage;
    if (backGroundImageProvider != null) {
      backGroundImage = await backGroundImageProvider.file.readAsBytes();

      backGroundImage =
          await _flutterImageCompressAdapter.compressImage(backGroundImage, 70);
    }

    if(_fUserInfoJoinReqDto.snsSupportService == SnsSupportService.Forutona){
      var userUid = await fireBaseAuthAdapterForUseCase.createUserWithEmailAndPassword(_fUserInfoJoinReqDto.email,_fUserInfoJoinReqDto.password);
      _fUserInfoJoinReqDto.emailUserUid = userUid;
    }

    var fUserInfoJoinResDto = await _singUpUseCaseInputPort.joinUser(
        _fUserInfoJoinReqDto, profileImage, backGroundImage);

    if(_fUserInfoJoinReqDto.snsSupportService == SnsSupportService.Forutona){
      await fireBaseAuthAdapterForUseCase.logout();
      await fireBaseAuthAdapterForUseCase.signInWithEmailAndPassword(_fUserInfoJoinReqDto.email,_fUserInfoJoinReqDto.password);
    }

    Navigator.of(context).popUntil((route) => route.settings.name == "MAIN");
  }
}
