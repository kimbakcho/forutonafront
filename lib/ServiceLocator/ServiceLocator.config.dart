// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../AppBis/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart'
    as _i4;
import '../AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart' as _i10;
import '../AppBis/FBall/Data/Repository/BallAction/QuestBall/QuestBallActionRepositoryImpl.dart'
    as _i120;
import '../AppBis/FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart'
    as _i73;
import '../AppBis/FBall/Data/Repository/FBallRepositoryImpl.dart' as _i126;
import '../AppBis/FBall/Data/Repository/NoInterestBallRepositoryImpl.dart'
    as _i88;
import '../AppBis/FBall/Domain/Repository/BallAction/QuestBall/QuestBallActionRepository.dart'
    as _i119;
import '../AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart'
    as _i72;
import '../AppBis/FBall/Domain/Repository/FBallRepository.dart' as _i125;
import '../AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart'
    as _i87;
import '../AppBis/FBall/Domain/UseCase/BallAction/QuestBall/QuestBallActionUseCaseInputPort.dart'
    as _i121;
import '../AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart'
    as _i138;
import '../AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart'
    as _i140;
import '../AppBis/FBall/Domain/UseCase/FBallSearchBarHistory/FBallSearchBarHistoryUseCaseInputPort.dart'
    as _i79;
import '../AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart'
    as _i130;
import '../AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart'
    as _i131;
import '../AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart'
    as _i106;
import '../AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart'
    as _i134;
import '../AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart'
    as _i137;
import '../AppBis/FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart'
    as _i7;
import '../AppBis/FBallPlayer/Data/Repository/FBallPlayerRepositoryImpl.dart'
    as _i9;
import '../AppBis/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart'
    as _i8;
import '../AppBis/FBallPlayer/Domain/UseCase/FBallPlayerListUp/FBallPlayerListUpUseCaeInputPort.dart'
    as _i74;
import '../AppBis/FBallReply/Data/DataSource/FBallReplyDataSource.dart' as _i11;
import '../AppBis/FBallReply/Data/Repository/FBallReplyRepositoryImpl.dart'
    as _i76;
import '../AppBis/FBallReply/Domain/Repositroy/FBallReplyRepository.dart'
    as _i75;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCase.dart'
    as _i78;
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart'
    as _i77;
import '../AppBis/FBallValuation/Data/Repository/FBallValuationRepositoryImpl.dart'
    as _i128;
import '../AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart'
    as _i127;
import '../AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart'
    as _i139;
import '../AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart'
    as _i129;
import '../AppBis/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart'
    as _i19;
import '../AppBis/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart'
    as _i44;
import '../AppBis/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart'
    as _i49;
import '../AppBis/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart'
    as _i66;
import '../AppBis/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart'
    as _i81;
import '../AppBis/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart'
    as _i46;
import '../AppBis/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart'
    as _i51;
import '../AppBis/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart'
    as _i68;
import '../AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart' as _i80;
import '../AppBis/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart'
    as _i45;
import '../AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart'
    as _i50;
import '../AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart'
    as _i67;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart'
    as _i102;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserUseCaseInputPort/FUserUseCaseInputPort.dart'
    as _i82;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart'
    as _i93;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart'
    as _i92;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart'
    as _i96;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart'
    as _i97;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart'
    as _i98;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserInfoUseCaseInputPort.dart'
    as _i99;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart'
    as _i124;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart'
    as _i123;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart'
    as _i101;
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart'
    as _i100;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart'
    as _i133;
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart'
    as _i132;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart'
    as _i48;
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart'
    as _i47;
import '../AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart'
    as _i52;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart'
    as _i118;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart'
    as _i117;
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart'
    as _i56;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart'
    as _i136;
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart'
    as _i135;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart'
    as _i70;
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart'
    as _i69;
import '../AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart' as _i18;
import '../AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart' as _i55;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart'
    as _i111;
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart'
    as _i21;
import '../AppBis/MaliciousBall/Data/Repositroy/MaliciousBallRepositoryImpl.dart'
    as _i114;
import '../AppBis/MaliciousBall/Domain/Repository/MaliciousBallRepository.dart'
    as _i113;
import '../AppBis/MaliciousBall/Domain/UseCase/MaliciousBallUseCaseInputPort.dart'
    as _i115;
import '../AppBis/MaliciousReply/Data/Repository/MaliciousReplyRepositoryImpl.dart'
    as _i33;
