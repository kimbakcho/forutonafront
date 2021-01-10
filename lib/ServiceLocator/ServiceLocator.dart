import 'package:forutonafront/AppBis/ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import 'package:forutonafront/Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart';
import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/FluttertoastAdapter/FluttertoastAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageUtilInputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCase.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/Service/FBallReplyFCMServiceUseCase.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCae.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/RadarBasicChannel/RadarBasicChannelUseCaeInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/RadarBasicChannel/Service/IssueFBalIInsertFCMServiceUseCase.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/ID001/ID001PageMoveAction.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCase.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Components/BallStyle/BallOptionPopup/BallOptionWidgetFactory.dart';
import 'package:forutonafront/Components/TopNav/TopNavBtnMediator.dart';

import 'package:forutonafront/Components/DetailPageViewer/DetailPageItemFactory.dart';
import 'package:forutonafront/AppBis/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart';
import 'package:forutonafront/AppBis/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/AppBis/FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart';
import 'package:forutonafront/AppBis/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallImageListUpLoadUseCase/BallImageListUpLoadUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/HitBall/HitBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/InsertBall/InsertBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/UpdateBall/UpdateBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart';
import 'package:forutonafront/AppBis/FBallPlayer/Data/Repository/FBallPlayerRepositoryImpl.dart';
import 'package:forutonafront/AppBis/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/AppBis/FBallReply/Data/DataSource/FBallReplyDataSource.dart';
import 'package:forutonafront/AppBis/FBallReply/Data/Repository/FBallReplyRepositoryImpl.dart';
import 'package:forutonafront/AppBis/FBallReply/Domain/Repositroy/FBallReplyRepository.dart';
import 'package:forutonafront/AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCase.dart';
import 'package:forutonafront/AppBis/FBallReply/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Data/DataStore/FBallValuationRemoteDataSource.dart';
import 'package:forutonafront/AppBis/FBallValuation/Data/Repository/FBallValuationRepositoryImpl.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Repositroy/FBallValuationRepository.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/BallLikeUseCase/BallLikeUseCaseInputPort.dart';
import 'package:forutonafront/Common/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart';
import 'package:forutonafront/Common/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/FUserPwChangeUseCase/FUserPwChangeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateAccountUserInfo/UpdateAccountUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UpdateUserPositionUseCase/UpdateUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';

import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PhoneAuthUseCase/PhoneAuthUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCase.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindEmailUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PwFind/PwFindPhoneUseCaseInputPort.dart';

import 'package:forutonafront/AppBis/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/AppBis/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/AppBis/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/AppBis/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import '../Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import '../Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart';

import 'ServiceLocator.config.dart';

final sl = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() => $initGetIt(sl);

