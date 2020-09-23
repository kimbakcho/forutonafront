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
import '../Components/BallListUp/BallListMediator.dart';
import '../Components/BallStyle/BallOptionPopup/BallOptionWidgetFactory.dart';
import '../FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import '../FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart';
import '../FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';
import '../FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import '../FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import '../MainPage/CodeMainPageController.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart';
import '../FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import '../DetailPageViewer/DetailPageItemFactory.dart';
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
import '../Common/FluttertoastAdapter/FluttertoastAdapter.dart';
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
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart';
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCase.dart';
import '../ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCae.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCaeInputPort.dart';
import '../Components/TagList/RankingTagListFromBIManager.dart';
import '../Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart';
import '../Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import '../FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart';
import '../Components/FBallReply2/ReviewCountMediator.dart';
import '../Components/FBallReply2/ReviewDeleteMediator.dart';
import '../Components/FBallReply2/ReviewInertMediator.dart';
import '../Components/FBallReply2/ReviewUpdateMediator.dart';
import '../FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import '../ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import '../ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import '../ForutonaUser/Domain/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import '../Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import '../Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import '../Tag/Domain/UseCase/TagRankingFromBallInfluencePowerUseCase.dart';
import '../Tag/Domain/Repository/TagRepository.dart';
import '../Tag/Data/Repository/TagRepositoryImpl.dart';
import '../Components/TopNav/TopNavBtnMediator.dart';
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
import '../ICodePage/ID001/ValuationMediator/ValuationMediator.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<AndroidIntentAdapter>(() => AndroidIntentAdapterImpl());
  gh.factory<BallListMediator>(() => BallListMediatorImpl());
  gh.lazySingleton<BallSearchHistoryLocalDataSource>(
      () => BallSearchHistoryLocalDataSourceImpl());
  gh.lazySingleton<BaseGoogleSurveyInputPort>(() => BaseGoogleSurveyUseCase(),
      instanceName: 'BaseGoogleSurveyUseCase');
  gh.lazySingleton<BaseGoogleSurveyInputPort>(
      () => GoogleProposalOnServiceSurveyUseCase(),
      instanceName: 'GoogleProposalOnServiceSurveyUseCase');
  gh.lazySingleton<BaseGoogleSurveyInputPort>(
      () => GoogleSurveyErrorReportUseCase(),
      instanceName: 'GoogleSurveyErrorReportUseCase');
  gh.lazySingleton<BaseMessageUseCaseInputPort>(() => ResumeMessageUseCase(),
      instanceName: 'ResumeMessageUseCase');
  gh.lazySingleton<BaseMessageUseCaseInputPort>(() => LaunchMessageUseCase(),
      instanceName: 'LaunchMessageUseCase');
  gh.lazySingleton<BaseMessageUseCaseInputPort>(() => BaseMessageUseCase(),
      instanceName: 'BaseMessageUseCase');
  gh.lazySingleton<BaseOpenTalkInputPort>(() => InquireAboutAnythingUseCase());
  gh.lazySingleton<CodeMainPageController>(() => CodeMainPageControllerImpl());
  gh.lazySingleton<DetailPageItemFactory>(() => DetailPageItemFactory());
  gh.lazySingleton<FBallPlayerRemoteDataSource>(
      () => FBallPlayerRemoteDataSourceImpl());
  gh.lazySingleton<FBallPlayerRepository>(() => FBallPlayerRepositoryImpl(
      fBallPlayerRemoteDataSource: get<FBallPlayerRemoteDataSource>()));
  gh.lazySingleton<FBallRemoteDataSource>(() => FBallRemoteSourceImpl());
  gh.lazySingleton<FBallReplyDataSource>(() => FBallReplyDataSourceImpl());
  gh.lazySingleton<FBallTagRemoteDataSource>(
      () => FBallTagRemoteDataSourceImpl());
  gh.lazySingleton<FBallValuationRemoteDataSource>(
      () => FBallValuationRemoteDataSourceImpl());
  gh.lazySingleton<FUserRemoteDataSource>(() => FUserRemoteDataSourceImpl());
  gh.lazySingleton<FileDownLoaderUseCaseInputPort>(
      () => FileDownLoaderUseCase());
  gh.lazySingleton<FireBaseAuthBaseAdapter>(
      () => FireBaseAuthBaseAdapterImpl());
  gh.lazySingleton<FlutterImageCompressAdapter>(
      () => FlutterImageCompressAdapterImpl());
  gh.lazySingleton<FlutterLocalNotificationsPluginAdapter>(
      () => FlutterLocalNotificationsPluginAdapterImpl());
  gh.lazySingleton<FluttertoastAdapter>(() => FluttertoastAdapter());
  gh.lazySingleton<GeolocatorAdapter>(() => GeolocatorAdapterImpl());
  gh.lazySingleton<H001ManagerInputPort>(() => H001Manager());
  gh.lazySingleton<ImageUtilInputPort>(() => ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.lazySingleton<ImageUtilInputPort>(() => ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
  gh.lazySingleton<ImageUtilInputPort>(() => ImagePngResizeUtil(),
      instanceName: 'ImagePngResizeUtil');
  gh.lazySingleton<LocationAdapter>(() => LocationAdapterImpl());
  gh.lazySingleton<MapBitmapDescriptorUseCaseInputPort>(() =>
      MapBitmapDescriptorUseCase(
        imagePngResizeUtil:
            get<ImageUtilInputPort>(instanceName: 'ImagePngResizeUtil'),
        imageBorderAvatarUtil:
            get<ImageUtilInputPort>(instanceName: 'ImageBorderAvatarUtil'),
        fileDownLoaderUseCaseInputPort: get<FileDownLoaderUseCaseInputPort>(),
      ));
  gh.lazySingleton<MapScreenPositionUseCaseInputPort>(
      () => MapScreenPositionUseCase());
  gh.lazySingleton<NotiSelectActionBaseInputPort>(
      () => PageMoveActionUseCase());
  gh.lazySingleton<NotificationChannelBaseInputPort>(
      () => CommentChannelUseCase(),
      instanceName: 'CommentChannelUseCase');
  gh.lazySingleton<NotificationChannelBaseInputPort>(
      () => RadarBasicChannelUseCae(),
      instanceName: 'RadarBasicChannelUseCae');
  gh.factoryParam<NotificationChannelBaseInputPort, String, dynamic>(
      (name, _) =>
          NotificationChannelBaseInputPort.serviceChannelUseCaseName(name));
  gh.lazySingleton<PersonaSettingNoticeRemoteDataSource>(
      () => PersonaSettingNoticeRemoteDataSourceImpl());
  gh.lazySingleton<PersonaSettingNoticeRepository>(() =>
      PersonaSettingNoticeRepositoryImpl(
          personaSettingNoticeRemoteDataSource:
              get<PersonaSettingNoticeRemoteDataSource>()));
  gh.lazySingleton<PersonaSettingNoticeUseCaseInputPort>(() =>
      PersonaSettingNoticeUseCase(
          personaSettingNoticeRepository:
              get<PersonaSettingNoticeRepository>()));
  gh.lazySingleton<PhoneAuthRemoteSource>(() => PhoneAuthRemoteSourceImpl());
  gh.lazySingleton<PhoneAuthRepository>(() => PhoneAuthRepositoryImpl(
      phoneAuthRemoteSource: get<PhoneAuthRemoteSource>()));
  gh.lazySingleton<PhoneAuthUseCaseInputPort>(
      () => PhoneAuthUseCase(phoneAuthRepository: get<PhoneAuthRepository>()));
  gh.lazySingleton<PwFindPhoneUseCaseInputPort>(() =>
      PwFindPhoneUseCase(phoneAuthRepository: get<PhoneAuthRepository>()));
  gh.lazySingleton<RadarBasicChannelUseCaeInputPort>(() =>
      IssueFBalIInsertFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter:
              get<FlutterLocalNotificationsPluginAdapter>()));
  gh.factory<RankingTagListFromBIManagerInputPort>(
      () => RankingTagListFromBIManager());
  gh.lazySingleton<SharedPreferencesAdapter>(
      () => SharedPreferencesAdapterImpl());
  gh.lazySingleton<SnsLoginModuleAdapter>(() => FaceBookLoginAdapterImpl(),
      instanceName: 'FaceBookLoginAdapterImpl');
  gh.lazySingleton<SnsLoginModuleAdapter>(() => ForutonaLoginAdapterImpl(),
      instanceName: 'ForutonaLoginAdapterImpl');
  gh.lazySingleton<SnsLoginModuleAdapter>(() => KakaoLoginAdapterImpl(),
      instanceName: 'KakaoLoginAdapterImpl');
  gh.lazySingleton<SnsLoginModuleAdapter>(() => NaverLoginAdapterImpl(),
      instanceName: 'NaverLoginAdapterImpl');
  gh.lazySingleton<TagRepository>(() => TagRepositoryImpl(
      fBallTagRemoteDataSource: get<FBallTagRemoteDataSource>()));
  gh.lazySingleton<TopNavBtnMediator>(() => TopNavBtnMediatorImpl());
  gh.lazySingleton<UserPolicyRemoteDataSource>(
      () => UserPolicyRemoteDataSourceImpl());
  gh.lazySingleton<UserPolicyRepository>(() => UserPolicyRepositoryImpl(
      userPolicyRemoteDataSource: get<UserPolicyRemoteDataSource>()));
  gh.lazySingleton<UserPolicyUseCaseInputPort>(() =>
      UserPolicyUseCase(userPolicyRepository: get<UserPolicyRepository>()));
  gh.lazySingleton<AvatarImageMakerUseCaseInputPort>(() =>
      AvatarImageMakerUseCase(
          fileDownLoaderUseCaseInputPort: get<FileDownLoaderUseCaseInputPort>(),
          imageUtilInputPort: get<ImageUtilInputPort>()));
  gh.lazySingleton<BallSearchBarHistoryRepository>(() =>
      BallSearchBarHistoryRepositoryImpl(
          localDataSource: get<BallSearchHistoryLocalDataSource>()));
  gh.lazySingleton<BaseMessageUseCaseInputPort>(
      () => BackGroundMessageUseCase(
          baseMessageUseCaseInputPort: get<BaseMessageUseCaseInputPort>(
              instanceName: 'BaseMessageUseCase')),
      instanceName: 'BackGroundMessageUseCase');
  gh.lazySingleton<FBallPlayerListUpInputPort>(() => FBallPlayerListUpUseCae(
      fBallPlayerRepository: get<FBallPlayerRepository>()));
  gh.lazySingleton<FBallReplyRepository>(() => FBallReplyRepositoryImpl(
      fBallReplyDataSource: get<FBallReplyDataSource>(),
      fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>()));
  gh.lazySingleton<FBallReplyUseCaseInputPort>(() =>
      FBallReplyUseCase(fBallReplyRepository: get<FBallReplyRepository>()));
  gh.lazySingleton<FBallSearchBarHistoryUseCaseInputPort>(() =>
      FBallSearchBarHistoryUseCase(
          ballSearchBarHistoryRepository:
              get<BallSearchBarHistoryRepository>()));
  gh.lazySingleton<FUserRepository>(() => FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
      fUserRemoteDataSource: get<FUserRemoteDataSource>()));
  gh.lazySingleton<GeoLocationUtilBasicUseCaseInputPort>(() =>
      GeoLocationUtilBasicUseCase(
          geolocatorAdapter: get<GeolocatorAdapter>(),
          sharedPreferencesAdapter: get<SharedPreferencesAdapter>()));
  gh.lazySingleton<GeoLocationUtilForeGroundUseCaseInputPort>(
      () => GeoLocationUtilForeGroundUseCase(
            basicUseCaseInputPort: get<GeoLocationUtilBasicUseCaseInputPort>(),
            geolocatorAdapter: get<GeolocatorAdapter>(),
            sharedPreferencesAdapter: get<SharedPreferencesAdapter>(),
            locationAdapter: get<LocationAdapter>(),
          ));
  gh.lazySingleton<
          RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      () => RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: get<TagRepository>()));
  gh.factory<ReviewCountMediator>(() => ReviewCountMediatorImpl(
      fBallReplyUseCaseInputPort: get<FBallReplyUseCaseInputPort>()));
  gh.factory<ReviewDeleteMediator>(() => ReviewDeleteMediatorImpl(
      fBallReplyUseCaseInputPort: get<FBallReplyUseCaseInputPort>()));
  gh.factory<ReviewInertMediator>(() => ReviewInertMediatorImpl(
      fBallReplyUseCaseInputPort: get<FBallReplyUseCaseInputPort>()));
  gh.factory<ReviewUpdateMediator>(() => ReviewUpdateMediatorImpl(
      fBallReplyUseCaseInputPort: get<FBallReplyUseCaseInputPort>()));
  gh.lazySingleton<SignInUserInfoUseCaseInputPort>(
      () => SignInUserInfoUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<TagFromBallUuidUseCaseInputPort>(
      () => TagFromBallUuidUseCase(tagRepository: get<TagRepository>()));
  gh.lazySingleton<TagRankingFromBallInfluencePowerUseCaseInputPort>(() =>
      TagRankingFromBallInfluencePowerUseCase(
          tagRepository: get<TagRepository>()));
  gh.lazySingleton<UpdateAccountUserInfoUseCaseInputPort>(() =>
      UpdateAccountUserInfoUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<UpdateFCMTokenUseCaseInputPort>(
      () => UpdateFCMTokenUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<UpdateUserPositionUseCaseInputPort>(
      () => UpdateUserPositionUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<UserProfileImageUploadUseCaseInputPort>(() =>
      UserProfileImageUploadUseCase(
          flutterImageCompressAdapter: get<FlutterImageCompressAdapter>(),
          fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<BallOptionWidgetFactory>(() => BallOptionWidgetFactory(
      signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<CommentChannelBaseServiceUseCaseInputPort>(
      () => FBallReplyFCMServiceUseCase(
            flutterLocalNotificationsPluginAdapter:
                get<FlutterLocalNotificationsPluginAdapter>(),
            avatarImageMakerUseCaseInputPort:
                get<AvatarImageMakerUseCaseInputPort>(),
            signInUserInfoUseCaseInputPort:
                get<SignInUserInfoUseCaseInputPort>(),
          ),
      instanceName: 'FBallReplyFCMServiceUseCase');
  gh.lazySingleton<FUserPwChangeUseCaseInputPort>(
      () => FUserPwChangeUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<FireBaseMessageAdapter>(() => FireBaseMessageAdapterImpl(
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
        fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
        updateFCMTokenUseCaseInputPort: get<UpdateFCMTokenUseCaseInputPort>(),
      ));
  gh.lazySingleton<FireBaseMessageController>(() => FireBaseMessageController(
        fireBaseMessageAdapter: get<FireBaseMessageAdapter>(),
        launchMessageUseCase: get<BaseMessageUseCaseInputPort>(
            instanceName: 'LaunchMessageUseCase'),
        baseMessageUseCase: get<BaseMessageUseCaseInputPort>(
            instanceName: 'BaseMessageUseCase'),
        resumeMessageUseCase: get<BaseMessageUseCaseInputPort>(
            instanceName: 'ResumeMessageUseCase'),
      ));
  gh.lazySingleton<MapMakerDescriptorContainer>(() =>
      MapMakerDescriptorContainerImpl(
        mapBitmapDescriptorUseCaseInputPort:
            get<MapBitmapDescriptorUseCaseInputPort>(),
        fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
      ));
  gh.lazySingleton<FireBaseAuthAdapterForUseCase>(() =>
      FireBaseAuthAdapterForUseCaseImpl(
        fireBaseMessageAdapter: get<FireBaseMessageAdapter>(),
        fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
        updateFCMTokenUseCaseInputPort: get<UpdateFCMTokenUseCaseInputPort>(),
      ));
  gh.lazySingleton<LogoutUseCaseInputPort>(() => LogoutUseCase(
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
      signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>()));
  gh.lazySingleton<MapBallMarkerFactory>(() => MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<MapMakerDescriptorContainer>()));
  gh.lazySingleton<PwFindEmailUseCaseInputPort>(() => PwFindEmailUseCase(
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<SingUpUseCaseInputPort>(() => SingUpUseCase(
      fUserRepository: get<FUserRepository>(),
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<UserPositionForegroundMonitoringUseCaseInputPort>(
      () => UserPositionForegroundMonitoringUseCase(
            geoLocationUtilBasicUseCaseInputPort:
                get<GeoLocationUtilBasicUseCaseInputPort>(),
            fUserRepository: get<FUserRepository>(),
            fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
            updateUserPositionUseCaseInputPort:
                get<UpdateUserPositionUseCaseInputPort>(),
          ));
  gh.lazySingleton<FBallRepository>(() => FBallRepositoryImpl(
      fBallRemoteDataSource: get<FBallRemoteDataSource>(),
      fireBaseAuthBaseAdapter: get<FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<FBallValuationRepository>(() => FBallValuationRepositoryImpl(
      fireBaseAuthBaseAdapter: get<FireBaseAuthAdapterForUseCase>(),
      fBallValuationRemoteDataSource: get<FBallValuationRemoteDataSource>()));
  gh.lazySingleton<HitBallUseCaseInputPort>(
      () => HitBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.lazySingleton<InsertBallUseCaseInputPort>(
      () => InsertBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.lazySingleton<LoginUseCaseInputPort>(() => LoginUseCase(
        singUpUseCaseInputPort: get<SingUpUseCaseInputPort>(),
        fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
        snsLoginModuleAdapter: get<SnsLoginModuleAdapter>(),
      ));
  gh.lazySingleton<SelectBallUseCaseInputPort>(
      () => SelectBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.lazySingleton<UpdateBallUseCaseInputPort>(
      () => UpdateBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.lazySingleton<BallImageListUpLoadUseCaseInputPort>(() =>
      BallImageListUpLoadUseCase(fBallRepository: get<FBallRepository>()));
  gh.lazySingleton<BallLikeUseCaseInputPort>(() => BallLikeUseCase(
      fBallValuationRepository: get<FBallValuationRepository>()));
  gh.lazySingleton<DeleteBallUseCaseInputPort>(
      () => DeleteBallUseCase(fBallRepository: get<FBallRepository>()));
  gh.lazySingleton<PageMoveActionUseCaseInputPort>(() => ID001PageMoveAction(
      selectBallUseCaseInputPort: get<SelectBallUseCaseInputPort>()));
  gh.factory<ValuationMediator>(() => ValuationMediatorImpl(
      ballLikeUseCaseInputPort: get<BallLikeUseCaseInputPort>()));
  return get;
}
