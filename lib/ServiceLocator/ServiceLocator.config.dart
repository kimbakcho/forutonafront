// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import '../Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart';
import '../Common/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart';
import '../AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart';
import '../AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import '../Components/BallStyle/BallOptionPopup/BallOptionWidgetFactory.dart';
import '../AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import '../AppBis/FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart';
import '../AppBis/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';
import '../Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import '../Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart';
import '../AppBis/FBall/Domain/UseCase/DeleteBall/DeleteBallUseCaseInputPort.dart';
import '../Components/DetailPageViewer/DetailPageItemFactory.dart';
import '../AppBis/FBallPlayer/Domain/UseCase/FBallPlayerListUp/FBallPlayerListUpUseCaeInputPort.dart';
import '../AppBis/FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart';
import '../AppBis/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart';
import '../AppBis/FBallPlayer/Data/Repository/FBallPlayerRepositoryImpl.dart';
import '../AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import '../AppBis/FBallReply/Data/DataSource/FBallReplyDataSource.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/Service/FBallReplyFCMServiceUseCase.dart';
import '../AppBis/FBallReply/Domain/Repositroy/FBallReplyRepository.dart';
import '../AppBis/FBallReply/Data/Repository/FBallReplyRepositoryImpl.dart';
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCase.dart';
import '../AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import '../AppBis/FBall/Domain/Repository/FBallRepository.dart';
import '../AppBis/FBall/Data/Repository/FBallRepositoryImpl.dart';
import '../AppBis/FBall/Domain/UseCase/FBallSearchBarHistory/FBallSearchBarHistoryUseCaseInputPort.dart';
import '../AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import '../AppBis/FBallValuation/Data/DataStore/FBallValuationRemoteDataSource.dart';
import '../AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import '../AppBis/FBallValuation/Data/Repository/FBallValuationRepositoryImpl.dart';
import '../AppBis/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import '../AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import '../AppBis/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/FUserUseCaseInputPort/FUserUseCaseInputPort.dart';
import '../Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import '../AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import '../Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import '../Common/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import '../Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart';
import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import '../Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import '../Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import '../Page/GCodePage/G001/G001MainPage.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import '../Common/GeoPlaceAdapter/GeoPlaceAdapter.dart';
import '../Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import '../Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import '../Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import '../AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/ID001/ID001PageMoveAction.dart';
import '../Common/ImageCropUtil/ImageUtilInputPort.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import '../AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/Service/IssueFBalIInsertFCMServiceUseCase.dart';
import '../Common/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart';
import '../Common/Geolocation/Adapter/LocationAdapter.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import '../MainPage/MainPageView.dart';
import '../Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import '../Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart';
import '../Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import '../Common/MapScreenPosition/MapScreenPositionUseCase.dart';
import '../Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import '../AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart';
import '../AppBis/FBall/Data/Repository/NoInterestBallRepositoryImpl.dart';
import '../AppBis/FBall/Domain/UseCase/NoInterestBallUseCase/NoInterestBallUseCaseInputPort.dart';
import '../Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import '../Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCase.dart';
import '../Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import '../AppBis/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import '../AppBis/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import '../Components/PhoneAuthComponent/PhoneAuthMode/PhoneAuthModeFactory.dart';
import '../AppBis/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
import '../AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import '../AppBis/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import '../Common/SignValid/PhonePwFindValidUseCase/PhoneFindValidUseCase.dart';
import '../Page/GCodePage/Component/UserProfile/ProfileModeUseCase/ProfileModeUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Dto/PwChangeFromPhoneAuthReqDto.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCae.dart';
import '../Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCaeInputPort.dart';
import '../Components/TagList/RankingTagListMediator.dart';
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart';
import '../AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import '../Common/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart';
import '../Components/FBallReply2/ReviewCountMediator.dart';
import '../Components/FBallReply2/ReviewDeleteMediator.dart';
import '../Components/FBallReply2/ReviewInertMediator.dart';
import '../Components/FBallReply2/ReviewUpdateMediator.dart';
import '../AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import '../Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import '../Common/SwipeGestureRecognizer/SwipeGestureRecognizer.dart';
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import '../AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import '../AppBis/Tag/Domain/Repository/TagRepository.dart';
import '../AppBis/Tag/Data/Repository/TagRepositoryImpl.dart';
import '../ManagerBis/TermsConditions/Domain/Repository/TermsConditionsRepository.dart';
import '../ManagerBis/TermsConditions/Data/Repository/TermsConditionsRepositoryImpl.dart';
import '../ManagerBis/TermsConditions/Domain/UseCase/TermsConditionsUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart';
import '../AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart';
import '../Components/UserInfoCollectionWidget/UserInfoCollectMediator.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserInfoUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import '../AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import '../AppBis/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart';
import '../AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import '../Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.lazySingleton<AndroidIntentAdapter>(() => AndroidIntentAdapterImpl());
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
  gh.lazySingleton<BaseMessageUseCaseInputPort>(() => BaseMessageUseCase(),
      instanceName: 'BaseMessageUseCase');
  gh.lazySingleton<BaseMessageUseCaseInputPort>(() => LaunchMessageUseCase(),
      instanceName: 'LaunchMessageUseCase');
  gh.lazySingleton<BaseMessageUseCaseInputPort>(() => ResumeMessageUseCase(),
      instanceName: 'ResumeMessageUseCase');
  gh.lazySingleton<BaseOpenTalkInputPort>(() => InquireAboutAnythingUseCase());
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
  gh.lazySingleton<FUserInfoJoinReqDto>(() => FUserInfoJoinReqDto());
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
  gh.lazySingleton<G001MainPageViewModelController>(
      () => G001MainPageViewModelController());
  gh.factory<GeoPlaceAdapter>(() => GooglePlaceAdapter());
  gh.lazySingleton<GeolocatorAdapter>(() => GeolocatorAdapterImpl());
  gh.lazySingleton<ImageUtilInputPort>(() => ImagePngResizeUtil(),
      instanceName: 'ImagePngResizeUtil');
  gh.lazySingleton<ImageUtilInputPort>(() => ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
  gh.lazySingleton<ImageUtilInputPort>(() => ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.lazySingleton<LocationAdapter>(() => LocationAdapterImpl());
  gh.lazySingleton<MainPageViewModelController>(
      () => MainPageViewModelController());
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
  gh.factoryParam<NotificationChannelBaseInputPort, String, dynamic>(
      (name, _) =>
          NotificationChannelBaseInputPort.serviceChannelUseCaseName(name));
  gh.lazySingleton<NotificationChannelBaseInputPort>(
      () => RadarBasicChannelUseCae(),
      instanceName: 'RadarBasicChannelUseCae');
  gh.lazySingleton<NotificationChannelBaseInputPort>(
      () => CommentChannelUseCase(),
      instanceName: 'CommentChannelUseCase');
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
  gh.factory<PhoneFindValidUseCase>(() => PhoneFindValidUseCaseImpl(
      phoneAuthRepository: get<PhoneAuthRepository>()));
  gh.lazySingleton<ProfileModeUseCaseFactory>(
      () => ProfileModeUseCaseFactory());
  gh.lazySingleton<PwChangeFromPhoneAuthReqDto>(
      () => PwChangeFromPhoneAuthReqDto());
  gh.lazySingleton<PwFindPhoneUseCaseInputPort>(() =>
      PwFindPhoneUseCase(phoneAuthRepository: get<PhoneAuthRepository>()));
  gh.lazySingleton<RadarBasicChannelUseCaeInputPort>(() =>
      IssueFBalIInsertFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter:
              get<FlutterLocalNotificationsPluginAdapter>()));
  gh.factory<RankingTagListMediator>(() => RankingTagListMediatorImpl());
  gh.lazySingleton<SharedPreferencesAdapter>(
      () => SharedPreferencesAdapterImpl());
  gh.factory<SwipeGestureRecognizerController>(
      () => SwipeGestureRecognizerController());
  gh.lazySingleton<TagRepository>(() => TagRepositoryImpl(
      fBallTagRemoteDataSource: get<FBallTagRemoteDataSource>()));
  gh.factory<TermsConditionsRepository>(() => TermsConditionsRepositoryImpl());
  gh.factory<TermsConditionsUseCaseInputPort>(() => TermsConditionsUseCase(
      termsConditionsRepository: get<TermsConditionsRepository>()));
  gh.factory<UserInfoCollectMediator>(() => UserInfoCollectMediatorImpl());
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
  gh.lazySingleton<FUserUseCaseInputPort>(
      () => FUserUseCase(get<FUserRepository>()));
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
  gh.lazySingleton<NoInterestBallRepository>(() => NoInterestBallRepositoryImpl(
      sharedPreferencesAdapter: get<SharedPreferencesAdapter>()));
  gh.lazySingleton<NoInterestBallUseCaseInputPort>(() => NoInterestBallUseCase(
      noInterestBallRepository: get<NoInterestBallRepository>()));
  gh.factory<PhoneAuthModeFactory>(() => PhoneAuthModeFactory(
      get<PhoneAuthUseCaseInputPort>(), get<PhoneFindValidUseCase>()));
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
  gh.lazySingleton<UpdateAccountUserInfoUseCaseInputPort>(() =>
      UpdateAccountUserInfoUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<UpdateFCMTokenUseCaseInputPort>(
      () => UpdateFCMTokenUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<UpdateUserPositionUseCaseInputPort>(
      () => UpdateUserPositionUseCase(fUserRepository: get<FUserRepository>()));
  gh.lazySingleton<UserInfoUseCaseInputPort>(
      () => UserInfoUseCase(get<FUserRepository>()));
  gh.lazySingleton<UserProfileImageUploadUseCaseInputPort>(() =>
      UserProfileImageUploadUseCase(
          flutterImageCompressAdapter: get<FlutterImageCompressAdapter>(),
          fUserRepository: get<FUserRepository>()));
  gh.factory<BallOptionWidgetFactory>(() => BallOptionWidgetFactory(
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
  gh.factory<FireBaseSignInValidUseCase>(() => FireBaseSignInValidUseCaseImpl(
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<MapBallMarkerFactory>(() => MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<MapMakerDescriptorContainer>()));
  gh.lazySingleton<PwFindEmailUseCaseInputPort>(() => PwFindEmailUseCase(
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<SingUpUseCaseInputPort>(() => SingUpUseCase(
      fUserRepository: get<FUserRepository>(),
      fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>()));
  gh.lazySingleton<SnsLoginModuleAdapterFactory>(
      () => SnsLoginModuleAdapterFactory(get<FireBaseAuthAdapterForUseCase>()));
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
  gh.lazySingleton<LogoutUseCaseInputPort>(() => LogoutUseCase(
        fireBaseAuthAdapterForUseCase: get<FireBaseAuthAdapterForUseCase>(),
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
        snsLoginModuleAdapterFactory: get<SnsLoginModuleAdapterFactory>(),
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
