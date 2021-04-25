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
    as _i74;
import '../AppBis/FBall/Data/Repository/FBallRepositoryImpl.dart' as _i124;
import '../AppBis/FBall/Data/Repository/NoInterestBallRepositoryImpl.dart'
    as _i89;
import '../AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart'
    as _i73;
import '../AppBis/FBall/Domain/Repository/FBallRepository.dart' as _i123;
import '../AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart'
    as _i88;
import '../AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart'
    as _i136;
import '../AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart'
    as _i138;
import '../AppBis/FBall/Domain/UseCase/FBallSearchBarHistory/FBallSearchBarHistoryUseCaseInputPort.dart'
    as _i80;
import '../AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart'
    as _i128;
import '../AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart'
    as _i129;
import '../AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart'
    as _i107;
import '../AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart'
    as _i132;
import '../AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart'
    as _i135;
import '../AppBis/FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart'
    as _i8;
import '../AppBis/FBallPlayer/Data/Repository/FBallPlayerRepositoryImpl.dart'
    as _i10;
import '../AppBis/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart'
    as _i9;
import '../AppBis/FBallPlayer/Domain/UseCase/FBallPlayerListUp/FBallPlayerListUpUseCaeInputPort.dart'
    as _i75;
import '../AppBis/FBallReply/Data/DataSource/FBallReplyDataSource.dart' as _i12;
import '../AppBis/FBallReply/Data/Repository/FBallReplyRepositoryImpl.dart'
    as _i77;
import '../AppBis/FBallReply/Domain/Repositroy/FBallReplyRepository.dart'
    as _i76;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCase.dart'
    as _i79;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart'
    as _i78;
import '../AppBis/FBallValuation/Data/Repository/FBallValuationRepositoryImpl.dart'
    as _i126;
import '../AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart'
    as _i125;
import '../AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart'
    as _i137;
import '../AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart'
    as _i127;
import '../AppBis/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart'
    as _i20;
import '../AppBis/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart'
    as _i45;
import '../AppBis/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart'
    as _i50;
import '../AppBis/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart'
    as _i67;
import '../AppBis/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart'
    as _i82;
import '../AppBis/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart'
    as _i47;
import '../AppBis/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart'
    as _i52;
import '../AppBis/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart'
    as _i69;
import '../AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart' as _i81;
import '../AppBis/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart'
    as _i46;
import '../AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart'
    as _i51;
import '../AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart'
    as _i68;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart'
    as _i103;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserUseCaseInputPort/FUserUseCaseInputPort.dart'
    as _i83;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart'
    as _i94;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart'
    as _i93;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart'
    as _i97;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart'
    as _i98;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart'
    as _i99;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserInfoUseCaseInputPort.dart'
    as _i100;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart'
    as _i122;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart'
    as _i121;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart'
    as _i102;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart'
    as _i101;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart'
    as _i131;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart'
    as _i130;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart'
    as _i49;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart'
    as _i48;
import '../AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart'
    as _i53;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart'
    as _i119;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart'
    as _i118;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart'
    as _i57;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart'
    as _i134;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart'
    as _i133;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart'
    as _i71;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart'
    as _i70;
import '../AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart' as _i19;
import '../AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart' as _i56;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart'
    as _i112;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart'
    as _i22;
import '../AppBis/MaliciousBall/Data/Repositroy/MaliciousBallRepositoryImpl.dart'
    as _i115;
import '../AppBis/MaliciousBall/Domain/Repository/MaliciousBallRepository.dart'
    as _i114;
import '../AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart'
    as _i116;
import '../AppBis/MaliciousReply/Data/Repository/MaliciousReplyRepositoryImpl.dart'
    as _i34;
import '../AppBis/MaliciousReply/Domain/Repository/MaliciousReplyRepository.dart'
    as _i33;
import '../AppBis/MaliciousReply/Domain/UseCase/MaliciousReplyUseCaseInputPort.dart'
    as _i35;
import '../AppBis/Notification/Domain/Channel/NotificationChannel.dart' as _i42;
import '../AppBis/Notification/Domain/Channel/NotificationMyFluenceChannel.dart'
    as _i43;