init2() {
  sl.registerSingleton<Preference>(Preference());

  sl.registerSingleton<FluttertoastAdapter>(FluttertoastAdapter());

  sl.registerSingleton<GeolocatorAdapter>(GeolocatorAdapterImpl());

  sl.registerSingleton<LocationAdapter>(LocationAdapterImpl());

  sl.registerSingleton<FlutterLocalNotificationsPluginAdapter>(
      FlutterLocalNotificationsPluginAdapterImpl());

  sl.registerSingleton<SharedPreferencesAdapter>(
      SharedPreferencesAdapterImpl());

  sl.registerSingleton<FileDownLoaderUseCaseInputPort>(FileDownLoaderUseCase());

  sl.registerSingleton<GeoLocationUtilBasicUseCaseInputPort>(
      GeoLocationUtilBasicUseCase(
          geolocatorAdapter: sl(),
          sharedPreferencesAdapter: sl()));

  sl.registerSingleton<GeoLocationUtilForeGroundUseCaseInputPort>(
      GeoLocationUtilForeGroundUseCase(
          geolocatorAdapter: sl(),
          locationAdapter: sl(),
          sharedPreferencesAdapter: sl(),
          basicUseCaseInputPort: sl()));

  sl.registerSingleton<FireBaseAuthBaseAdapter>(FireBaseAuthBaseAdapterImpl());

  sl.registerSingleton<FUserRemoteDataSource>(FUserRemoteDataSourceImpl());

  sl.registerSingleton<FUserRepository>(FUserRepositoryImpl(
      fireBaseAuthBaseAdapter: sl(), fUserRemoteDataSource: sl()));

  sl.registerSingleton<SignInUserInfoUseCaseInputPort>(
      SignInUserInfoUseCase(fUserRepository: sl()));

  sl.registerSingleton<UpdateFCMTokenUseCaseInputPort>(
      UpdateFCMTokenUseCase(fUserRepository: sl()));

  sl.registerSingleton<FireBaseMessageAdapter>(FireBaseMessageAdapterImpl(
      fireBaseAuthBaseAdapter: sl(),
      updateFCMTokenUseCaseInputPort: sl(),
      signInUserInfoUseCaseInputPort: sl()));

  sl.registerSingleton<FireBaseAuthAdapterForUseCase>(
      FireBaseAuthAdapterForUseCaseImpl(
          fireBaseMessageAdapter: sl(),
          fireBaseAuthBaseAdapter: sl(),
          updateFCMTokenUseCaseInputPort: sl(),
          signInUserInfoUseCaseInputPort: sl()));

  sl.registerSingleton<FBallRemoteDataSource>(FBallRemoteSourceImpl());

  sl.registerSingleton<FBallRepository>(
      FBallRepositoryImpl(fBallRemoteDataSource: sl(),fireBaseAuthBaseAdapter: sl()));

  sl.registerSingleton<FBallTagRemoteDataSource>(
      FBallTagRemoteDataSourceImpl());

  sl.registerSingleton<TagRepository>(
      TagRepositoryImpl(fBallTagRemoteDataSource: sl()));


  sl.registerSingleton<ImageUtilInputPort>(ImageAvatarUtil(),
      instanceName: "ImageAvatarUtil");

  sl.registerSingleton<ImageUtilInputPort>(ImagePngResizeUtil(),
      instanceName: "ImagePngResizeUtil");

  sl.registerSingleton<ImageUtilInputPort>(ImageBorderAvatarUtil(),
      instanceName: "ImageBorderAvatarUtil");

  sl.registerSingleton<AvatarImageMakerUseCaseInputPort>(
      AvatarImageMakerUseCase(
          imageUtilInputPort: sl.get(instanceName: "ImageAvatarUtil"),
          fileDownLoaderUseCaseInputPort: sl()));

  sl.registerSingleton<CommentChannelBaseServiceUseCaseInputPort>(
      FBallReplyFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter: sl(),
          avatarImageMakerUseCaseInputPort: sl(),
          signInUserInfoUseCaseInputPort: sl()),
      instanceName: "FBallReplyFCMService");

  sl.registerFactoryParam<CommentChannelBaseServiceUseCaseInputPort, String,
      String>((serviceKey, param2) {
    if (serviceKey == "FBallReplyFCMService") {
      return sl.get(instanceName: "FBallReplyFCMService");
    } else {
      return null;
    }
  }, instanceName: "CommentChannelBaseServiceUseCaseInputPortFactory");

  sl.registerSingleton<NotificationChannelBaseInputPort>(
      CommentChannelUseCase(),
      instanceName: "CommentChannelUseCase");

  sl.registerSingleton<RadarBasicChannelUseCaeInputPort>(
      IssueFBalIInsertFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter: sl()),
      instanceName: "IssueFBalIInsertFCMService");

  sl.registerFactoryParam<RadarBasicChannelUseCaeInputPort, String, String>(
      (serviceKey, param2) {
    if (serviceKey == "IssueFBalIInsertFCMService") {
      return sl.get<RadarBasicChannelUseCaeInputPort>(
          instanceName: "IssueFBalIInsertFCMService");
    } else {
      return null;
    }
  }, instanceName: "RadarBasicChannelUseCaeInputPortFactory");

  sl.registerSingleton<NotificationChannelBaseInputPort>(
      RadarBasicChannelUseCae(),
      instanceName: "RadarBasicChannelUseCase");

  sl.registerFactoryParam<NotificationChannelBaseInputPort, String, String>(
      (String commentKey, param2) {
    if (commentKey == "CommentChannelUseCase") {
      return sl.get(instanceName: "CommentChannelUseCase");
    } else if (commentKey == "RadarBasicChannelUseCase") {
      return sl.get(instanceName: "RadarBasicChannelUseCase");
    } else {
      return null;
    }
  }, instanceName: "NotificationChannelBaseInputPortFactory");

  sl.registerSingleton<SelectBallUseCaseInputPort>(
      SelectBallUseCase(fBallRepository: sl()));

  sl.registerSingleton<InsertBallUseCaseInputPort>(
      InsertBallUseCase(fBallRepository: sl()));

  sl.registerSingleton<UpdateBallUseCaseInputPort>(
      UpdateBallUseCase(fBallRepository: sl()));

  sl.registerSingleton<HitBallUseCaseInputPort>(
      HitBallUseCase(fBallRepository: sl()));

  sl.registerSingleton<PageMoveActionUseCaseInputPort>(
      ID001PageMoveAction(selectBallUseCaseInputPort: sl()),
      instanceName: "ID001PageMoveAction");

  sl.registerFactoryParam<PageMoveActionUseCaseInputPort, String, String>(
      (String serviceKey, param2) {
    if (serviceKey == "ID001PageMoveAction") {
      return sl.get<PageMoveActionUseCaseInputPort>(
          instanceName: "ID001PageMoveAction");
    } else {
      return null;
    }
  }, instanceName: "PageMoveActionUseCaseInputPortFactory");

  sl.registerSingleton<NotiSelectActionBaseInputPort>(PageMoveActionUseCase(),
      instanceName: "PageMoveActionUseCase");

  sl.registerFactoryParam<NotiSelectActionBaseInputPort, String, String>(
      (String commentKey, param2) {
    if (commentKey == "PageMoveActionUseCase") {
      return sl.get<NotiSelectActionBaseInputPort>(
          instanceName: "PageMoveActionUseCase");
    } else {
      return null;
    }
  }, instanceName: "NotiSelectActionBaseInputPortFactory");

  sl.registerSingleton<BaseMessageUseCaseInputPort>(BaseMessageUseCase(),
      instanceName: "BaseMessageUseCase");

  sl.registerSingleton<BaseMessageUseCaseInputPort>(
      BackGroundMessageUseCase(
          baseMessageUseCaseInputPort:
              sl.get(instanceName: "BaseMessageUseCase")),
      instanceName: "BackGroundMessageUseCase");

  sl.registerSingleton<BaseMessageUseCaseInputPort>(LaunchMessageUseCase(),
      instanceName: "LaunchMessageUseCase");

  sl.registerSingleton<BaseMessageUseCaseInputPort>(ResumeMessageUseCase(),
      instanceName: "ResumeMessageUseCase");

  sl.registerSingleton<FireBaseMessageController>(FireBaseMessageController(
    baseMessageUseCase: sl.get(instanceName: "BaseMessageUseCase"),
    launchMessageUseCase: sl.get(instanceName: "LaunchMessageUseCase"),
    resumeMessageUseCase: sl.get(instanceName: "ResumeMessageUseCase"),
    fireBaseMessageAdapter: sl(),
  ));

  sl.registerSingleton<BaseOpenTalkInputPort>(InquireAboutAnythingUseCase(),
      instanceName: "InquireAboutAnythingUseCase");

  sl.registerSingleton<BaseGoogleSurveyInputPort>(
      GoogleProposalOnServiceSurveyUseCase(),
      instanceName: "GoogleProposalOnServiceSurveyUseCase");
  sl.registerSingleton<BaseGoogleSurveyInputPort>(
      GoogleSurveyErrorReportUseCase(),
      instanceName: "GoogleSurveyErrorReportUseCase");

  sl.registerSingleton<FireBaseSignInValidUseCase>(
      FireBaseSignInValidUseCaseImpl(fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<SingUpUseCaseInputPort>(SingUpUseCase(
      fUserRepository: sl(),
      fireBaseAuthAdapterForUseCase: sl()));


  sl.registerSingleton<FlutterImageCompressAdapter>(
      FlutterImageCompressAdapterImpl());

  sl.registerSingleton<UserProfileImageUploadUseCaseInputPort>(
      UserProfileImageUploadUseCase(flutterImageCompressAdapter: sl(),fUserRepository: sl()));

  sl.registerSingleton<PersonaSettingNoticeRemoteDataSource>(
      PersonaSettingNoticeRemoteDataSourceImpl());

  sl.registerSingleton<PersonaSettingNoticeRepository>(
      PersonaSettingNoticeRepositoryImpl(
          personaSettingNoticeRemoteDataSource: sl()));

  sl.registerSingleton<PersonaSettingNoticeUseCaseInputPort>(
      PersonaSettingNoticeUseCase(personaSettingNoticeRepository: sl()));

  sl.registerSingleton<UserPolicyRemoteDataSource>(
      UserPolicyRemoteDataSourceImpl());

  sl.registerSingleton<UserPolicyRepository>(
      UserPolicyRepositoryImpl(userPolicyRemoteDataSource: sl()));

  sl.registerSingleton<UserPolicyUseCaseInputPort>(
      UserPolicyUseCase(userPolicyRepository: sl()));

  sl.registerSingleton<PhoneAuthRemoteSource>(PhoneAuthRemoteSourceImpl());

  sl.registerSingleton<PhoneAuthRepository>(
      PhoneAuthRepositoryImpl(phoneAuthRemoteSource: sl()));

  sl.registerSingleton<PhoneAuthUseCaseInputPort>(
      PhoneAuthUseCase(phoneAuthRepository: sl()));

  sl.registerSingleton<PwFindPhoneUseCaseInputPort>(
      PwFindPhoneUseCase(phoneAuthRepository: sl()));

  sl.registerSingleton<PwFindEmailUseCaseInputPort>(
      PwFindEmailUseCase(fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<FBallPlayerRemoteDataSource>(
      FBallPlayerRemoteDataSourceImpl());

  sl.registerSingleton<FBallPlayerRepository>(
      FBallPlayerRepositoryImpl(fBallPlayerRemoteDataSource: sl()));

  sl.registerSingleton<TagFromBallUuidUseCaseInputPort>(
      TagFromBallUuidUseCase(tagRepository: sl()));

  sl.registerSingleton<MapScreenPositionUseCaseInputPort>(
      MapScreenPositionUseCase());

  sl.registerSingleton<BallSearchHistoryLocalDataSource>(
      BallSearchHistoryLocalDataSourceImpl());

  sl.registerSingleton<BallSearchBarHistoryRepository>(
      BallSearchBarHistoryRepositoryImpl(localDataSource: sl()));

  sl.registerSingleton<
          RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: sl()));

  sl.registerSingleton<FBallReplyDataSource>(FBallReplyDataSourceImpl());

  sl.registerSingleton<FBallReplyRepository>(FBallReplyRepositoryImpl(
      fBallReplyDataSource: sl(), fireBaseAuthBaseAdapter: sl()));

  sl.registerSingleton<FBallReplyUseCaseInputPort>(
      FBallReplyUseCase(fBallReplyRepository: sl()));

  sl.registerSingleton<UpdateUserPositionUseCaseInputPort>(
      UpdateUserPositionUseCase(fUserRepository: sl()));

  sl.registerSingleton<UserPositionForegroundMonitoringUseCaseInputPort>(
      UserPositionForegroundMonitoringUseCase(
          geoLocationUtilBasicUseCaseInputPort: sl(),
          updateUserPositionUseCaseInputPort: sl(),
          fUserRepository: sl(),
          fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<BallImageListUpLoadUseCaseInputPort>(
      BallImageListUpLoadUseCase(fBallRepository: sl()));

  sl.registerSingleton<MapBitmapDescriptorUseCaseInputPort>(
      MapBitmapDescriptorUseCase(
          imagePngResizeUtil: sl.get(instanceName: "ImagePngResizeUtil"),
          fileDownLoaderUseCaseInputPort: sl(),
          imageBorderAvatarUtil:
              sl.get(instanceName: "ImageBorderAvatarUtil")));

  sl.registerSingleton<MapMakerDescriptorContainer>(
      MapMakerDescriptorContainerImpl(
          signInUserInfoUseCaseInputPort: sl(),
          fireBaseAuthBaseAdapter: sl(),
          mapBitmapDescriptorUseCaseInputPort: sl()));

  sl.registerSingleton<UpdateAccountUserInfoUseCaseInputPort>(
      UpdateAccountUserInfoUseCase(fUserRepository: sl()));

  sl.registerSingleton<FUserPwChangeUseCaseInputPort>(
      FUserPwChangeUseCase(fUserRepository: sl()));

  sl.registerSingleton<FBallValuationRemoteDataSource>(
      FBallValuationRemoteDataSourceImpl());

  sl.registerSingleton<FBallValuationRepository>(FBallValuationRepositoryImpl(
      fBallValuationRemoteDataSource: sl(), fireBaseAuthBaseAdapter: sl()));

  sl.registerSingleton<BallLikeUseCaseInputPort>(
      BallLikeUseCase(fBallValuationRepository: sl()));

  sl.registerSingleton<DetailPageItemFactory>(DetailPageItemFactory());

  sl.registerSingleton<MapBallMarkerFactory>(
      MapBallMarkerFactory(mapMakerDescriptorContainer: sl()));

  sl.registerSingleton<TopNavBtnMediator>(TopNavBtnMediatorImpl());


  sl.registerSingleton<BallOptionWidgetFactory>(BallOptionWidgetFactory(
    signInUserInfoUseCaseInputPort: sl()
  ));
}
