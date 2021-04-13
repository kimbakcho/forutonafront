// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../AppBis/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart'
    as _i4;
import '../AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart' as _i11;
import '../AppBis/FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart'
    as _i75;
import '../AppBis/FBall/Data/Repository/FBallRepositoryImpl.dart' as _i121;
import '../AppBis/FBall/Data/Repository/NoInterestBallRepositoryImpl.dart'
    as _i90;
import '../AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart'
    as _i74;
import '../AppBis/FBall/Domain/Repository/FBallRepository.dart' as _i120;
import '../AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart'
    as _i89;
import '../AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart'
    as _i133;
import '../AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart'
    as _i135;
import '../AppBis/FBall/Domain/UseCase/FBallSearchBarHistory/FBallSearchBarHistoryUseCaseInputPort.dart'
    as _i81;
import '../AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart'
    as _i125;
import '../AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart'
    as _i126;
import '../AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart'
    as _i91;
import '../AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart'
    as _i129;
import '../AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart'
    as _i132;
import '../AppBis/FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart'
    as _i8;
import '../AppBis/FBallPlayer/Data/Repository/FBallPlayerRepositoryImpl.dart'
    as _i10;
import '../AppBis/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart'
    as _i9;
import '../AppBis/FBallPlayer/Domain/UseCase/FBallPlayerListUp/FBallPlayerListUpUseCaeInputPort.dart'
    as _i76;
import '../AppBis/FBallReply/Data/DataSource/FBallReplyDataSource.dart' as _i12;
import '../AppBis/FBallReply/Data/Repository/FBallReplyRepositoryImpl.dart'
    as _i78;
import '../AppBis/FBallReply/Domain/Repositroy/FBallReplyRepository.dart'
    as _i77;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCase.dart'
    as _i80;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart'
    as _i79;
import '../AppBis/FBallValuation/Data/Repository/FBallValuationRepositoryImpl.dart'
    as _i123;
import '../AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart'
    as _i122;
import '../AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart'
    as _i134;
import '../AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart'
    as _i124;
import '../AppBis/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart'
    as _i20;
import '../AppBis/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart'
    as _i46;
import '../AppBis/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart'
    as _i51;
import '../AppBis/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart'
    as _i68;
import '../AppBis/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart'
    as _i83;
import '../AppBis/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart'
    as _i48;
import '../AppBis/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart'
    as _i53;
import '../AppBis/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart'
    as _i70;
import '../AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart' as _i82;
import '../AppBis/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart'
    as _i47;
import '../AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart'
    as _i52;
import '../AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart'
    as _i69;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart'
    as _i105;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserUseCaseInputPort/FUserUseCaseInputPort.dart'
    as _i84;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart'
    as _i96;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart'
    as _i95;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart'
    as _i99;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart'
    as _i100;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart'
    as _i101;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserInfoUseCaseInputPort.dart'
    as _i102;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart'
    as _i119;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart'
    as _i118;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart'
    as _i104;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart'
    as _i103;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart'
    as _i128;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart'
    as _i127;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart'
    as _i50;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart'
    as _i49;
import '../AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart'
    as _i54;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart'
    as _i116;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart'
    as _i115;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart'
    as _i58;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart'
    as _i131;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart'
    as _i130;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart'
    as _i72;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart'
    as _i71;
import '../AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart' as _i19;
import '../AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart' as _i57;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart'
    as _i109;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart'
    as _i22;
import '../AppBis/MaliciousBall/Data/Repositroy/MaliciousBallRepositoryImpl.dart'
    as _i112;
import '../AppBis/MaliciousBall/Domain/Repository/MaliciousBallRepository.dart'
    as _i111;
import '../AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart'
    as _i113;
import '../AppBis/MaliciousReply/Data/Repository/MaliciousReplyRepositoryImpl.dart'
    as _i34;
import '../AppBis/MaliciousReply/Domain/Repository/MaliciousReplyRepository.dart'
    as _i33;
