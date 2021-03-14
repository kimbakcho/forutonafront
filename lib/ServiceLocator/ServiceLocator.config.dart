// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../AppBis/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart'
    as _i4;
import '../AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart' as _i20;
import '../AppBis/FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart'
    as _i82;
import '../AppBis/FBall/Data/Repository/FBallRepositoryImpl.dart' as _i130;
import '../AppBis/FBall/Data/Repository/NoInterestBallRepositoryImpl.dart'
    as _i97;
import '../AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart'
    as _i81;
import '../AppBis/FBall/Domain/Repository/FBallRepository.dart' as _i129;
import '../AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart'
    as _i96;
import '../AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart'
    as _i142;
import '../AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart'
    as _i144;
import '../AppBis/FBall/Domain/UseCase/FBallSearchBarHistory/FBallSearchBarHistoryUseCaseInputPort.dart'
    as _i88;
import '../AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart'
    as _i134;
import '../AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart'
    as _i135;
import '../AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart'
    as _i98;
import '../AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart'
    as _i138;
import '../AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart'
    as _i141;
import '../AppBis/FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart'
    as _i17;
import '../AppBis/FBallPlayer/Data/Repository/FBallPlayerRepositoryImpl.dart'
    as _i19;
import '../AppBis/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart'
    as _i18;
import '../AppBis/FBallPlayer/Domain/UseCase/FBallPlayerListUp/FBallPlayerListUpUseCaeInputPort.dart'
    as _i83;
import '../AppBis/FBallReply/Data/DataSource/FBallReplyDataSource.dart' as _i21;
import '../AppBis/FBallReply/Data/Repository/FBallReplyRepositoryImpl.dart'
    as _i85;
import '../AppBis/FBallReply/Domain/Repositroy/FBallReplyRepository.dart'
    as _i84;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCase.dart'
    as _i87;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart'
    as _i86;
import '../AppBis/FBallValuation/Data/Repository/FBallValuationRepositoryImpl.dart'
    as _i132;
import '../AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart'
    as _i131;
import '../AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart'
    as _i143;
import '../AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart'
    as _i133;
import '../AppBis/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart'
    as _i24;
import '../AppBis/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart'
    as _i51;
import '../AppBis/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart'
    as _i56;
import '../AppBis/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart'
    as _i75;
import '../AppBis/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart'
    as _i90;
import '../AppBis/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart'
    as _i53;
import '../AppBis/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart'
    as _i58;
import '../AppBis/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart'
    as _i77;
import '../AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart' as _i89;
import '../AppBis/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart'
    as _i52;
import '../AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart'
    as _i57;
import '../AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart'
    as _i76;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart'
    as _i114;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserUseCaseInputPort/FUserUseCaseInputPort.dart'
    as _i91;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart'
    as _i103;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart'
    as _i102;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart'
    as _i106;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart'
    as _i107;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart'
    as _i108;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserInfoUseCaseInputPort.dart'
    as _i109;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart'
    as _i128;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart'
    as _i127;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart'
    as _i111;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart'
    as _i110;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart'
    as _i137;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart'
    as _i136;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart'
    as _i55;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart'
    as _i54;
import '../AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart'
    as _i59;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart'
    as _i125;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart'
    as _i124;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart'
    as _i63;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart'
    as _i140;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart'
    as _i139;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart'
    as _i79;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart'
    as _i78;
import '../AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart' as _i23;
import '../AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart' as _i62;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart'
    as _i118;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart'
    as _i26;
import '../AppBis/MaliciousBall/Data/Repositroy/MaliciousBallRepositoryImpl.dart'
    as _i121;
import '../AppBis/MaliciousBall/Domain/Repository/MaliciousBallRepository.dart'
    as _i120;
import '../AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart'
    as _i122;
import '../AppBis/MaliciousReply/Data/Repository/MaliciousReplyRepositoryImpl.dart'
    as _i38;