import '../AppBis/MaliciousReply/Domain/Repository/MaliciousReplyRepository.dart'
    as _i32;
import '../AppBis/MaliciousReply/Domain/UseCase/MaliciousReplyUseCaseInputPort.dart'
    as _i34;
import '../AppBis/Notification/Domain/Channel/NotificationChannel.dart' as _i41;
import '../AppBis/Notification/Domain/Channel/NotificationMyFluenceChannel.dart'
    as _i43;
import '../AppBis/Notification/Domain/Channel/NotificationRadarChannel.dart'
    as _i42;
import '../AppBis/Notification/Domain/NotificationUseCase/FullTicketChargeUseCase.dart'
    as _i109;
import '../AppBis/Notification/Domain/NotificationUseCase/NearBallCreateUseCase.dart'
    as _i108;
import '../AppBis/Notification/Domain/NotificationUseCase/NotificationFBallReplyUseCase.dart'
    as _i110;
import '../AppBis/Notification/Domain/NotificationUseCase/NotificationUseCaseInputPort.dart'
    as _i107;
import '../AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart' as _i12;
import '../AppBis/Tag/Data/Repository/TagRepositoryImpl.dart' as _i61;
import '../AppBis/Tag/Domain/Repository/TagRepository.dart' as _i60;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart'
    as _i91;
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart'
    as _i90;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart'
    as _i95;
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart'
    as _i94;
import '../Common/AndroidIntentAdapter/AndroidIntentAdapter.dart' as _i3;
import '../Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart' as _i71;
import '../Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart' as _i20;
import '../Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart' as _i103;
import '../Common/FireBaseMessage/Presentation/FireBaseMessageController.dart'
    as _i104;
import '../Common/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart'
    as _i15;
import '../Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart'
    as _i14;
import '../Common/FireBaseMessage/UseCase/FCMMessageUseCaseInputPort.dart'
    as _i13;
import '../Common/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart'
    as _i17;
import '../Common/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart'
    as _i16;
import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart'
    as _i22;
import '../Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart'
    as _i23;
import '../Common/FluttertoastAdapter/FluttertoastAdapter.dart' as _i24;
import '../Common/Geolocation/Adapter/GeolocatorAdapter.dart' as _i27;
import '../Common/Geolocation/Adapter/LocationAdapter.dart' as _i30;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart'
    as _i84;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart'
    as _i83;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart'
    as _i86;
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart'
    as _i85;
import '../Common/GeoPlaceAdapter/GeoPlaceAdapter.dart' as _i26;
import '../Common/GlobalInitMutex/GlobalInitMutex.dart' as _i28;
import '../Common/GoogleMapSupport/MapBallMarkerFactory.dart' as _i116;
import '../Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart'
    as _i35;
import '../Common/GoogleMapSupport/MapMakerDescriptorContainer.dart' as _i105;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart'
    as _i5;
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart'
    as _i6;
import '../Common/ImageCropUtil/ImageUtilInputPort.dart' as _i29;
import '../Common/MapScreenPosition/MapScreenPositionUseCase.dart' as _i37;
import '../Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart'
    as _i36;
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart'
    as _i58;
import '../Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart'
    as _i112;
import '../Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart'
    as _i53;
import '../Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart' as _i122;
import '../Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart' as _i59;
import '../Components/PhoneAuthComponent/PhoneAuthMode/PhoneAuthModeFactory.dart'
    as _i89;
import '../Components/TagList/RankingTagListMediator.dart' as _i57;
import '../Components/UserInfoCollectionWidget/UserInfoCollectMediator.dart'
    as _i65;
import '../MainPage/MainPageView.dart' as _i31;
import '../ManagerBis/Notice/Data/NoticeRepositoryImpl.dart' as _i39;
import '../ManagerBis/Notice/Domain/NoticeRepository.dart' as _i38;
import '../ManagerBis/Notice/Domain/NoticeUseCaseInputPort.dart' as _i40;
import '../ManagerBis/TermsConditions/Data/Repository/TermsConditionsRepositoryImpl.dart'
    as _i63;
import '../ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart'
    as _i62;
import '../ManagerBis/TermsConditions/Domain/UseCase/TermsConditionsUseCaseInputPort.dart'
    as _i64;
import '../Page/GCodePage/Component/UserProfile/ProfileModeUseCase/ProfileModeUseCaseInputPort.dart'
    as _i54;