import '../AppBis/MaliciousReply/Domain/UseCase/MaliciousReplyUseCaseInputPort.dart'
    as _i35;
import '../AppBis/Notification/Domain/Channel/NotificationChannel.dart' as _i42;
import '../AppBis/Notification/Domain/Channel/NotificationRadarChannel.dart'
    as _i43;
import '../AppBis/Notification/Domain/NotificationUseCase/NearBallCreateUseCase.dart'
    as _i45;
import '../AppBis/Notification/Domain/NotificationUseCase/NotificationUseCaseInputPort.dart'
    as _i44;
import '../AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart' as _i13;
import '../AppBis/Tag/Data/Repository/TagRepositoryImpl.dart' as _i63;
import '../AppBis/Tag/Domain/Repository/TagRepository.dart' as _i62;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart'
    as _i94;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart'
    as _i93;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart'
    as _i98;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart'
    as _i97;
import '../Common/AndroidIntentAdapter/AndroidIntentAdapter.dart' as _i3;
import '../Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart' as _i73;
import '../Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart' as _i21;
import '../Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart' as _i106;
import '../Common/FireBaseMessage/Presentation/FireBaseMessageController.dart'
    as _i107;
import '../Common/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart'
    as _i18;
import '../Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart'
    as _i17;
import '../Common/FireBaseMessage/UseCase/FCMMessageUseCaseInputPort.dart'
    as _i14;
import '../Common/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart'
    as _i16;
import '../Common/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart'
    as _i15;
import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart'
    as _i23;
import '../Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart'
    as _i24;
import '../Common/FluttertoastAdapter/FluttertoastAdapter.dart' as _i25;
import '../Common/Geolocation/Adapter/GeolocatorAdapter.dart' as _i28;
import '../Common/Geolocation/Adapter/LocationAdapter.dart' as _i31;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart'
    as _i86;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart'
    as _i85;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart'
    as _i88;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart'
    as _i87;
import '../Common/GeoPlaceAdapter/GeoPlaceAdapter.dart' as _i27;
import '../Common/GlobalInitMutex/GlobalInitMutex.dart' as _i29;
import '../Common/GoogleMapSupport/MapBallMarkerFactory.dart' as _i114;
import '../Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart'
    as _i36;
import '../Common/GoogleMapSupport/MapMakerDescriptorContainer.dart' as _i108;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart'
    as _i5;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart'
    as _i6;
import '../Common/ImageCropUtil/ImageUtilInputPort.dart' as _i30;
import '../Common/MapScreenPosition/MapScreenPositionUseCase.dart' as _i38;
import '../Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart'
    as _i37;
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart'
    as _i60;
import '../Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart'
    as _i110;
import '../Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart'
    as _i55;
import '../Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart' as _i117;
import '../Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart' as _i61;
import '../Components/DetailPageViewer/DetailPageItemFactory.dart' as _i7;
import '../Components/PhoneAuthComponent/PhoneAuthMode/PhoneAuthModeFactory.dart'
    as _i92;
import '../Components/TagList/RankingTagListMediator.dart' as _i59;
import '../Components/UserInfoCollectionWidget/UserInfoCollectMediator.dart'
    as _i67;
import '../MainPage/MainPageView.dart' as _i32;
import '../ManagerBis/Notice/Data/NoticeRepositoryImpl.dart' as _i40;
import '../ManagerBis/Notice/Domain/NoticeRepository.dart' as _i39;
import '../ManagerBis/Notice/Domain/NoticeUseCaseInputPort.dart' as _i41;
import '../ManagerBis/TermsConditions/Data/Repository/TermsConditionsRepositoryImpl.dart'
    as _i65;
import '../ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart'
    as _i64;
import '../ManagerBis/TermsConditions/Domain/UseCase/TermsConditionsUseCaseInputPort.dart'
    as _i66;
import '../Page/GCodePage/Component/UserProfile/ProfileModeUseCase/ProfileModeUseCaseInputPort.dart'
    as _i56;