import '../AppBis/Notification/Domain/Channel/NotificationRadarChannel.dart'
    as _i44;
import '../AppBis/Notification/Domain/NotificationUseCase/FullTicketChargeUseCase.dart'
    as _i111;
import '../AppBis/Notification/Domain/NotificationUseCase/NearBallCreateUseCase.dart'
    as _i109;
import '../AppBis/Notification/Domain/NotificationUseCase/NotificationFBallReplyUseCase.dart'
    as _i110;
import '../AppBis/Notification/Domain/NotificationUseCase/NotificationUseCaseInputPort.dart'
    as _i108;
import '../AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart' as _i13;
import '../AppBis/Tag/Data/Repository/TagRepositoryImpl.dart' as _i62;
import '../AppBis/Tag/Domain/Repository/TagRepository.dart' as _i61;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart'
    as _i92;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart'
    as _i91;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart'
    as _i96;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart'
    as _i95;
import '../Common/AndroidIntentAdapter/AndroidIntentAdapter.dart' as _i3;
import '../Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart' as _i72;
import '../Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart' as _i21;
import '../Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart' as _i104;
import '../Common/FireBaseMessage/Presentation/FireBaseMessageController.dart'
    as _i105;
import '../Common/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart'
    as _i18;
import '../Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart'
    as _i15;
import '../Common/FireBaseMessage/UseCase/FCMMessageUseCaseInputPort.dart'
    as _i14;
import '../Common/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart'
    as _i17;
import '../Common/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart'
    as _i16;
import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart'
    as _i23;
import '../Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart'
    as _i24;
import '../Common/FluttertoastAdapter/FluttertoastAdapter.dart' as _i25;
import '../Common/Geolocation/Adapter/GeolocatorAdapter.dart' as _i28;
import '../Common/Geolocation/Adapter/LocationAdapter.dart' as _i31;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart'
    as _i85;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart'
    as _i84;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart'
    as _i87;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart'
    as _i86;
import '../Common/GeoPlaceAdapter/GeoPlaceAdapter.dart' as _i27;
import '../Common/GlobalInitMutex/GlobalInitMutex.dart' as _i29;
import '../Common/GoogleMapSupport/MapBallMarkerFactory.dart' as _i117;
import '../Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart'
    as _i36;
import '../Common/GoogleMapSupport/MapMakerDescriptorContainer.dart' as _i106;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart'
    as _i5;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart'
    as _i6;
import '../Common/ImageCropUtil/ImageUtilInputPort.dart' as _i30;
import '../Common/MapScreenPosition/MapScreenPositionUseCase.dart' as _i38;
import '../Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart'
    as _i37;
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart'
    as _i59;
import '../Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart'
    as _i113;
import '../Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart'
    as _i54;
import '../Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart' as _i120;
import '../Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart' as _i60;
import '../Components/DetailPageViewer/DetailPageItemFactory.dart' as _i7;
import '../Components/PhoneAuthComponent/PhoneAuthMode/PhoneAuthModeFactory.dart'
    as _i90;
import '../Components/TagList/RankingTagListMediator.dart' as _i58;
import '../Components/UserInfoCollectionWidget/UserInfoCollectMediator.dart'
    as _i66;
import '../MainPage/MainPageView.dart' as _i32;
import '../ManagerBis/Notice/Data/NoticeRepositoryImpl.dart' as _i40;
import '../ManagerBis/Notice/Domain/NoticeRepository.dart' as _i39;
import '../ManagerBis/Notice/Domain/NoticeUseCaseInputPort.dart' as _i41;
import '../ManagerBis/TermsConditions/Data/Repository/TermsConditionsRepositoryImpl.dart'
    as _i64;
import '../ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart'
    as _i63;
import '../ManagerBis/TermsConditions/Domain/UseCase/TermsConditionsUseCaseInputPort.dart'
    as _i65;