import '../AppBis/MaliciousReply/Domain/Repository/MaliciousReplyRepository.dart'
    as _i37;
import '../AppBis/MaliciousReply/Domain/UseCase/MaliciousReplyUseCaseInputPort.dart'
    as _i39;
import '../AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart' as _i22;
import '../AppBis/Tag/Data/Repository/TagRepositoryImpl.dart' as _i70;
import '../AppBis/Tag/Domain/Repository/TagRepository.dart' as _i69;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart'
    as _i101;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart'
    as _i100;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart'
    as _i105;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart'
    as _i104;
import '../Common/AndroidIntentAdapter/AndroidIntentAdapter.dart' as _i3;
import '../Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart' as _i80;
import '../Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart' as _i25;
import '../Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart' as _i115;
import '../Common/FireBaseMessage/Presentation/FireBaseMessageController.dart'
    as _i116;
import '../Common/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart'
    as _i11;
import '../Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart'
    as _i12;
import '../Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart'
    as _i9;
import '../Common/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart'
    as _i13;
import '../Common/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart'
    as _i10;
import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart'
    as _i27;
import '../Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart'
    as _i28;
import '../Common/FluttertoastAdapter/FluttertoastAdapter.dart' as _i29;
import '../Common/Geolocation/Adapter/GeolocatorAdapter.dart' as _i32;
import '../Common/Geolocation/Adapter/LocationAdapter.dart' as _i35;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart'
    as _i93;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart'
    as _i92;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart'
    as _i95;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart'
    as _i94;
import '../Common/GeoPlaceAdapter/GeoPlaceAdapter.dart' as _i31;
import '../Common/GlobalInitMutex/GlobalInitMutex.dart' as _i33;
import '../Common/GoogleMapSupport/MapBallMarkerFactory.dart' as _i123;
import '../Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart'
    as _i40;
import '../Common/GoogleMapSupport/MapMakerDescriptorContainer.dart' as _i117;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart'
    as _i5;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart'
    as _i8;
import '../Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart'
    as _i7;
import '../Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart'
    as _i6;
import '../Common/ImageCropUtil/ImageUtilInputPort.dart' as _i34;
import '../Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart'
    as _i14;
import '../Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart'
    as _i15;
import '../Common/MapScreenPosition/MapScreenPositionUseCase.dart' as _i42;
import '../Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart'
    as _i41;
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart'
    as _i112;
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart'
    as _i49;
import '../Common/Notification/NotiChannel/Domain/CommentChannel/Service/FBallReplyFCMServiceUseCase.dart'
    as _i113;
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCae.dart'
    as _i50;
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCaeInputPort.dart'
    as _i64;
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/Service/IssueFBalIInsertFCMServiceUseCase.dart'
    as _i65;
import '../Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart'
    as _i48;
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/ID001/ID001PageMoveAction.dart'
    as _i146;
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCase.dart'
    as _i44;
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart'
    as _i145;
import '../Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart'
    as _i43;
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart'
    as _i67;
import '../Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart'
    as _i119;
import '../Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart'
    as _i60;
import '../Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart' as _i126;
import '../Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart' as _i68;
import '../Components/DetailPageViewer/DetailPageItemFactory.dart' as _i16;
import '../Components/PhoneAuthComponent/PhoneAuthMode/PhoneAuthModeFactory.dart'
    as _i99;
import '../Components/TagList/RankingTagListMediator.dart' as _i66;
import '../Components/UserInfoCollectionWidget/UserInfoCollectMediator.dart'
    as _i74;
import '../MainPage/MainPageView.dart' as _i36;
import '../ManagerBis/Notice/Data/NoticeRepositoryImpl.dart' as _i46;
import '../ManagerBis/Notice/Domain/NoticeRepository.dart' as _i45;
import '../ManagerBis/Notice/Domain/NoticeUseCaseInputPort.dart' as _i47;
import '../ManagerBis/TermsConditions/Data/Repository/TermsConditionsRepositoryImpl.dart'
    as _i72;