import '../Page/GCodePage/G001/G001MainPage.dart'
    as _i26; // ignore_for_file: unnecessary_lambdas

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
      () => _i6.BaseGoogleSurveyUseCase(),
      instanceName: 'BaseGoogleSurveyUseCase');
  gh.lazySingleton<_i7.DetailPageItemFactory>(
      () => _i7.DetailPageItemFactory());
  gh.lazySingleton<_i8.FBallPlayerRemoteDataSource>(
      () => _i8.FBallPlayerRemoteDataSourceImpl());
  gh.lazySingleton<_i9.FBallPlayerRepository>(() =>
      _i10.FBallPlayerRepositoryImpl(
          fBallPlayerRemoteDataSource: get<_i8.FBallPlayerRemoteDataSource>()));
  gh.lazySingleton<_i11.FBallRemoteDataSource>(
      () => _i11.FBallRemoteSourceImpl());
  gh.lazySingleton<_i12.FBallReplyDataSource>(
      () => _i12.FBallReplyDataSourceImpl());
  gh.lazySingleton<_i13.FBallTagRemoteDataSource>(
      () => _i13.FBallTagRemoteDataSourceImpl());
  gh.lazySingleton<_i14.FCMMessageUseCaseInputPort>(
      () => _i15.ResumeMessageUseCase(),
      instanceName: 'ResumeMessageUseCase');
  gh.lazySingleton<_i14.FCMMessageUseCaseInputPort>(
      () => _i16.LaunchMessageUseCase(),
      instanceName: 'LaunchMessageUseCase');
  gh.lazySingleton<_i14.FCMMessageUseCaseInputPort>(
      () => _i17.BaseMessageUseCase(),
      instanceName: 'BaseMessageUseCase');
  gh.lazySingleton<_i14.FCMMessageUseCaseInputPort>(
      () => _i18.BackGroundMessageUseCase(),
      instanceName: 'BackGroundMessageUseCase');
  gh.lazySingleton<_i19.FUserInfoJoinReqDto>(() => _i19.FUserInfoJoinReqDto());
  gh.lazySingleton<_i20.FUserRemoteDataSource>(
      () => _i20.FUserRemoteDataSourceImpl());
  gh.lazySingleton<_i21.FileDownLoaderUseCaseInputPort>(
      () => _i21.FileDownLoaderUseCase());
  gh.lazySingleton<_i22.FireBaseAuthBaseAdapter>(
      () => _i22.FireBaseAuthBaseAdapterImpl());
  gh.lazySingleton<_i23.FlutterImageCompressAdapter>(
      () => _i23.FlutterImageCompressAdapterImpl());
  gh.lazySingleton<_i24.FlutterLocalNotificationsPluginAdapter>(
      () => _i24.FlutterLocalNotificationsPluginAdapterImpl());
  gh.lazySingleton<_i25.FluttertoastAdapter>(() => _i25.FluttertoastAdapter());
  gh.lazySingleton<_i26.G001MainPageViewModelController>(
      () => _i26.G001MainPageViewModelController());
  gh.factory<_i27.GeoPlaceAdapter>(() => _i27.GooglePlaceAdapter());
  gh.lazySingleton<_i28.GeolocatorAdapter>(() => _i28.GeolocatorAdapterImpl());
  gh.lazySingleton<_i29.GlobalInitMutex>(() => _i29.GlobalInitMutex());
  gh.lazySingleton<_i30.ImageUtilInputPort>(() => _i30.ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
  gh.lazySingleton<_i30.ImageUtilInputPort>(() => _i30.ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.lazySingleton<_i30.ImageUtilInputPort>(() => _i30.ImagePngResizeUtil(),
      instanceName: 'ImagePngResizeUtil');
  gh.lazySingleton<_i31.LocationAdapter>(() => _i31.LocationAdapterImpl());
  gh.lazySingleton<_i32.MainPageViewModelController>(
      () => _i32.MainPageViewModelController());
  gh.lazySingleton<_i33.MaliciousReplyRepository>(() =>
      _i34.MaliciousReplyRepositoryImpl(get<_i22.FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<_i35.MaliciousReplyUseCaseInputPort>(
      () => _i35.MaliciousReplyUseCase(get<_i33.MaliciousReplyRepository>()));
  gh.lazySingleton<_i36.MapBitmapDescriptorUseCaseInputPort>(() =>
      _i36.MapBitmapDescriptorUseCase(
          imagePngResizeUtil:
              get<_i30.ImageUtilInputPort>(instanceName: 'ImagePngResizeUtil'),
          imageBorderAvatarUtil: get<_i30.ImageUtilInputPort>(
              instanceName: 'ImageBorderAvatarUtil'),
          fileDownLoaderUseCaseInputPort:
              get<_i21.FileDownLoaderUseCaseInputPort>()));
  gh.lazySingleton<_i37.MapScreenPositionUseCaseInputPort>(
      () => _i38.MapScreenPositionUseCase());
  gh.factory<_i39.NoticeRepository>(() => _i40.NoticeRepositoryImpl());
  gh.factory<_i41.NoticeUseCaseInputPort>(
      () => _i41.NoticeUseCase(get<_i39.NoticeRepository>()));
  gh.lazySingleton<_i42.NotificationChannel>(
      () => _i43.NotificationRadarChannel(),
      instanceName: 'NotificationRadarChannel');
  gh.lazySingleton<_i44.NotificationUseCaseInputPort>(
      () => _i45.NearBallCreateUseCase(
          get<_i24.FlutterLocalNotificationsPluginAdapter>()),
      instanceName: 'NearBallCreateUseCase');
  gh.lazySingleton<_i46.PersonaSettingNoticeRemoteDataSource>(
      () => _i46.PersonaSettingNoticeRemoteDataSourceImpl());
  gh.lazySingleton<_i47.PersonaSettingNoticeRepository>(() =>
      _i48.PersonaSettingNoticeRepositoryImpl(
          personaSettingNoticeRemoteDataSource:
              get<_i46.PersonaSettingNoticeRemoteDataSource>()));
  gh.lazySingleton<_i49.PersonaSettingNoticeUseCaseInputPort>(() =>
      _i50.PersonaSettingNoticeUseCase(
          personaSettingNoticeRepository:
              get<_i47.PersonaSettingNoticeRepository>()));
  gh.lazySingleton<_i51.PhoneAuthRemoteSource>(
      () => _i51.PhoneAuthRemoteSourceImpl());
  gh.lazySingleton<_i52.PhoneAuthRepository>(() => _i53.PhoneAuthRepositoryImpl(
      phoneAuthRemoteSource: get<_i51.PhoneAuthRemoteSource>()));
  gh.lazySingleton<_i54.PhoneAuthUseCaseInputPort>(() => _i54.PhoneAuthUseCase(
      phoneAuthRepository: get<_i52.PhoneAuthRepository>()));
  gh.factory<_i55.PhoneFindValidUseCase>(() => _i55.PhoneFindValidUseCaseImpl(
      phoneAuthRepository: get<_i52.PhoneAuthRepository>()));
  gh.lazySingleton<_i56.ProfileModeUseCaseFactory>(
      () => _i56.ProfileModeUseCaseFactory());
  gh.lazySingleton<_i57.PwChangeFromPhoneAuthReqDto>(
      () => _i57.PwChangeFromPhoneAuthReqDto());
  gh.lazySingleton<_i58.PwFindPhoneUseCaseInputPort>(() =>
      _i58.PwFindPhoneUseCase(
          phoneAuthRepository: get<_i52.PhoneAuthRepository>()));
  gh.factory<_i59.RankingTagListMediator>(
      () => _i59.RankingTagListMediatorImpl());
  gh.lazySingleton<_i60.SharedPreferencesAdapter>(
      () => _i60.SharedPreferencesAdapterImpl());
  gh.factory<_i61.SwipeGestureRecognizerController>(
      () => _i61.SwipeGestureRecognizerController());
  gh.lazySingleton<_i62.TagRepository>(() => _i63.TagRepositoryImpl(
      fBallTagRemoteDataSource: get<_i13.FBallTagRemoteDataSource>()));
  gh.factory<_i64.TermsConditionsRepository>(
      () => _i65.TermsConditionsRepositoryImpl());
  gh.factory<_i66.TermsConditionsUseCaseInputPort>(() =>
      _i66.TermsConditionsUseCase(
          termsConditionsRepository: get<_i64.TermsConditionsRepository>()));
  gh.factory<_i67.UserInfoCollectMediator>(
      () => _i67.UserInfoCollectMediatorImpl());
  gh.lazySingleton<_i68.UserPolicyRemoteDataSource>(
      () => _i68.UserPolicyRemoteDataSourceImpl());
  gh.lazySingleton<_i69.UserPolicyRepository>(() =>
      _i70.UserPolicyRepositoryImpl(
          userPolicyRemoteDataSource: get<_i68.UserPolicyRemoteDataSource>()));
  gh.lazySingleton<_i71.UserPolicyUseCaseInputPort>(() =>
      _i72.UserPolicyUseCase(
          userPolicyRepository: get<_i69.UserPolicyRepository>()));
  gh.lazySingleton<_i73.AvatarImageMakerUseCaseInputPort>(() =>
      _i73.AvatarImageMakerUseCase(
          fileDownLoaderUseCaseInputPort:
              get<_i21.FileDownLoaderUseCaseInputPort>(),
          imageUtilInputPort: get<_i30.ImageUtilInputPort>()));
  gh.lazySingleton<_i74.BallSearchBarHistoryRepository>(() =>
      _i75.BallSearchBarHistoryRepositoryImpl(
          localDataSource: get<_i4.BallSearchHistoryLocalDataSource>()));
  gh.lazySingleton<_i76.FBallPlayerListUpInputPort>(() =>
      _i76.FBallPlayerListUpUseCae(
          fBallPlayerRepository: get<_i9.FBallPlayerRepository>()));
  gh.lazySingleton<_i77.FBallReplyRepository>(() =>
      _i78.FBallReplyRepositoryImpl(
          fBallReplyDataSource: get<_i12.FBallReplyDataSource>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<_i79.FBallReplyUseCaseInputPort>(() =>
      _i80.FBallReplyUseCase(
          fBallReplyRepository: get<_i77.FBallReplyRepository>()));
  gh.lazySingleton<_i81.FBallSearchBarHistoryUseCaseInputPort>(() =>
      _i81.FBallSearchBarHistoryUseCase(
          ballSearchBarHistoryRepository:
              get<_i74.BallSearchBarHistoryRepository>()));
  gh.lazySingleton<_i82.FUserRepository>(() => _i83.FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
      fUserRemoteDataSource: get<_i20.FUserRemoteDataSource>()));
  gh.lazySingleton<_i84.FUserUseCaseInputPort>(
      () => _i84.FUserUseCase(get<_i82.FUserRepository>()));
  gh.lazySingleton<_i85.GeoLocationUtilBasicUseCaseInputPort>(() =>
      _i86.GeoLocationUtilBasicUseCase(
          geolocatorAdapter: get<_i28.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i60.SharedPreferencesAdapter>()));
  gh.lazySingleton<_i87.GeoLocationUtilForeGroundUseCaseInputPort>(() =>
      _i88.GeoLocationUtilForeGroundUseCase(
          basicUseCaseInputPort:
              get<_i85.GeoLocationUtilBasicUseCaseInputPort>(),
          geolocatorAdapter: get<_i28.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i60.SharedPreferencesAdapter>(),
          locationAdapter: get<_i31.LocationAdapter>()));
  gh.lazySingleton<_i89.NoInterestBallRepository>(() =>
      _i90.NoInterestBallRepositoryImpl(
          sharedPreferencesAdapter: get<_i60.SharedPreferencesAdapter>()));
  gh.lazySingleton<_i91.NoInterestBallUseCaseInputPort>(() =>
      _i91.NoInterestBallUseCase(
          noInterestBallRepository: get<_i89.NoInterestBallRepository>()));
  gh.factory<_i92.PhoneAuthModeFactory>(() => _i92.PhoneAuthModeFactory(
      get<_i54.PhoneAuthUseCaseInputPort>(),
      get<_i55.PhoneFindValidUseCase>()));
  gh.lazySingleton<
          _i93.RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      () => _i94.RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: get<_i62.TagRepository>()));
  gh.lazySingleton<_i95.SignInUserInfoUseCaseInputPort>(() =>
      _i96.SignInUserInfoUseCase(fUserRepository: get<_i82.FUserRepository>()));
  gh.lazySingleton<_i97.TagFromBallUuidUseCaseInputPort>(() =>
      _i98.TagFromBallUuidUseCase(tagRepository: get<_i62.TagRepository>()));
  gh.lazySingleton<_i99.UpdateAccountUserInfoUseCaseInputPort>(() =>
      _i99.UpdateAccountUserInfoUseCase(
          fUserRepository: get<_i82.FUserRepository>()));
  gh.lazySingleton<_i100.UpdateFCMTokenUseCaseInputPort>(() =>
      _i100.UpdateFCMTokenUseCase(
          fUserRepository: get<_i82.FUserRepository>()));
  gh.lazySingleton<_i101.UpdateUserPositionUseCaseInputPort>(() =>
      _i101.UpdateUserPositionUseCase(
          fUserRepository: get<_i82.FUserRepository>()));
  gh.lazySingleton<_i102.UserInfoUseCaseInputPort>(
      () => _i102.UserInfoUseCase(get<_i82.FUserRepository>()));
  gh.lazySingleton<_i103.UserProfileImageUploadUseCaseInputPort>(() =>
      _i104.UserProfileImageUploadUseCase(
          flutterImageCompressAdapter: get<_i23.FlutterImageCompressAdapter>(),
          fUserRepository: get<_i82.FUserRepository>()));
  gh.lazySingleton<_i105.FUserPwChangeUseCaseInputPort>(() =>
      _i105.FUserPwChangeUseCase(fUserRepository: get<_i82.FUserRepository>()));
  gh.lazySingleton<_i106.FireBaseMessageAdapter>(() =>
      _i106.FireBaseMessageAdapterImpl(
          signInUserInfoUseCaseInputPort:
              get<_i95.SignInUserInfoUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
          updateFCMTokenUseCaseInputPort:
              get<_i100.UpdateFCMTokenUseCaseInputPort>()));
  gh.lazySingleton<_i107.FireBaseMessageController>(() =>
      _i107.FireBaseMessageController(
          fireBaseMessageAdapter: get<_i106.FireBaseMessageAdapter>()));
  gh.lazySingleton<_i108.MapMakerDescriptorContainer>(() =>
      _i108.MapMakerDescriptorContainerImpl(
          mapBitmapDescriptorUseCaseInputPort:
              get<_i36.MapBitmapDescriptorUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i95.SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<_i109.FireBaseAuthAdapterForUseCase>(() =>
      _i109.FireBaseAuthAdapterForUseCaseImpl(
          fireBaseMessageAdapter: get<_i106.FireBaseMessageAdapter>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i95.SignInUserInfoUseCaseInputPort>(),
          updateFCMTokenUseCaseInputPort:
              get<_i100.UpdateFCMTokenUseCaseInputPort>()));
  gh.factory<_i110.FireBaseSignInValidUseCase>(() =>
      _i110.FireBaseSignInValidUseCaseImpl(
          fireBaseAuthAdapterForUseCase:
              get<_i109.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i111.MaliciousBallRepository>(() =>
      _i112.MaliciousBallRepositoryImpl(
          get<_i109.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i113.MaliciousBallUseCaseInputPort>(
      () => _i113.MaliciousBallUseCase(get<_i111.MaliciousBallRepository>()));
  gh.lazySingleton<_i114.MapBallMarkerFactory>(() => _i114.MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<_i108.MapMakerDescriptorContainer>()));
  gh.lazySingleton<_i115.PwFindEmailUseCaseInputPort>(() =>
      _i116.PwFindEmailUseCase(
          fireBaseAuthAdapterForUseCase:
              get<_i109.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i117.SnsLoginModuleAdapterFactory>(() =>
      _i117.SnsLoginModuleAdapterFactory(
          get<_i109.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i118.UserPositionForegroundMonitoringUseCaseInputPort>(() =>
      _i119.UserPositionForegroundMonitoringUseCase(
          geoLocationUtilBasicUseCaseInputPort:
              get<_i85.GeoLocationUtilBasicUseCaseInputPort>(),
          fUserRepository: get<_i82.FUserRepository>(),
          fireBaseAuthAdapterForUseCase:
              get<_i109.FireBaseAuthAdapterForUseCase>(),
          updateUserPositionUseCaseInputPort:
              get<_i101.UpdateUserPositionUseCaseInputPort>()));
  gh.lazySingleton<_i120.FBallRepository>(() => _i121.FBallRepositoryImpl(
      fBallRemoteDataSource: get<_i11.FBallRemoteDataSource>(),
      fireBaseAuthBaseAdapter: get<_i109.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i122.FBallValuationRepository>(() =>
      _i123.FBallValuationRepositoryImpl(
          fireBaseAuthBaseAdapter: get<_i109.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i124.FBallValuationUseCaseInputPort>(() =>
      _i124.FBallValuationUseCase(
          fBallValuationRepository: get<_i122.FBallValuationRepository>()));
  gh.lazySingleton<_i125.HitBallUseCaseInputPort>(() =>
      _i125.HitBallUseCase(fBallRepository: get<_i120.FBallRepository>()));
  gh.lazySingleton<_i126.InsertBallUseCaseInputPort>(() =>
      _i126.InsertBallUseCase(fBallRepository: get<_i120.FBallRepository>()));
  gh.lazySingleton<_i127.LogoutUseCaseInputPort>(() => _i128.LogoutUseCase(
      fireBaseAuthAdapterForUseCase: get<_i109.FireBaseAuthAdapterForUseCase>(),
      signInUserInfoUseCaseInputPort:
          get<_i95.SignInUserInfoUseCaseInputPort>(),
      snsLoginModuleAdapterFactory: get<_i117.SnsLoginModuleAdapterFactory>()));
  gh.lazySingleton<_i129.SelectBallUseCaseInputPort>(() =>
      _i129.SelectBallUseCase(fBallRepository: get<_i120.FBallRepository>()));
  gh.lazySingleton<_i130.SingUpUseCaseInputPort>(() => _i131.SingUpUseCase(
      fUserRepository: get<_i82.FUserRepository>(),
      fireBaseAuthAdapterForUseCase: get<_i109.FireBaseAuthAdapterForUseCase>(),
      snsLoginModuleAdapterFactory: get<_i117.SnsLoginModuleAdapterFactory>(),
      fUserInfoJoinReqDto: get<_i19.FUserInfoJoinReqDto>()));
  gh.lazySingleton<_i132.UpdateBallUseCaseInputPort>(() =>
      _i132.UpdateBallUseCase(fBallRepository: get<_i120.FBallRepository>()));
  gh.lazySingleton<_i133.BallImageListUpLoadUseCaseInputPort>(() =>
      _i133.BallImageListUpLoadUseCase(
          fBallRepository: get<_i120.FBallRepository>()));
  gh.lazySingleton<_i134.BallLikeUseCaseInputPort>(() => _i134.BallLikeUseCase(
      fBallValuationRepository: get<_i122.FBallValuationRepository>()));
  gh.lazySingleton<_i135.DeleteBallUseCaseInputPort>(() =>
      _i135.DeleteBallUseCase(fBallRepository: get<_i120.FBallRepository>()));
  return get;
}