import '../Page/GCodePage/G001/G001MainPage.dart'
    as _i25; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<_i3.AndroidIntentAdapter>(
      () => _i3.AndroidIntentAdapterImpl());
  gh.lazySingleton<_i4.BallSearchHistoryLocalDataSource>(
      () => _i4.BallSearchHistoryLocalDataSourceImpl());
  gh.lazySingleton<_i5.BaseGoogleSurveyInputPort>(
      () => _i6.BaseGoogleSurveyUseCase(),
      instanceName: 'BaseGoogleSurveyUseCase');
  gh.lazySingleton<_i7.FBallPlayerRemoteDataSource>(
      () => _i7.FBallPlayerRemoteDataSourceImpl());
  gh.lazySingleton<_i8.FBallPlayerRepository>(() =>
      _i9.FBallPlayerRepositoryImpl(
          fBallPlayerRemoteDataSource: get<_i7.FBallPlayerRemoteDataSource>()));
  gh.lazySingleton<_i10.FBallRemoteDataSource>(
      () => _i10.FBallRemoteSourceImpl());
  gh.lazySingleton<_i11.FBallReplyDataSource>(
      () => _i11.FBallReplyDataSourceImpl());
  gh.lazySingleton<_i12.FBallTagRemoteDataSource>(
      () => _i12.FBallTagRemoteDataSourceImpl());
  gh.lazySingleton<_i13.FCMMessageUseCaseInputPort>(
      () => _i14.BaseMessageUseCase(),
      instanceName: 'BaseMessageUseCase');
  gh.lazySingleton<_i13.FCMMessageUseCaseInputPort>(
      () => _i15.BackGroundMessageUseCase(),
      instanceName: 'BackGroundMessageUseCase');
  gh.lazySingleton<_i13.FCMMessageUseCaseInputPort>(
      () => _i16.ResumeMessageUseCase(),
      instanceName: 'ResumeMessageUseCase');
  gh.lazySingleton<_i13.FCMMessageUseCaseInputPort>(
      () => _i17.LaunchMessageUseCase(),
      instanceName: 'LaunchMessageUseCase');
  gh.lazySingleton<_i18.FUserInfoJoinReqDto>(() => _i18.FUserInfoJoinReqDto());
  gh.lazySingleton<_i19.FUserRemoteDataSource>(
      () => _i19.FUserRemoteDataSourceImpl());
  gh.lazySingleton<_i20.FileDownLoaderUseCaseInputPort>(
      () => _i20.FileDownLoaderUseCase());
  gh.lazySingleton<_i21.FireBaseAuthBaseAdapter>(
      () => _i21.FireBaseAuthBaseAdapterImpl());
  gh.lazySingleton<_i22.FlutterImageCompressAdapter>(
      () => _i22.FlutterImageCompressAdapterImpl());
  gh.lazySingleton<_i23.FlutterLocalNotificationsPluginAdapter>(
      () => _i23.FlutterLocalNotificationsPluginAdapterImpl());
  gh.lazySingleton<_i24.FluttertoastAdapter>(() => _i24.FluttertoastAdapter());
  gh.lazySingleton<_i25.G001MainPageViewModelController>(
      () => _i25.G001MainPageViewModelController());
  gh.factory<_i26.GeoPlaceAdapter>(() => _i26.GooglePlaceAdapter());
  gh.lazySingleton<_i27.GeolocatorAdapter>(() => _i27.GeolocatorAdapterImpl());
  gh.lazySingleton<_i28.GlobalInitMutex>(() => _i28.GlobalInitMutex());
  gh.lazySingleton<_i29.ImageUtilInputPort>(() => _i29.ImagePngResizeUtil(),
      instanceName: 'ImagePngResizeUtil');
  gh.lazySingleton<_i29.ImageUtilInputPort>(() => _i29.ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
  gh.lazySingleton<_i29.ImageUtilInputPort>(() => _i29.ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.lazySingleton<_i30.LocationAdapter>(() => _i30.LocationAdapterImpl());
  gh.lazySingleton<_i31.MainPageViewModelController>(
      () => _i31.MainPageViewModelController());
  gh.lazySingleton<_i32.MaliciousReplyRepository>(() =>
      _i33.MaliciousReplyRepositoryImpl(get<_i21.FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<_i34.MaliciousReplyUseCaseInputPort>(
      () => _i34.MaliciousReplyUseCase(get<_i32.MaliciousReplyRepository>()));
  gh.lazySingleton<_i35.MapBitmapDescriptorUseCaseInputPort>(() =>
      _i35.MapBitmapDescriptorUseCase(
          imagePngResizeUtil:
              get<_i29.ImageUtilInputPort>(instanceName: 'ImagePngResizeUtil'),
          imageBorderAvatarUtil: get<_i29.ImageUtilInputPort>(
              instanceName: 'ImageBorderAvatarUtil'),
          fileDownLoaderUseCaseInputPort:
              get<_i20.FileDownLoaderUseCaseInputPort>()));
  gh.lazySingleton<_i36.MapScreenPositionUseCaseInputPort>(
      () => _i37.MapScreenPositionUseCase());
  gh.factory<_i38.NoticeRepository>(() => _i39.NoticeRepositoryImpl());
  gh.factory<_i40.NoticeUseCaseInputPort>(
      () => _i40.NoticeUseCase(get<_i38.NoticeRepository>()));
  gh.lazySingleton<_i41.NotificationChannel>(
      () => _i42.NotificationRadarChannel(),
      instanceName: 'NotificationRadarChannel');
  gh.lazySingleton<_i41.NotificationChannel>(
      () => _i43.NotificationMyFluenceChannel(),
      instanceName: 'NotificationMyFluenceChannel');
  gh.lazySingleton<_i44.PersonaSettingNoticeRemoteDataSource>(
      () => _i44.PersonaSettingNoticeRemoteDataSourceImpl());
  gh.lazySingleton<_i45.PersonaSettingNoticeRepository>(() =>
      _i46.PersonaSettingNoticeRepositoryImpl(
          personaSettingNoticeRemoteDataSource:
              get<_i44.PersonaSettingNoticeRemoteDataSource>()));
  gh.lazySingleton<_i47.PersonaSettingNoticeUseCaseInputPort>(() =>
      _i48.PersonaSettingNoticeUseCase(
          personaSettingNoticeRepository:
              get<_i45.PersonaSettingNoticeRepository>()));
  gh.lazySingleton<_i49.PhoneAuthRemoteSource>(
      () => _i49.PhoneAuthRemoteSourceImpl());
  gh.lazySingleton<_i50.PhoneAuthRepository>(() => _i51.PhoneAuthRepositoryImpl(
      phoneAuthRemoteSource: get<_i49.PhoneAuthRemoteSource>()));
  gh.lazySingleton<_i52.PhoneAuthUseCaseInputPort>(() => _i52.PhoneAuthUseCase(
      phoneAuthRepository: get<_i50.PhoneAuthRepository>()));
  gh.factory<_i53.PhoneFindValidUseCase>(() => _i53.PhoneFindValidUseCaseImpl(
      phoneAuthRepository: get<_i50.PhoneAuthRepository>()));
  gh.lazySingleton<_i54.ProfileModeUseCaseFactory>(
      () => _i54.ProfileModeUseCaseFactory());
  gh.lazySingleton<_i55.PwChangeFromPhoneAuthReqDto>(
      () => _i55.PwChangeFromPhoneAuthReqDto());
  gh.lazySingleton<_i56.PwFindPhoneUseCaseInputPort>(() =>
      _i56.PwFindPhoneUseCase(
          phoneAuthRepository: get<_i50.PhoneAuthRepository>()));
  gh.factory<_i57.RankingTagListMediator>(
      () => _i57.RankingTagListMediatorImpl());
  gh.lazySingleton<_i58.SharedPreferencesAdapter>(
      () => _i58.SharedPreferencesAdapterImpl());
  gh.factory<_i59.SwipeGestureRecognizerController>(
      () => _i59.SwipeGestureRecognizerController());
  gh.lazySingleton<_i60.TagRepository>(() => _i61.TagRepositoryImpl(
      fBallTagRemoteDataSource: get<_i12.FBallTagRemoteDataSource>()));
  gh.factory<_i62.TermsConditionsRepository>(
      () => _i63.TermsConditionsRepositoryImpl());
  gh.factory<_i64.TermsConditionsUseCaseInputPort>(() =>
      _i64.TermsConditionsUseCase(
          termsConditionsRepository: get<_i62.TermsConditionsRepository>()));
  gh.factory<_i65.UserInfoCollectMediator>(
      () => _i65.UserInfoCollectMediatorImpl());
  gh.lazySingleton<_i66.UserPolicyRemoteDataSource>(
      () => _i66.UserPolicyRemoteDataSourceImpl());
  gh.lazySingleton<_i67.UserPolicyRepository>(() =>
      _i68.UserPolicyRepositoryImpl(
          userPolicyRemoteDataSource: get<_i66.UserPolicyRemoteDataSource>()));
  gh.lazySingleton<_i69.UserPolicyUseCaseInputPort>(() =>
      _i70.UserPolicyUseCase(
          userPolicyRepository: get<_i67.UserPolicyRepository>()));
  gh.lazySingleton<_i71.AvatarImageMakerUseCaseInputPort>(() =>
      _i71.AvatarImageMakerUseCase(
          fileDownLoaderUseCaseInputPort:
              get<_i20.FileDownLoaderUseCaseInputPort>(),
          imageUtilInputPort: get<_i29.ImageUtilInputPort>()));
  gh.lazySingleton<_i72.BallSearchBarHistoryRepository>(() =>
      _i73.BallSearchBarHistoryRepositoryImpl(
          localDataSource: get<_i4.BallSearchHistoryLocalDataSource>()));
  gh.lazySingleton<_i74.FBallPlayerListUpInputPort>(() =>
      _i74.FBallPlayerListUpUseCae(
          fBallPlayerRepository: get<_i8.FBallPlayerRepository>()));
  gh.lazySingleton<_i75.FBallReplyRepository>(() =>
      _i76.FBallReplyRepositoryImpl(
          fBallReplyDataSource: get<_i11.FBallReplyDataSource>(),
          fireBaseAuthBaseAdapter: get<_i21.FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<_i77.FBallReplyUseCaseInputPort>(() =>
      _i78.FBallReplyUseCase(
          fBallReplyRepository: get<_i75.FBallReplyRepository>()));
  gh.lazySingleton<_i79.FBallSearchBarHistoryUseCaseInputPort>(() =>
      _i79.FBallSearchBarHistoryUseCase(
          ballSearchBarHistoryRepository:
              get<_i72.BallSearchBarHistoryRepository>()));
  gh.lazySingleton<_i80.FUserRepository>(() => _i81.FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: get<_i21.FireBaseAuthBaseAdapter>(),
      fUserRemoteDataSource: get<_i19.FUserRemoteDataSource>()));
  gh.lazySingleton<_i82.FUserUseCaseInputPort>(
      () => _i82.FUserUseCase(get<_i80.FUserRepository>()));
  gh.lazySingleton<_i83.GeoLocationUtilBasicUseCaseInputPort>(() =>
      _i84.GeoLocationUtilBasicUseCase(
          geolocatorAdapter: get<_i27.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i58.SharedPreferencesAdapter>()));
  gh.lazySingleton<_i85.GeoLocationUtilForeGroundUseCaseInputPort>(() =>
      _i86.GeoLocationUtilForeGroundUseCase(
          basicUseCaseInputPort:
              get<_i83.GeoLocationUtilBasicUseCaseInputPort>(),
          geolocatorAdapter: get<_i27.GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<_i58.SharedPreferencesAdapter>(),
          locationAdapter: get<_i30.LocationAdapter>()));
  gh.lazySingleton<_i87.NoInterestBallRepository>(() =>
      _i88.NoInterestBallRepositoryImpl(
          sharedPreferencesAdapter: get<_i58.SharedPreferencesAdapter>()));
  gh.factory<_i89.PhoneAuthModeFactory>(() => _i89.PhoneAuthModeFactory(
      get<_i52.PhoneAuthUseCaseInputPort>(),
      get<_i53.PhoneFindValidUseCase>()));
  gh.lazySingleton<
          _i90.RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      () => _i91.RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: get<_i60.TagRepository>()));
  gh.lazySingleton<_i92.SignInUserInfoUseCaseInputPort>(() =>
      _i93.SignInUserInfoUseCase(fUserRepository: get<_i80.FUserRepository>()));
  gh.lazySingleton<_i94.TagFromBallUuidUseCaseInputPort>(() =>
      _i95.TagFromBallUuidUseCase(tagRepository: get<_i60.TagRepository>()));
  gh.lazySingleton<_i96.UpdateAccountUserInfoUseCaseInputPort>(() =>
      _i96.UpdateAccountUserInfoUseCase(
          fUserRepository: get<_i80.FUserRepository>()));
  gh.lazySingleton<_i97.UpdateFCMTokenUseCaseInputPort>(() =>
      _i97.UpdateFCMTokenUseCase(fUserRepository: get<_i80.FUserRepository>()));
  gh.lazySingleton<_i98.UpdateUserPositionUseCaseInputPort>(() =>
      _i98.UpdateUserPositionUseCase(
          fUserRepository: get<_i80.FUserRepository>()));
  gh.lazySingleton<_i99.UserInfoUseCaseInputPort>(
      () => _i99.UserInfoUseCase(get<_i80.FUserRepository>()));
  gh.lazySingleton<_i100.UserProfileImageUploadUseCaseInputPort>(() =>
      _i101.UserProfileImageUploadUseCase(
          flutterImageCompressAdapter: get<_i22.FlutterImageCompressAdapter>(),
          fUserRepository: get<_i80.FUserRepository>()));
  gh.lazySingleton<_i102.FUserPwChangeUseCaseInputPort>(() =>
      _i102.FUserPwChangeUseCase(fUserRepository: get<_i80.FUserRepository>()));
  gh.lazySingleton<_i103.FireBaseMessageAdapter>(() =>
      _i103.FireBaseMessageAdapterImpl(
          signInUserInfoUseCaseInputPort:
              get<_i92.SignInUserInfoUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i21.FireBaseAuthBaseAdapter>(),
          updateFCMTokenUseCaseInputPort:
              get<_i97.UpdateFCMTokenUseCaseInputPort>()));
  gh.lazySingleton<_i104.FireBaseMessageController>(() =>
      _i104.FireBaseMessageController(
          fireBaseMessageAdapter: get<_i103.FireBaseMessageAdapter>()));
  gh.lazySingleton<_i105.MapMakerDescriptorContainer>(() =>
      _i105.MapMakerDescriptorContainerImpl(
          mapBitmapDescriptorUseCaseInputPort:
              get<_i35.MapBitmapDescriptorUseCaseInputPort>(),
          fireBaseAuthBaseAdapter: get<_i21.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i92.SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<_i106.NoInterestBallUseCaseInputPort>(() =>
      _i106.NoInterestBallUseCase(
          noInterestBallRepository: get<_i87.NoInterestBallRepository>(),
          signInUserInfoUseCaseInputPort:
              get<_i92.SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<_i107.NotificationUseCaseInputPort>(
      () => _i108.NearBallCreateUseCase(
          get<_i23.FlutterLocalNotificationsPluginAdapter>(),
          get<_i92.SignInUserInfoUseCaseInputPort>()),
      instanceName: 'NearBallCreateUseCase');
  gh.lazySingleton<_i107.NotificationUseCaseInputPort>(
      () => _i109.FullTicketChargeUseCase(
          get<_i23.FlutterLocalNotificationsPluginAdapter>(),
          get<_i92.SignInUserInfoUseCaseInputPort>()),
      instanceName: 'FullTicketChargeUseCase');
  gh.lazySingleton<_i107.NotificationUseCaseInputPort>(
      () => _i110.NotificationFBallReplyUseCase(
          get<_i23.FlutterLocalNotificationsPluginAdapter>(),
          get<_i92.SignInUserInfoUseCaseInputPort>()),
      instanceName: 'NotificationFBallReplyUseCase');
  gh.lazySingleton<_i111.FireBaseAuthAdapterForUseCase>(() =>
      _i111.FireBaseAuthAdapterForUseCaseImpl(
          fireBaseMessageAdapter: get<_i103.FireBaseMessageAdapter>(),
          fireBaseAuthBaseAdapter: get<_i21.FireBaseAuthBaseAdapter>(),
          signInUserInfoUseCaseInputPort:
              get<_i92.SignInUserInfoUseCaseInputPort>(),
          updateFCMTokenUseCaseInputPort:
              get<_i97.UpdateFCMTokenUseCaseInputPort>()));
  gh.factory<_i112.FireBaseSignInValidUseCase>(() =>
      _i112.FireBaseSignInValidUseCaseImpl(
          fireBaseAuthAdapterForUseCase:
              get<_i111.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i113.MaliciousBallRepository>(() =>
      _i114.MaliciousBallRepositoryImpl(
          get<_i111.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i115.MaliciousBallUseCaseInputPort>(
      () => _i115.MaliciousBallUseCase(get<_i113.MaliciousBallRepository>()));
  gh.lazySingleton<_i116.MapBallMarkerFactory>(() => _i116.MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<_i105.MapMakerDescriptorContainer>()));
  gh.lazySingleton<_i117.PwFindEmailUseCaseInputPort>(() =>
      _i118.PwFindEmailUseCase(
          fireBaseAuthAdapterForUseCase:
              get<_i111.FireBaseAuthAdapterForUseCase>()));
  gh.factory<_i119.QuestBallActionRepository>(() =>
      _i120.QuestBallActionRepositoryImpl(
          fireBaseAuthBaseAdapter: get<_i111.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i121.QuestBallActionUseCaseInputPort>(() =>
      _i121.QuestBallActionUseCase(
          questBallActionRepository: get<_i119.QuestBallActionRepository>(),
          signInUserInfoUseCaseInputPort:
              get<_i92.SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<_i122.SnsLoginModuleAdapterFactory>(() =>
      _i122.SnsLoginModuleAdapterFactory(
          get<_i111.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i123.UserPositionForegroundMonitoringUseCaseInputPort>(() =>
      _i124.UserPositionForegroundMonitoringUseCase(
          geoLocationUtilBasicUseCaseInputPort:
              get<_i83.GeoLocationUtilBasicUseCaseInputPort>(),
          fUserRepository: get<_i80.FUserRepository>(),
          fireBaseAuthAdapterForUseCase:
              get<_i111.FireBaseAuthAdapterForUseCase>(),
          updateUserPositionUseCaseInputPort:
              get<_i98.UpdateUserPositionUseCaseInputPort>()));
  gh.lazySingleton<_i125.FBallRepository>(() => _i126.FBallRepositoryImpl(
      fBallRemoteDataSource: get<_i10.FBallRemoteDataSource>(),
      fireBaseAuthBaseAdapter: get<_i111.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i127.FBallValuationRepository>(() =>
      _i128.FBallValuationRepositoryImpl(
          fireBaseAuthBaseAdapter: get<_i111.FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<_i129.FBallValuationUseCaseInputPort>(() =>
      _i129.FBallValuationUseCase(
          fBallValuationRepository: get<_i127.FBallValuationRepository>()));
  gh.lazySingleton<_i130.HitBallUseCaseInputPort>(() =>
      _i130.HitBallUseCase(fBallRepository: get<_i125.FBallRepository>()));
  gh.lazySingleton<_i131.InsertBallUseCaseInputPort>(() =>
      _i131.InsertBallUseCase(fBallRepository: get<_i125.FBallRepository>()));
  gh.lazySingleton<_i132.LogoutUseCaseInputPort>(() => _i133.LogoutUseCase(
      fireBaseAuthAdapterForUseCase: get<_i111.FireBaseAuthAdapterForUseCase>(),
      signInUserInfoUseCaseInputPort:
          get<_i92.SignInUserInfoUseCaseInputPort>(),
      snsLoginModuleAdapterFactory: get<_i122.SnsLoginModuleAdapterFactory>()));
  gh.lazySingleton<_i134.SelectBallUseCaseInputPort>(() =>
      _i134.SelectBallUseCase(fBallRepository: get<_i125.FBallRepository>()));
  gh.lazySingleton<_i135.SingUpUseCaseInputPort>(() => _i136.SingUpUseCase(
      fUserRepository: get<_i80.FUserRepository>(),
      fireBaseAuthAdapterForUseCase: get<_i111.FireBaseAuthAdapterForUseCase>(),
      snsLoginModuleAdapterFactory: get<_i122.SnsLoginModuleAdapterFactory>(),
      fUserInfoJoinReqDto: get<_i18.FUserInfoJoinReqDto>()));
  gh.lazySingleton<_i137.UpdateBallUseCaseInputPort>(() =>
      _i137.UpdateBallUseCase(fBallRepository: get<_i125.FBallRepository>()));
  gh.lazySingleton<_i138.BallImageListUpLoadUseCaseInputPort>(() =>
      _i138.BallImageListUpLoadUseCase(
          fBallRepository: get<_i125.FBallRepository>()));
  gh.lazySingleton<_i139.BallLikeUseCaseInputPort>(() => _i139.BallLikeUseCase(
      fBallValuationRepository: get<_i127.FBallValuationRepository>()));
  gh.lazySingleton<_i140.DeleteBallUseCaseInputPort>(() =>
      _i140.DeleteBallUseCase(fBallRepository: get<_i125.FBallRepository>()));
  return get;
}