import '../ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart'
    as _i71;
import '../ManagerBis/TermsConditions/Domain/UseCase/TermsConditionsUseCaseInputPort.dart'
    as _i73;
import '../Page/GCodePage/Component/UserProfile/ProfileModeUseCase/ProfileModeUseCaseInputPort.dart'
    as _i61;
import '../Page/GCodePage/G001/G001MainPage.dart'
    as _i30; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AndroidIntentAdapter>(
      () => _i3.AndroidIntentAdapterImpl());
  gh.lazySingleton<_i4.BallSearchHistoryLocalDataSource>(
      () => _i4.BallSearchHistoryLocalDataSourceImpl());
  gh.lazySingleton<_i5.BaseGoogleSurveyInputPort>(
      () => _i6.GoogleSurveyErrorReportUseCase(),
      instanceName: 'GoogleSurveyErrorReportUseCase');
  gh.lazySingleton<_i5.BaseGoogleSurveyInputPort>(
      () => _i7.GoogleProposalOnServiceSurveyUseCase(),
      instanceName: 'GoogleProposalOnServiceSurveyUseCase');
  gh.lazySingleton<_i5.BaseGoogleSurveyInputPort>(
      () => _i8.BaseGoogleSurveyUseCase(),
      instanceName: 'BaseGoogleSurveyUseCase');
  gh.lazySingleton<_i9.BaseMessageUseCaseInputPort>(
      () => _i10.ResumeMessageUseCase(),
      instanceName: 'ResumeMessageUseCase');
  gh.lazySingleton<_i9.BaseMessageUseCaseInputPort>(
      () => _i11.BackGroundMessageUseCase(
          baseMessageUseCaseInputPort: get<_i9.BaseMessageUseCaseInputPort>(
              instanceName: 'BaseMessageUseCase')),
      instanceName: 'BackGroundMessageUseCase');
  gh.lazySingleton<_i9.BaseMessageUseCaseInputPort>(
      () => _i12.BaseMessageUseCase(),
      instanceName: 'BaseMessageUseCase');
  gh.lazySingleton<_i9.BaseMessageUseCaseInputPort>(
      () => _i13.LaunchMessageUseCase(),
      instanceName: 'LaunchMessageUseCase');
  gh.lazySingleton<_i14.BaseOpenTalkInputPort>(
      () => _i15.InquireAboutAnythingUseCase());
  gh.lazySingleton<_i16.DetailPageItemFactory>(
      () => _i16.DetailPageItemFactory());
  gh.lazySingleton<_i17.FBallPlayerRemoteDataSource>(
      () => _i17.FBallPlayerRemoteDataSourceImpl());
  gh.lazySingleton<_i18.FBallPlayerRepository>(() =>
      _i19.FBallPlayerRepositoryImpl(
          fBallPlayerRemoteDataSource:
              get<_i17.FBallPlayerRemoteDataSource>()));
  gh.lazySingleton<_i20.FBallRemoteDataSource>(
      () => _i20.FBallRemoteSourceImpl());
  gh.lazySingleton<_i21.FBallReplyDataSource>(
      () => _i21.FBallReplyDataSourceImpl());
  gh.lazySingleton<_i22.FBallTagRemoteDataSource>(
      () => _i22.FBallTagRemoteDataSourceImpl());
  gh.lazySingleton<_i23.FUserInfoJoinReqDto>(() => _i23.FUserInfoJoinReqDto());
  gh.lazySingleton<_i24.FUserRemoteDataSource>(
      () => _i24.FUserRemoteDataSourceImpl());
  gh.lazySingleton<_i25.FileDownLoaderUseCaseInputPort>(
      () => _i25.FileDownLoaderUseCase());
  gh.lazySingleton<_i26.FireBaseAuthBaseAdapter>(
      () => _i26.FireBaseAuthBaseAdapterImpl());
  gh.lazySingleton<_i27.FlutterImageCompressAdapter>(
      () => _i27.FlutterImageCompressAdapterImpl());
  gh.lazySingleton<_i28.FlutterLocalNotificationsPluginAdapter>(
      () => _i28.FlutterLocalNotificationsPluginAdapterImpl());
  gh.lazySingleton<_i29.FluttertoastAdapter>(() => _i29.FluttertoastAdapter());
  gh.lazySingleton<_i30.G001MainPageViewModelController>(
      () => _i30.G001MainPageViewModelController());
  gh.factory<_i31.GeoPlaceAdapter>(() => _i31.GooglePlaceAdapter());
  gh.lazySingleton<_i32.GeolocatorAdapter>(() => _i32.GeolocatorAdapterImpl());
  gh.lazySingleton<_i33.GlobalInitMutex>(() => _i33.GlobalInitMutex());
  gh.lazySingleton<_i34.ImageUtilInputPort>(() => _i34.ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
  gh.lazySingleton<_i34.ImageUtilInputPort>(() => _i34.ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.lazySingleton<_i34.ImageUtilInputPort>(() => _i34.ImagePngResizeUtil(),
      instanceName: 'ImagePngResizeUtil');
  gh.lazySingleton<_i35.LocationAdapter>(() => _i35.LocationAdapterImpl());
  gh.lazySingleton<_i36.MainPageViewModelController>(
      () => _i36.MainPageViewModelController());
  gh.lazySingleton<_i37.MaliciousReplyRepository>(() =>
      _i38.MaliciousReplyRepositoryImpl(get<_i26.FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<_i39.MaliciousReplyUseCaseInputPort>(
      () => _i39.MaliciousReplyUseCase(get<_i37.MaliciousReplyRepository>()));
  gh.lazySingleton<_i40.MapBitmapDescriptorUseCaseInputPort>(() =>
      _i40.MapBitmapDescriptorUseCase(
          imagePngResizeUtil:
              get<_i34.ImageUtilInputPort>(instanceName: 'ImagePngResizeUtil'),
          imageBorderAvatarUtil: get<_i34.ImageUtilInputPort>(
              instanceName: 'ImageBorderAvatarUtil'),
          fileDownLoaderUseCaseInputPort:
              get<_i25.FileDownLoaderUseCaseInputPort>()));
  gh.lazySingleton<_i41.MapScreenPositionUseCaseInputPort>(
      () => _i42.MapScreenPositionUseCase());
  gh.lazySingleton<_i43.NotiSelectActionBaseInputPort>(
      () => _i44.PageMoveActionUseCase());
  gh.factory<_i45.NoticeRepository>(() => _i46.NoticeRepositoryImpl());
  gh.factory<_i47.NoticeUseCaseInputPort>(
      () => _i47.NoticeUseCase(get<_i45.NoticeRepository>()));
  gh.lazySingleton<_i48.NotificationChannelBaseInputPort>(
      () => _i49.CommentChannelUseCase(),
      instanceName: 'CommentChannelUseCase');
  gh.lazySingleton<_i48.NotificationChannelBaseInputPort>(
      () => _i50.RadarBasicChannelUseCae(),
      instanceName: 'RadarBasicChannelUseCae');
  gh.factoryParam<_i48.NotificationChannelBaseInputPort, String, dynamic>((name,
          _) =>
      _i48.NotificationChannelBaseInputPort.serviceChannelUseCaseName(name));
  gh.lazySingleton<_i51.PersonaSettingNoticeRemoteDataSource>(
      () => _i51.PersonaSettingNoticeRemoteDataSourceImpl());
  gh.lazySingleton<_i52.PersonaSettingNoticeRepository>(() =>
      _i53.PersonaSettingNoticeRepositoryImpl(
          personaSettingNoticeRemoteDataSource:
              get<_i51.PersonaSettingNoticeRemoteDataSource>()));
  gh.lazySingleton<_i54.PersonaSettingNoticeUseCaseInputPort>(() =>
      _i55.PersonaSettingNoticeUseCase(
          personaSettingNoticeRepository:
              get<_i52.PersonaSettingNoticeRepository>()));
  gh.lazySingleton<_i56.PhoneAuthRemoteSource>(
      () => _i56.PhoneAuthRemoteSourceImpl());
  gh.lazySingleton<_i57.PhoneAuthRepository>(() => _i58.PhoneAuthRepositoryImpl(
      phoneAuthRemoteSource: get<_i56.PhoneAuthRemoteSource>()));
  gh.lazySingleton<_i59.PhoneAuthUseCaseInputPort>(() => _i59.PhoneAuthUseCase(
      phoneAuthRepository: get<_i57.PhoneAuthRepository>()));
  gh.factory<_i60.PhoneFindValidUseCase>(() => _i60.PhoneFindValidUseCaseImpl(
      phoneAuthRepository: get<_i57.PhoneAuthRepository>()));
  gh.lazySingleton<_i61.ProfileModeUseCaseFactory>(
      () => _i61.ProfileModeUseCaseFactory());
  gh.lazySingleton<_i62.PwChangeFromPhoneAuthReqDto>(
      () => _i62.PwChangeFromPhoneAuthReqDto());
  gh.lazySingleton<_i63.PwFindPhoneUseCaseInputPort>(() =>
      _i63.PwFindPhoneUseCase(
          phoneAuthRepository: get<_i57.PhoneAuthRepository>()));
  gh.lazySingleton<_i64.RadarBasicChannelUseCaeInputPort>(() =>
      _i65.IssueFBalIInsertFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter:
              get<_i28.FlutterLocalNotificationsPluginAdapter>()));
  gh.factory<_i66.RankingTagListMediator>(
      () => _i66.RankingTagListMediatorImpl());
  gh.lazySingleton<_i67.SharedPreferencesAdapter>(
      () => _i67.SharedPreferencesAdapterImpl());
  gh.factory<_i68.SwipeGestureRecognizerController>(
      () => _i68.SwipeGestureRecognizerController());
  gh.lazySingleton<_i69.TagRepository>(() => _i70.TagRepositoryImpl(
      fBallTagRemoteDataSource: get<_i22.FBallTagRemoteDataSource>()));
  gh.factory<_i71.TermsConditionsRepository>(
      () => _i72.TermsConditionsRepositoryImpl());
  gh.factory<_i73.TermsConditionsUseCaseInputPort>(() =>
      _i73.TermsConditionsUseCase(
          termsConditionsRepository: get<_i71.TermsConditionsRepository>()));
  gh.factory<_i74.UserInfoCollectMediator>(
      () => _i74.UserInfoCollectMediatorImpl());
  gh.lazySingleton<_i75.UserPolicyRemoteDataSource>(
      () => _i75.UserPolicyRemoteDataSourceImpl());
  gh.lazySingleton<_i76.UserPolicyRepository>(() =>
      _i77.UserPolicyRepositoryImpl(
          userPolicyRemoteDataSource: get<_i75.UserPolicyRemoteDataSource>()));
  gh.lazySingleton<_i78.UserPolicyUseCaseInputPort>(() =>
      _i79.UserPolicyUseCase(
          userPolicyRepository: get<_i76.UserPolicyRepository>()));
  gh.lazySingleton<_i80.AvatarImageMakerUseCaseInputPort>(() =>
      _i80.AvatarImageMakerUseCase(
          fileDownLoaderUseCaseInputPort:
              get<_i25.FileDownLoaderUseCaseInputPort>(),
          imageUtilInputPort: get<_i34.ImageUtilInputPort>()));
  gh.lazySingleton<_i81.BallSearchBarHistoryRepository>(() =>
      _i82.BallSearchBarHistoryRepositoryImpl(
          localDataSource: get<_i4.BallSearchHistoryLocalDataSource>()));
  gh.lazySingleton<_i83.FBallPlayerListUpInputPort>(() =>
      _i83.FBallPlayerListUpUseCae(
          fBallPlayerRepository: get<_i18.FBallPlayerRepository>()));
  gh.lazySingleton<_i84.FBallReplyRepository>(() =>
      _i85.FBallReplyRepositoryImpl(
          fBallReplyDataSource: get<_i21.FBallReplyDataSource>(),
          fireBaseAuthBaseAdapter: get<_i26.FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<_i86.FBallReplyUseCaseInputPort>(() =>
      _i87.FBallReplyUseCase(
          fBallReplyRepository: get<_i84.FBallReplyRepository>()));
  gh.lazySingleton<_i88.FBallSearchBarHistoryUseCaseInputPort>(() =>
      _i88.FBallSearchBarHistoryUseCase(
          ballSearchBarHistoryRepository:
              get<_i81.BallSearchBarHistoryRepository>()));
  gh.lazySingleton<_i89.FUserRepository>(() => _i90.FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: get<_i26.FireBaseAuthBaseAdapter>(),
      fUserRemoteDataSource: get<_i24.FUserRemoteDataSource>()));
  gh.lazySingleton<_i91.FUserUseCaseInputPort>(
      () => _i91.FUserUseCase(get<_i89.FUserRepository>()));
  gh.lazySingleton<_i92.GeoLocationUtilBasicUseCaseInputPort>(() =>
      _i93.GeoLocationUtilBasicUseCase(
          geolocatorAdapter: get<_i32.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i67.SharedPreferencesAdapter>()));
  gh.lazySingleton<_i94.GeoLocationUtilForeGroundUseCaseInputPort>(() =>
      _i95.GeoLocationUtilForeGroundUseCase(
          basicUseCaseInputPort:
              get<_i92.GeoLocationUtilBasicUseCaseInputPort>(),
          geolocatorAdapter: get<_i32.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i67.SharedPreferencesAdapter>(),
          locationAdapter: get<_i35.LocationAdapter>()));
  gh.lazySingleton<_i96.NoInterestBallRepository>(() =>
      _i97.NoInterestBallRepositoryImpl(
          sharedPreferencesAdapter: get<_i67.SharedPreferencesAdapter>()));
  gh.lazySingleton<_i98.NoInterestBallUseCaseInputPort>(() =>
      _i98.NoInterestBallUseCase(
          noInterestBallRepository: get<_i96.NoInterestBallRepository>()));
  gh.factory<_i99.PhoneAuthModeFactory>(() => _i99.PhoneAuthModeFactory(
      get<_i59.PhoneAuthUseCaseInputPort>(),
      get<_i60.PhoneFindValidUseCase>()));
  gh.lazySingleton<
          _i100.RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      () => _i101.RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: get<_i69.TagRepository>()));
  gh.lazySingleton<_i102.SignInUserInfoUseCaseInputPort>(() =>
      _i103.SignInUserInfoUseCase(
          fUserRepository: get<_i89.FUserRepository>()));
  gh.lazySingleton<_i104.TagFromBallUuidUseCaseInputPort>(() =>
      _i105.TagFromBallUuidUseCase(tagRepository: get<_i69.TagRepository>()));
  gh.lazySingleton<_i106.UpdateAccountUserInfoUseCaseInputPort>(() =>
      _i106.UpdateAccountUserInfoUseCase(
          fUserRepository: get<_i89.FUserRepository>()));
  gh.lazySingleton<_i107.UpdateFCMTokenUseCaseInputPort>(() =>
      _i107.UpdateFCMTokenUseCase(
          fUserRepository: get<_i89.FUserRepository>()));
  gh.lazySingleton<_i108.UpdateUserPositionUseCaseInputPort>(() =>
      _i108.UpdateUserPositionUseCase(
          fUserRepository: get<_i89.FUserRepository>()));
  gh.lazySingleton<_i109.UserInfoUseCaseInputPort>(
      () => _i109.UserInfoUseCase(get<_i89.FUserRepository>()));
  gh.lazySingleton<_i110.UserProfileImageUploadUseCaseInputPort>(() =>
      _i111.UserProfileImageUploadUseCase(
          flutterImageCompressAdapter: get<_i27.FlutterImageCompressAdapter>(),
          fUserRepository: get<_i89.FUserRepository>()));
  gh.lazySingleton<_i112.CommentChannelBaseServiceUseCaseInputPort>(
      () => _i113.FBallReplyFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter:
              get<_i28.FlutterLocalNotificationsPluginAdapter>(),
          avatarImageMakerUseCaseInputPort:
              get<_i80.AvatarImageMakerUseCaseInputPort>(),
          signInUserInfoUseCaseInputPort:
              get<_i102.SignInUserInfoUseCaseInputPort>()),
      instanceName: 'FBallReplyFCMServiceUseCase');
  gh.lazySingleton<_i114.FUserPwChangeUseCaseInputPort>(() =>
      _i114.FUserPwChangeUseCase(fUserRepository: get<_i89.FUserRepository>()));
  gh.lazySingleton<_i115.FireBaseMessageAdapter>(() =>
      _i115.FireBaseMessageAdapterImpl(
          signInUserInfoUseCaseInputPort:
              get<_i102.SignInUserInfoUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i26.FireBaseAuthBaseAdapter>(),
          updateFCMTokenUseCaseInputPort:
              get<_i107.UpdateFCMTokenUseCaseInputPort>()));
  gh.lazySingleton<_i116.FireBaseMessageController>(() =>
      _i116.FireBaseMessageController(
          fireBaseMessageAdapter: get<_i115.FireBaseMessageAdapter>(),
          launchMessageUseCase: get<_i9.BaseMessageUseCaseInputPort>(
              instanceName: 'LaunchMessageUseCase'),
          baseMessageUseCase: get<_i9.BaseMessageUseCaseInputPort>(
              instanceName: 'BaseMessageUseCase'),
          resumeMessageUseCase: get<_i9.BaseMessageUseCaseInputPort>(
              instanceName: 'ResumeMessageUseCase')));
  gh.lazySingleton<_i117.MapMakerDescriptorContainer>(() =>
      _i117.MapMakerDescriptorContainerImpl(
          mapBitmapDescriptorUseCaseInputPort:
              get<_i40.MapBitmapDescriptorUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i26.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i102.SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<_i118.FireBaseAuthAdapterForUseCase>(() =>
      _i118.FireBaseAuthAdapterForUseCaseImpl(
          fireBaseMessageAdapter: get<_i115.FireBaseMessageAdapter>(),
          fireBaseAuthBaseAdapter: get<_i26.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i102.SignInUserInfoUseCaseInputPort>(),
          updateFCMTokenUseCaseInputPort:
              get<_i107.UpdateFCMTokenUseCaseInputPort>()));
  gh.factory<_i119.FireBaseSignInValidUseCase>(() =>
      _i119.FireBaseSignInValidUseCaseImpl(
          fireBaseAuthAdapterForUseCase:
              get<_i118.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i120.MaliciousBallRepository>(() =>
      _i121.MaliciousBallRepositoryImpl(
          get<_i118.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i122.MaliciousBallUseCaseInputPort>(
      () => _i122.MaliciousBallUseCase(get<_i120.MaliciousBallRepository>()));
  gh.lazySingleton<_i123.MapBallMarkerFactory>(() => _i123.MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<_i117.MapMakerDescriptorContainer>()));
  gh.lazySingleton<_i124.PwFindEmailUseCaseInputPort>(() =>
      _i125.PwFindEmailUseCase(
          fireBaseAuthAdapterForUseCase:
              get<_i118.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i126.SnsLoginModuleAdapterFactory>(() =>
      _i126.SnsLoginModuleAdapterFactory(
          get<_i118.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i127.UserPositionForegroundMonitoringUseCaseInputPort>(() =>
      _i128.UserPositionForegroundMonitoringUseCase(
          geoLocationUtilBasicUseCaseInputPort:
              get<_i92.GeoLocationUtilBasicUseCaseInputPort>(),
          fUserRepository: get<_i89.FUserRepository>(),
          fireBaseAuthAdapterForUseCase:
              get<_i118.FireBaseAuthAdapterForUseCase>(),
          updateUserPositionUseCaseInputPort:
              get<_i108.UpdateUserPositionUseCaseInputPort>()));
  gh.lazySingleton<_i129.FBallRepository>(() => _i130.FBallRepositoryImpl(
      fBallRemoteDataSource: get<_i20.FBallRemoteDataSource>(),
      fireBaseAuthBaseAdapter: get<_i118.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i131.FBallValuationRepository>(() =>
      _i132.FBallValuationRepositoryImpl(
          fireBaseAuthBaseAdapter: get<_i118.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i133.FBallValuationUseCaseInputPort>(() =>
      _i133.FBallValuationUseCase(
          fBallValuationRepository: get<_i131.FBallValuationRepository>()));
  gh.lazySingleton<_i134.HitBallUseCaseInputPort>(() =>
      _i134.HitBallUseCase(fBallRepository: get<_i129.FBallRepository>()));
  gh.lazySingleton<_i135.InsertBallUseCaseInputPort>(() =>
      _i135.InsertBallUseCase(fBallRepository: get<_i129.FBallRepository>()));
  gh.lazySingleton<_i136.LogoutUseCaseInputPort>(() => _i137.LogoutUseCase(
      fireBaseAuthAdapterForUseCase: get<_i118.FireBaseAuthAdapterForUseCase>(),
      signInUserInfoUseCaseInputPort:
          get<_i102.SignInUserInfoUseCaseInputPort>(),
      snsLoginModuleAdapterFactory: get<_i126.SnsLoginModuleAdapterFactory>()));
  gh.lazySingleton<_i138.SelectBallUseCaseInputPort>(() =>
      _i138.SelectBallUseCase(fBallRepository: get<_i129.FBallRepository>()));
  gh.lazySingleton<_i139.SingUpUseCaseInputPort>(() => _i140.SingUpUseCase(
      fUserRepository: get<_i89.FUserRepository>(),
      fireBaseAuthAdapterForUseCase: get<_i118.FireBaseAuthAdapterForUseCase>(),
      snsLoginModuleAdapterFactory: get<_i126.SnsLoginModuleAdapterFactory>(),
      fUserInfoJoinReqDto: get<_i23.FUserInfoJoinReqDto>()));
  gh.lazySingleton<_i141.UpdateBallUseCaseInputPort>(() =>
      _i141.UpdateBallUseCase(fBallRepository: get<_i129.FBallRepository>()));
  gh.lazySingleton<_i142.BallImageListUpLoadUseCaseInputPort>(() =>
      _i142.BallImageListUpLoadUseCase(
          fBallRepository: get<_i129.FBallRepository>()));
  gh.lazySingleton<_i143.BallLikeUseCaseInputPort>(() => _i143.BallLikeUseCase(
      fBallValuationRepository: get<_i131.FBallValuationRepository>()));
  gh.lazySingleton<_i144.DeleteBallUseCaseInputPort>(() =>
      _i144.DeleteBallUseCase(fBallRepository: get<_i129.FBallRepository>()));
  gh.lazySingleton<_i145.PageMoveActionUseCaseInputPort>(() =>
      _i146.ID001PageMoveAction(
          selectBallUseCaseInputPort: get<_i138.SelectBallUseCaseInputPort>()));
  return get;
}