import '../Page/GCodePage/Component/UserProfile/ProfileModeUseCase/ProfileModeUseCaseInputPort.dart'
    as _i55;
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
      () => _i15.BaseMessageUseCase(),
      instanceName: 'BaseMessageUseCase');
  gh.lazySingleton<_i14.FCMMessageUseCaseInputPort>(
      () => _i16.ResumeMessageUseCase(),
      instanceName: 'ResumeMessageUseCase');
  gh.lazySingleton<_i14.FCMMessageUseCaseInputPort>(
      () => _i17.LaunchMessageUseCase(),
      instanceName: 'LaunchMessageUseCase');
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
  gh.lazySingleton<_i30.ImageUtilInputPort>(() => _i30.ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.lazySingleton<_i30.ImageUtilInputPort>(() => _i30.ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
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
      () => _i43.NotificationMyFluenceChannel(),
      instanceName: 'NotificationMyFluenceChannel');
  gh.lazySingleton<_i42.NotificationChannel>(
      () => _i44.NotificationRadarChannel(),
      instanceName: 'NotificationRadarChannel');
  gh.lazySingleton<_i45.PersonaSettingNoticeRemoteDataSource>(
      () => _i45.PersonaSettingNoticeRemoteDataSourceImpl());
  gh.lazySingleton<_i46.PersonaSettingNoticeRepository>(() =>
      _i47.PersonaSettingNoticeRepositoryImpl(
          personaSettingNoticeRemoteDataSource:
              get<_i45.PersonaSettingNoticeRemoteDataSource>()));
  gh.lazySingleton<_i48.PersonaSettingNoticeUseCaseInputPort>(() =>
      _i49.PersonaSettingNoticeUseCase(
          personaSettingNoticeRepository:
              get<_i46.PersonaSettingNoticeRepository>()));
  gh.lazySingleton<_i50.PhoneAuthRemoteSource>(
      () => _i50.PhoneAuthRemoteSourceImpl());
  gh.lazySingleton<_i51.PhoneAuthRepository>(() => _i52.PhoneAuthRepositoryImpl(
      phoneAuthRemoteSource: get<_i50.PhoneAuthRemoteSource>()));
  gh.lazySingleton<_i53.PhoneAuthUseCaseInputPort>(() => _i53.PhoneAuthUseCase(
      phoneAuthRepository: get<_i51.PhoneAuthRepository>()));
  gh.factory<_i54.PhoneFindValidUseCase>(() => _i54.PhoneFindValidUseCaseImpl(
      phoneAuthRepository: get<_i51.PhoneAuthRepository>()));
  gh.lazySingleton<_i55.ProfileModeUseCaseFactory>(
      () => _i55.ProfileModeUseCaseFactory());
  gh.lazySingleton<_i56.PwChangeFromPhoneAuthReqDto>(
      () => _i56.PwChangeFromPhoneAuthReqDto());
  gh.lazySingleton<_i57.PwFindPhoneUseCaseInputPort>(() =>
      _i57.PwFindPhoneUseCase(
          phoneAuthRepository: get<_i51.PhoneAuthRepository>()));
  gh.factory<_i58.RankingTagListMediator>(
      () => _i58.RankingTagListMediatorImpl());
  gh.lazySingleton<_i59.SharedPreferencesAdapter>(
      () => _i59.SharedPreferencesAdapterImpl());
  gh.factory<_i60.SwipeGestureRecognizerController>(
      () => _i60.SwipeGestureRecognizerController());
  gh.lazySingleton<_i61.TagRepository>(() => _i62.TagRepositoryImpl(
      fBallTagRemoteDataSource: get<_i13.FBallTagRemoteDataSource>()));
  gh.factory<_i63.TermsConditionsRepository>(
      () => _i64.TermsConditionsRepositoryImpl());
  gh.factory<_i65.TermsConditionsUseCaseInputPort>(() =>
      _i65.TermsConditionsUseCase(
          termsConditionsRepository: get<_i63.TermsConditionsRepository>()));
  gh.factory<_i66.UserInfoCollectMediator>(
      () => _i66.UserInfoCollectMediatorImpl());
  gh.lazySingleton<_i67.UserPolicyRemoteDataSource>(
      () => _i67.UserPolicyRemoteDataSourceImpl());
  gh.lazySingleton<_i68.UserPolicyRepository>(() =>
      _i69.UserPolicyRepositoryImpl(
          userPolicyRemoteDataSource: get<_i67.UserPolicyRemoteDataSource>()));
  gh.lazySingleton<_i70.UserPolicyUseCaseInputPort>(() =>
      _i71.UserPolicyUseCase(
          userPolicyRepository: get<_i68.UserPolicyRepository>()));
  gh.lazySingleton<_i72.AvatarImageMakerUseCaseInputPort>(() =>
      _i72.AvatarImageMakerUseCase(
          fileDownLoaderUseCaseInputPort:
              get<_i21.FileDownLoaderUseCaseInputPort>(),
          imageUtilInputPort: get<_i30.ImageUtilInputPort>()));
  gh.lazySingleton<_i73.BallSearchBarHistoryRepository>(() =>
      _i74.BallSearchBarHistoryRepositoryImpl(
          localDataSource: get<_i4.BallSearchHistoryLocalDataSource>()));
  gh.lazySingleton<_i75.FBallPlayerListUpInputPort>(() =>
      _i75.FBallPlayerListUpUseCae(
          fBallPlayerRepository: get<_i9.FBallPlayerRepository>()));
  gh.lazySingleton<_i76.FBallReplyRepository>(() =>
      _i77.FBallReplyRepositoryImpl(
          fBallReplyDataSource: get<_i12.FBallReplyDataSource>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<_i78.FBallReplyUseCaseInputPort>(() =>
      _i79.FBallReplyUseCase(
          fBallReplyRepository: get<_i76.FBallReplyRepository>()));
  gh.lazySingleton<_i80.FBallSearchBarHistoryUseCaseInputPort>(() =>
      _i80.FBallSearchBarHistoryUseCase(
          ballSearchBarHistoryRepository:
              get<_i73.BallSearchBarHistoryRepository>()));
  gh.lazySingleton<_i81.FUserRepository>(() => _i82.FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
      fUserRemoteDataSource: get<_i20.FUserRemoteDataSource>()));
  gh.lazySingleton<_i83.FUserUseCaseInputPort>(
      () => _i83.FUserUseCase(get<_i81.FUserRepository>()));
  gh.lazySingleton<_i84.GeoLocationUtilBasicUseCaseInputPort>(() =>
      _i85.GeoLocationUtilBasicUseCase(
          geolocatorAdapter: get<_i28.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i59.SharedPreferencesAdapter>()));
  gh.lazySingleton<_i86.GeoLocationUtilForeGroundUseCaseInputPort>(() =>
      _i87.GeoLocationUtilForeGroundUseCase(
          basicUseCaseInputPort:
              get<_i84.GeoLocationUtilBasicUseCaseInputPort>(),
          geolocatorAdapter: get<_i28.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i59.SharedPreferencesAdapter>(),
          locationAdapter: get<_i31.LocationAdapter>()));
  gh.lazySingleton<_i88.NoInterestBallRepository>(() =>
      _i89.NoInterestBallRepositoryImpl(
          sharedPreferencesAdapter: get<_i59.SharedPreferencesAdapter>()));
  gh.factory<_i90.PhoneAuthModeFactory>(() => _i90.PhoneAuthModeFactory(
      get<_i53.PhoneAuthUseCaseInputPort>(),
      get<_i54.PhoneFindValidUseCase>()));
  gh.lazySingleton<
          _i91.RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      () => _i92.RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: get<_i61.TagRepository>()));
  gh.lazySingleton<_i93.SignInUserInfoUseCaseInputPort>(() =>
      _i94.SignInUserInfoUseCase(fUserRepository: get<_i81.FUserRepository>()));
  gh.lazySingleton<_i95.TagFromBallUuidUseCaseInputPort>(() =>
      _i96.TagFromBallUuidUseCase(tagRepository: get<_i61.TagRepository>()));
  gh.lazySingleton<_i97.UpdateAccountUserInfoUseCaseInputPort>(() =>
      _i97.UpdateAccountUserInfoUseCase(
          fUserRepository: get<_i81.FUserRepository>()));
  gh.lazySingleton<_i98.UpdateFCMTokenUseCaseInputPort>(() =>
      _i98.UpdateFCMTokenUseCase(fUserRepository: get<_i81.FUserRepository>()));
  gh.lazySingleton<_i99.UpdateUserPositionUseCaseInputPort>(() =>
      _i99.UpdateUserPositionUseCase(
          fUserRepository: get<_i81.FUserRepository>()));
  gh.lazySingleton<_i100.UserInfoUseCaseInputPort>(
      () => _i100.UserInfoUseCase(get<_i81.FUserRepository>()));
  gh.lazySingleton<_i101.UserProfileImageUploadUseCaseInputPort>(() =>
      _i102.UserProfileImageUploadUseCase(
          flutterImageCompressAdapter: get<_i23.FlutterImageCompressAdapter>(),
          fUserRepository: get<_i81.FUserRepository>()));
  gh.lazySingleton<_i103.FUserPwChangeUseCaseInputPort>(() =>
      _i103.FUserPwChangeUseCase(fUserRepository: get<_i81.FUserRepository>()));
  gh.lazySingleton<_i104.FireBaseMessageAdapter>(() =>
      _i104.FireBaseMessageAdapterImpl(
          signInUserInfoUseCaseInputPort:
              get<_i93.SignInUserInfoUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
          updateFCMTokenUseCaseInputPort:
              get<_i98.UpdateFCMTokenUseCaseInputPort>()));
  gh.lazySingleton<_i105.FireBaseMessageController>(() =>
      _i105.FireBaseMessageController(
          fireBaseMessageAdapter: get<_i104.FireBaseMessageAdapter>()));
  gh.lazySingleton<_i106.MapMakerDescriptorContainer>(() =>
      _i106.MapMakerDescriptorContainerImpl(
          mapBitmapDescriptorUseCaseInputPort:
              get<_i36.MapBitmapDescriptorUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i93.SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<_i107.NoInterestBallUseCaseInputPort>(() =>
      _i107.NoInterestBallUseCase(
          noInterestBallRepository: get<_i88.NoInterestBallRepository>(),
          signInUserInfoUseCaseInputPort:
              get<_i93.SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<_i108.NotificationUseCaseInputPort>(
      () => _i109.NearBallCreateUseCase(
          get<_i24.FlutterLocalNotificationsPluginAdapter>(),
          get<_i93.SignInUserInfoUseCaseInputPort>()),
      instanceName: 'NearBallCreateUseCase');
  gh.lazySingleton<_i108.NotificationUseCaseInputPort>(
      () => _i110.NotificationFBallReplyUseCase(
          get<_i24.FlutterLocalNotificationsPluginAdapter>(),
          get<_i93.SignInUserInfoUseCaseInputPort>()),
      instanceName: 'NotificationFBallReplyUseCase');
  gh.lazySingleton<_i108.NotificationUseCaseInputPort>(
      () => _i111.FullTicketChargeUseCase(
          get<_i24.FlutterLocalNotificationsPluginAdapter>(),
          get<_i93.SignInUserInfoUseCaseInputPort>()),
      instanceName: 'FullTicketChargeUseCase');
  gh.lazySingleton<_i112.FireBaseAuthAdapterForUseCase>(() =>
      _i112.FireBaseAuthAdapterForUseCaseImpl(
          fireBaseMessageAdapter: get<_i104.FireBaseMessageAdapter>(),
          fireBaseAuthBaseAdapter: get<_i22.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i93.SignInUserInfoUseCaseInputPort>(),
          updateFCMTokenUseCaseInputPort:
              get<_i98.UpdateFCMTokenUseCaseInputPort>()));
  gh.factory<_i113.FireBaseSignInValidUseCase>(() =>
      _i113.FireBaseSignInValidUseCaseImpl(
          fireBaseAuthAdapterForUseCase:
              get<_i112.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i114.MaliciousBallRepository>(() =>
      _i115.MaliciousBallRepositoryImpl(
          get<_i112.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i116.MaliciousBallUseCaseInputPort>(
      () => _i116.MaliciousBallUseCase(get<_i114.MaliciousBallRepository>()));
  gh.lazySingleton<_i117.MapBallMarkerFactory>(() => _i117.MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<_i106.MapMakerDescriptorContainer>()));
  gh.lazySingleton<_i118.PwFindEmailUseCaseInputPort>(() =>
      _i119.PwFindEmailUseCase(
          fireBaseAuthAdapterForUseCase:
              get<_i112.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i120.SnsLoginModuleAdapterFactory>(() =>
      _i120.SnsLoginModuleAdapterFactory(
          get<_i112.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i121.UserPositionForegroundMonitoringUseCaseInputPort>(() =>
      _i122.UserPositionForegroundMonitoringUseCase(
          geoLocationUtilBasicUseCaseInputPort:
              get<_i84.GeoLocationUtilBasicUseCaseInputPort>(),
          fUserRepository: get<_i81.FUserRepository>(),
          fireBaseAuthAdapterForUseCase:
              get<_i112.FireBaseAuthAdapterForUseCase>(),
          updateUserPositionUseCaseInputPort:
              get<_i99.UpdateUserPositionUseCaseInputPort>()));
  gh.lazySingleton<_i123.FBallRepository>(() => _i124.FBallRepositoryImpl(
      fBallRemoteDataSource: get<_i11.FBallRemoteDataSource>(),
      fireBaseAuthBaseAdapter: get<_i112.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i125.FBallValuationRepository>(() =>
      _i126.FBallValuationRepositoryImpl(
          fireBaseAuthBaseAdapter: get<_i112.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i127.FBallValuationUseCaseInputPort>(() =>
      _i127.FBallValuationUseCase(
          fBallValuationRepository: get<_i125.FBallValuationRepository>()));
  gh.lazySingleton<_i128.HitBallUseCaseInputPort>(() =>
      _i128.HitBallUseCase(fBallRepository: get<_i123.FBallRepository>()));
  gh.lazySingleton<_i129.InsertBallUseCaseInputPort>(() =>
      _i129.InsertBallUseCase(fBallRepository: get<_i123.FBallRepository>()));
  gh.lazySingleton<_i130.LogoutUseCaseInputPort>(() => _i131.LogoutUseCase(
      fireBaseAuthAdapterForUseCase: get<_i112.FireBaseAuthAdapterForUseCase>(),
      signInUserInfoUseCaseInputPort:
          get<_i93.SignInUserInfoUseCaseInputPort>(),
      snsLoginModuleAdapterFactory: get<_i120.SnsLoginModuleAdapterFactory>()));
  gh.lazySingleton<_i132.SelectBallUseCaseInputPort>(() =>
      _i132.SelectBallUseCase(fBallRepository: get<_i123.FBallRepository>()));
  gh.lazySingleton<_i133.SingUpUseCaseInputPort>(() => _i134.SingUpUseCase(
      fUserRepository: get<_i81.FUserRepository>(),
      fireBaseAuthAdapterForUseCase: get<_i112.FireBaseAuthAdapterForUseCase>(),
      snsLoginModuleAdapterFactory: get<_i120.SnsLoginModuleAdapterFactory>(),
      fUserInfoJoinReqDto: get<_i19.FUserInfoJoinReqDto>()));
  gh.lazySingleton<_i135.UpdateBallUseCaseInputPort>(() =>
      _i135.UpdateBallUseCase(fBallRepository: get<_i123.FBallRepository>()));
  gh.lazySingleton<_i136.BallImageListUpLoadUseCaseInputPort>(() =>
      _i136.BallImageListUpLoadUseCase(
          fBallRepository: get<_i123.FBallRepository>()));
  gh.lazySingleton<_i137.BallLikeUseCaseInputPort>(() => _i137.BallLikeUseCase(
      fBallValuationRepository: get<_i125.FBallValuationRepository>()));
  gh.lazySingleton<_i138.DeleteBallUseCaseInputPort>(() =>
      _i138.DeleteBallUseCase(fBallRepository: get<_i123.FBallRepository>()));
  return get;
}
