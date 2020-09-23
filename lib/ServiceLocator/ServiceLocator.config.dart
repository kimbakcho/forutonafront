// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import '../Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart';
import '../FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart';
import '../FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart';
import '../FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import '../FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import '../FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart';
import '../FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';
import '../FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import '../FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart';
import '../FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import '../FBallPlayer/Domain/UseCase/FBallPlayerListUp/FBallPlayerListUpUseCaeInputPort.dart';
import '../FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart';
import '../FBallPlayer/Domain/Repository/FBallPlayerRepository.dart';
import '../FBallPlayer/Data/Repository/FBallPlayerRepositoryImpl.dart';
import '../FBall/Data/DataStore/FBallRemoteDataSource.dart';
import '../FBallReply/Data/DataSource/FBallReplyDataSource.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/Service/FBallReplyFCMServiceUseCase.dart';
import '../FBallReply/Domain/Repositroy/FBallReplyRepository.dart';
import '../FBallReply/Data/Repository/FBallReplyRepositoryImpl.dart';
import '../FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCase.dart';
import '../FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import '../FBall/Domain/Repository/FBallRepository.dart';
import '../FBall/Data/Repository/FBallRepositoryImpl.dart';
import '../FBall/Domain/UseCase/FBallSearchBarHistory/FBallSearchBarHistoryUseCaseInputPort.dart';
import '../Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import '../FBallValuation/Data/DataStore/FBallValuationRemoteDataSource.dart';
import '../FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import '../FBallValuation/Data/Repository/FBallValuationRepositoryImpl.dart';
import '../ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart';
import '../ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import '../ForutonaUser/Domain/Repository/FUserRepository.dart';
import '../ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import '../ForutonaUser/Domain/SnsLoginMoudleAdapter/FaceBookLoginAdapterImpl.dart';
import '../Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import '../ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import '../ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import '../FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import '../FireBaseMessage/Presentation/FireBaseMessageController.dart';
import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import '../Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import '../ForutonaUser/Domain/SnsLoginMoudleAdapter/ForutonaLoginAdapterImpl.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import '../Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import '../Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import '../Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import '../HCodePage/H001/H001Manager.dart';
import '../FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/ID001/ID001PageMoveAction.dart';
import '../Common/ImageCropUtil/ImageUtilInputPort.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import '../FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/Service/IssueFBalIInsertFCMServiceUseCase.dart';
import '../ForutonaUser/Domain/SnsLoginMoudleAdapter/KakaoLoginAdapterImpl.dart';
import '../FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart';
import '../Common/Geolocation/Adapter/LocationAdapter.dart';
import '../ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import '../ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart';
import '../ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import '../Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import '../Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart';
import '../Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import '../Common/MapScreenPosition/MapScreenPositionUseCase.dart';
import '../Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import '../ForutonaUser/Domain/SnsLoginMoudleAdapter/NaverLoginAdapterImpl.dart';
import '../Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import '../Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCase.dart';
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart';
import '../ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import '../ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import '../ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart';
import '../ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart';
import '../ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import '../ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
import '../ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import '../ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart';
import '../ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import '../Preference.dart';
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart';
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCase.dart';
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCae.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCaeInputPort.dart';
import '../Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart';
import '../Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import '../FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart';
import '../FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import '../ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import '../ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import '../ForutonaUser/Domain/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import '../Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import '../Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import '../Tag/Domain/Repository/TagRepository.dart';
import '../Tag/Data/Repository/TagRepositoryImpl.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart';
import '../FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart';
import '../ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import '../ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import '../ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart';
import '../ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart';
import '../ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AndroidIntentAdapter>(() => AndroidIntentAdapterImpl());
  gh.factory<BallSearchHistoryLocalDataSource>(
      () => BallSearchHistoryLocalDataSourceImpl());
  gh.factory<BaseGoogleSurveyInputPort>(() => GoogleSurveyErrorReportUseCase(),
      instanceName: 'GoogleSurveyErrorReportUseCase');
  gh.factory<BaseGoogleSurveyInputPort>(() => BaseGoogleSurveyUseCase(),
      instanceName: 'BaseGoogleSurveyUseCase');
  gh.factory<BaseGoogleSurveyInputPort>(
      () => GoogleProposalOnServiceSurveyUseCase(),
      instanceName: 'GoogleProposalOnServiceSurveyUseCase');
  gh.factory<BaseMessageUseCaseInputPort>(() => BaseMessageUseCase(),
      instanceName: 'BaseMessageUseCase');
  gh.factory<BaseMessageUseCaseInputPort>(
      () => BackGroundMessageUseCase(
          baseMessageUseCaseInputPort: get<BaseMessageUseCaseInputPort>()),
      instanceName: 'BackGroundMessageUseCase');
  gh.factory<BaseMessageUseCaseInputPort>(() => ResumeMessageUseCase(),
      instanceName: 'ResumeMessageUseCase');
  gh.factory<BaseMessageUseCaseInputPort>(() => LaunchMessageUseCase(),
      instanceName: 'LaunchMessageUseCase');
  gh.factory<BaseOpenTalkInputPort>(() => InquireAboutAnythingUseCase());
  gh.factory<FBallPlayerRemoteDataSource>(
      () => FBallPlayerRemoteDataSourceImpl());
  gh.factory<FBallPlayerRepository>(() => FBallPlayerRepositoryImpl(
      fBallPlayerRemoteDataSource: get<FBallPlayerRemoteDataSource>()));
  gh.factory<FBallRemoteDataSource>(() => FBallRemoteSourceImpl());
  gh.factory<FBallReplyDataSource>(() => FBallReplyDataSourceImpl());
  gh.factory<FBallTagRemoteDataSource>(() => FBallTagRemoteDataSourceImpl());
  gh.factory<FBallValuationRemoteDataSource>(
      () => FBallValuationRemoteDataSourceImpl());
  gh.factory<FUserRemoteDataSource>(() => FUserRemoteDataSourceImpl());
  gh.factory<FileDownLoaderUseCaseInputPort>(() => FileDownLoaderUseCase());
  gh.factory<FireBaseAuthBaseAdapter>(() => FireBaseAuthBaseAdapterImpl());
  gh.factory<FlutterImageCompressAdapter>(
      () => FlutterImageCompressAdapterImpl());
  gh.factory<FlutterLocalNotificationsPluginAdapter>(
      () => FlutterLocalNotificationsPluginAdapterImpl());
  gh.factory<GeolocatorAdapter>(() => GeolocatorAdapterImpl());
  gh.factory<H001Manager>(() => H001Manager());
  gh.factory<ImageUtilInputPort>(() => ImagePngResizeUtil(),
      instanceName: 'ImagePngResizeUtil');
  gh.factory<ImageUtilInputPort>(() => ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
  gh.factory<ImageUtilInputPort>(() => ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.factory<LocationAdapter>(() => LocationAdapterImpl());
  gh.factory<MapBitmapDescriptorUseCaseInputPort>(() =>
      MapBitmapDescriptorUseCase(
        imagePngResizeUtil: get<ImageUtilInputPort>(),
        imageBorderAvatarUtil: get<ImageUtilInputPort>(),
        fileDownLoaderUseCaseInputPort: get<FileDownLoaderUseCaseInputPort>(),
      ));
  gh.factory<MapScreenPositionUseCaseInputPort>(
      () => MapScreenPositionUseCase());
  gh.factory<NotiSelectActionBaseInputPort>(() => PageMoveActionUseCase());
  gh.factory<NotificationChannelBaseInputPort>(() => CommentChannelUseCase(),
      instanceName: 'CommentChannelUseCase');
  gh.factory<NotificationChannelBaseInputPort>(() => RadarBasicChannelUseCae(),
      instanceName: 'RadarBasicChannelUseCae');
  gh.factoryParam<NotificationChannelBaseInputPort, String, dynamic>(
      (name, _) => NotificationChannelBaseInputPort.serviceChannelName(name));
  gh.factory<PersonaSettingNoticeRemoteDataSource>(
      () => PersonaSettingNoticeRemoteDataSourceImpl());
  gh.factory<PersonaSettingNoticeRepository>(() =>
      PersonaSettingNoticeRepositoryImpl(
          personaSettingNoticeRemoteDataSource:
              get<PersonaSettingNoticeRemoteDataSource>()));
  gh.factory<PersonaSettingNoticeUseCaseInputPort>(() =>
      PersonaSettingNoticeUseCase(
          personaSettingNoticeRepository:
              get<PersonaSettingNoticeRepository>()));
  gh.factory<PhoneAuthRemoteSource>(() => PhoneAuthRemoteSourceImpl());
  gh.factory<PhoneAuthRepository>(() => PhoneAuthRepositoryImpl(
      phoneAuthRemoteSource: get<PhoneAuthRemoteSource>()));
  gh.factory<PhoneAuthUseCaseInputPort>(
      () => PhoneAuthUseCase(phoneAuthRepository: get<PhoneAuthRepository>()));
  gh.factory<Preference>(() => Preference());
  gh.factory<PwFindPhoneUseCaseInputPort>(() =>
      PwFindPhoneUseCase(phoneAuthRepository: get<PhoneAuthRepository>()));
  gh.factory<RadarBasicChannelUseCaeInputPort>(() =>
      IssueFBalIInsertFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter:
              get<FlutterLocalNotificationsPluginAdapter>()));
  gh.factory<SharedPreferencesAdapter>(() => SharedPreferencesAdapterImpl());
  gh.factory<SnsLoginModuleAdapter>(() => NaverLoginAdapterImpl(),
      instanceName: 'NaverLoginAdapterImpl');
  gh.factory<SnsLoginModuleAdapter>(() => KakaoLoginAdapterImpl(),
      instanceName: 'KakaoLoginAdapterImpl');
  gh.factory<SnsLoginModuleAdapter>(() => ForutonaLoginAdapterImpl(),
      instanceName: 'ForutonaLoginAdapterImpl');
  gh.factory<SnsLoginModuleAdapter>(() => FaceBookLoginAdapterImpl(),
      instanceName: 'FaceBookLoginAdapterImpl');
  gh.factory<TagRepository>(() => TagRepositoryImpl(
      fBallTagRemoteDataSource: get<FBallTagRemoteDataSource>()));
  gh.factory<UserPolicyRemoteDataSource>(
      () => UserPolicyRemoteDataSourceImpl());
  gh.factory<UserPolicyRepository>(() => UserPolicyRepositoryImpl(
      userPolicyRemoteDataSource: get<UserPolicyRemoteDataSource>()));
  gh.factory<UserPolicyUseCaseInputPort>(() =>
      UserPolicyUseCase(userPolicyRepository: get<UserPolicyRepository>()));
  gh.factory<AvatarImageMakerUseCaseInputPort>(() => AvatarImageMakerUseCase(
      fileDownLoaderUseCaseInputPort: get<FileDownLoaderUseCaseInputPort>(),
      imageUtilInputPort: get<ImageUtilInputPort>()));
  gh.factory<BallSearchBarHistoryRepository>(() =>
      BallSearchBarHistoryRepositoryImpl(
          localDataSource: get<BallSearchHistoryLocalDataSource>()));
  gh.factory<FBallPlayerListUpInputPort>(() => FBallPlayerListUpUseCae(
      fBallPlayerRepository: get<FBallPlayerRepository>()));
  gh.factory<FBallReplyRepository>(() => FBallReplyRepositoryImpl(
      fBallReplyDataSource: get<FBallReplyDataSource>(),
      fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>()));
  gh.factory<FBallReplyUseCaseInputPort>(() =>
      FBallReplyUseCase(fBallReplyRepository: get<FBallReplyRepository>()));
  gh.factory<FBallSearchBarHistoryUseCaseInputPort>(() =>
      FBallSearchBarHistoryUseCase(
          ballSearchBarHistoryRepository:
              get<BallSearchBarHistoryRepository>()));
  gh.factory<FUserRepository>(() => FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
      fUserRemoteDataSource: get<FUserRemoteDataSource>()));
  gh.factory<GeoLocationUtilBasicUseCaseInputPort>(
      () => GeoLocationUtilBasicUseCase(
            geolocatorAdapter: get<GeolocatorAdapter>(),
            sharedPreferencesAdapter: get<SharedPreferencesAdapter>(),
            preference: get<Preference>(),
          ));
  gh.factory<GeoLocationUtilForeGroundUseCaseInputPort>(
      () => GeoLocationUtilForeGroundUseCase(
            basicUseCaseInputPort: get<GeoLocationUtilBasicUseCaseInputPort>(),
            geolocatorAdapter: get<GeolocatorAdapter>(),
            sharedPreferencesAdapter: get<SharedPreferencesAdapter>(),
            locationAdapter: get<LocationAdapter>(),
          ));
  gh.factory<RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      () => RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: get<TagRepository>()));
  gh.factory<SignInUserInfoUseCaseInputPort>(
      () => SignInUserInfoUseCase(fUserRepository: get<FUserRepository>()));
  gh.factory<TagFromBallUuidUseCaseInputPort>(
      () => TagFromBallUuidUseCase(tagRepository: get<TagRepository>()));
  gh.factory<UpdateAccountUserInfoUseCaseInputPort>(() =>
      UpdateAccountUserInfoUseCase(fUserRepository: get<FUserRepository>()));
  gh.factory<UpdateFCMTokenUseCaseInputPort>(
      () => UpdateFCMTokenUseCase(fUserRepository: get<FUserRepository>()));
  gh.factory<UpdateUserPositionUseCaseInputPort>(
      () => UpdateUserPositionUseCase(fUserRepository: get<FUserRepository>()));
  gh.factory<UserProfileImageUploadUseCaseInputPort>(() =>
      UserProfileImageUploadUseCase(
          flutterImageCompressAdapter: get<FlutterImageCompressAdapter>(),
          fUserRepository: get<FUserRepository>()));
  gh.factory<CommentChannelBaseServiceUseCaseInputPort>(
      () => FBallReplyFCMServiceUseCase(
            flutterLocalNotificationsPluginAdapter:
                get<FlutterLocalNotificationsPluginAdapter>(),
            avatarImageMakerUseCaseInputPort:
                get<AvatarImageMakerUseCaseInputPort>(),
            signInUserInfoUseCaseInputPort:
                get<SignInUserInfoUseCaseInputPort>(),
          ),
      instanceName: 'FBallReplyFCMServiceUseCase');
  gh.factory<FUserPwChangeUseCaseInputPort>(
      () => FUserPwChangeUseCase(fUserRepository: get<FUserRepository>()));
  gh.factory<FireBaseMessageAdapter>(() => FireBaseMessageAdapterImpl(
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
        fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
        updateFCMTokenUseCaseInputPort: get<UpdateFCMTokenUseCaseInputPort>(),
      ));
  gh.factory<FireBaseMessageController>(() => FireBaseMessageController(
        fireBaseMessageAdapter: get<FireBaseMessageAdapter>(),
        launchMessageUseCase: get<BaseMessageUseCaseInputPort>(),
        baseMessageUseCase: get<BaseMessageUseCaseInputPort>(),
        resumeMessageUseCase: get<BaseMessageUseCaseInputPort>(),
      ));
  gh.factory<MapMakerDescriptorContainer>(() => MapMakerDescriptorContainerImpl(
        mapBitmapDescriptorUseCaseInputPort:
            get<MapBitmapDescriptorUseCaseInputPort>(),
        fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
        preference: get<Preference>(),
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
      ));
  gh.factory<FireBaseAuthAdapterForUseCase>(() =>
      FireBaseAuthAdapterForUseCaseImpl(
        fireBaseMessageAdapter: get<FireBaseMessageAdapter>(),
        fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
        updateFCMTokenUseCaseInputPort: get<UpdateFCMTokenUseCaseInputPort>(),
      ));
  gh.factory<LogoutUseCaseInputPort>(() => LogoutUseCase(
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
      signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>()));
  gh.factory<MapBallMarkerFactory>(() => MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<MapMakerDescriptorContainer>()));
  gh.factory<PwFindEmailUseCaseInputPort>(() => PwFindEmailUseCase(
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>()));
  gh.factory<SingUpUseCaseInputPort>(() => SingUpUseCase(
        fUserRepository: get<FUserRepository>(),
        preference: get<Preference>(),
        fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
      ));
  gh.factory<UserPositionForegroundMonitoringUseCaseInputPort>(
      () => UserPositionForegroundMonitoringUseCase(
            geoLocationUtilBasicUseCaseInputPort:
                get<GeoLocationUtilBasicUseCaseInputPort>(),
            fUserRepository: get<FUserRepository>(),
            fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
            updateUserPositionUseCaseInputPort:
                get<UpdateUserPositionUseCaseInputPort>(),
          ));
  gh.factory<FBallRepository>(() => FBallRepositoryImpl(
      fBallRemoteDataSource: get<FBallRemoteDataSource>(),
      fireBaseAuthBaseAdapter: get<FireBaseAuthAdapterForUseCase>()));
  gh.factory<FBallValuationRepository>(() => FBallValuationRepositoryImpl(
      fireBaseAuthBaseAdapter: get<FireBaseAuthAdapterForUseCase>(),
      fBallValuationRemoteDataSource: get<FBallValuationRemoteDataSource>()));
  gh.factory<HitBallUseCaseInputPort>(
      () => HitBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.factory<InsertBallUseCaseInputPort>(
      () => InsertBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.factory<LoginUseCaseInputPort>(() => LoginUseCase(
        singUpUseCaseInputPort: get<SingUpUseCaseInputPort>(),
        fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
        snsLoginModuleAdapter: get<SnsLoginModuleAdapter>(),
      ));
  gh.factory<SelectBallUseCaseInputPort>(
      () => SelectBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.factory<UpdateBallUseCaseInputPort>(
      () => UpdateBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.factory<BallImageListUpLoadUseCaseInputPort>(() =>
      BallImageListUpLoadUseCase(fBallRepository: get<FBallRepository>()));
  gh.factory<BallLikeUseCaseInputPort>(() => BallLikeUseCase(
      fBallValuationRepository: get<FBallValuationRepository>()));
  gh.factory<DeleteBallUseCaseInputPort>(
      () => DeleteBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.factory<PageMoveActionUseCaseInputPort>(() => ID001PageMoveAction(
      selectBallUseCaseInputPort: get<SelectBallUseCaseInputPort>()));
  return get;
}
