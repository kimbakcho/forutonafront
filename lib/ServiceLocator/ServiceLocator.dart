import 'package:forutonafront/Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import 'package:forutonafront/Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import 'package:forutonafront/Common/ImageCropUtil/ImageCropUtilInputPort.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCase.dart';
import 'package:forutonafront/Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/Domain/CommentChannel/Service/FBallReplyFCMServiceUseCase.dart';
import 'package:forutonafront/Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/ID001/ID001PageMoveAction.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCase.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/Domain/PageMoveAction/PageMoveActionUseCaseInputPort.dart';
import 'package:forutonafront/Common/Notification/NotiSelectAction/NotiSelectActionBaseInputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/FaceBookLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/ForutonaLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/KakaoLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/NaverLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/FBall/Data/DataStore/BallSearchHistoryLocalDataSource.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallPlayerRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallReplyDataSource.dart';
import 'package:forutonafront/FBall/Data/DataStore/IssueBallTypeRemoteDateSource.dart';
import 'package:forutonafront/FBall/Data/Repository/BallSearchBarHistoryRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallPlayerRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallReplyRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallValuationRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Repository/IssueBallTypeRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/BallSearchBarHistoryRepository.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallReplyRepository.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Domain/Repository/IssueBallTypeRepository.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallSerachBarHistory/BallSearchBarHistoryUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/BallSerachBarHistory/BallSearchBarHistoryUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromMapArea/FBallListUpFromMapAreaUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromSearchTitle/FBallListUpFromSearchTitleUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromSearchTitle/FBallListUpFromSearchTitleUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagNameUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallReply/FBallReplyUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallValuation/IssueBall/IssueBallValuationUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/FBallValuation/IssueBall/IssueBallValuationUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/IssueBall/IssueBallUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserMakeBallListUp/UserMakeBallListUpUseCase.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserMakeBallListUp/UserMakeBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FBall/Domain/UseCase/UserPlayBallListUp/UserPlayBallListUpUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/PhoneAuthRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/UserPolicyRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/PersonaSettingNoticeRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/PhoneAuthRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/UserPolicyRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/PhoneAuthRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/Repository/UserPolicyRepository.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/PwFindPhoneUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoSimple1/UserInfoSimple1UseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoSimple1/UserInfoSimple1UseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCaeInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPasswordChangeUseCase/UserPasswordChangeUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPasswordChangeUseCase/UserPasswordChangeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPositionForegroundMonitoringUseCase/UserPositionForegroundMonitoringUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateEtcUserUseCase.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:get_it/get_it.dart';

import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import '../Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import '../Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart';
import '../FBall/Data/DataStore/FBallValuationRemoteDataSource.dart';
import '../FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCase.dart';
import '../FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import '../FBall/Domain/UseCase/FBallListUpFromMapArea/FBallListUpFromMapAreaUseCase.dart';
import '../FBall/Domain/UseCase/FBallListUpFromTagName/FBallListUpFromSearchTagUseCaseInputPort.dart';
import '../FBall/Domain/UseCase/UserPlayBallListUp/UserPlayBallListUpUseCase.dart';
import '../FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import '../ForutonaUser/Data/DataSource/PersonaSettingNoticeRemoteDataSource.dart';
import '../ForutonaUser/Domain/Repository/FUserRepository.dart';
import '../ForutonaUser/Domain/Repository/PersonaSettingNoticeRepository.dart';
import '../ForutonaUser/Domain/UseCase/Auth/PwAuthFromPhoneUseCase.dart';
import '../ForutonaUser/Domain/UseCase/Auth/PwFindEmailUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCase.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCase.dart';
import '../ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateForutonaUserUseCase.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/FireBaseCreateUserUseCase/FireBaseCreateUserUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import '../ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart';
import '../ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';
import '../ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import '../Tag/Domain/UseCase/RelationTagRankingFromTagNameOrderByBallPower/RelationTagRankingFromTagNameOrderByBallPowerUseCase.dart';
import '../Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCase.dart';
import '../Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCase.dart';
import '../Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseInputPort.dart';

final sl = GetIt.instance;

init() {
  sl.registerSingleton<Preference>(Preference());

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
          preference: sl(),
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

  sl.registerSingleton<FireBaseMessageTokenUpdateUseCaseInputPort>(
      FireBaseMessageTokenUpdateUseCase(fUserRepository: sl()));

  sl.registerSingleton<FireBaseMessageAdapter>(FireBaseMessageAdapterImpl(
      fireBaseAuthBaseAdapter: sl(),
      fireBaseMessageTokenUpdateUseCaseInputPort: sl()));

  sl.registerSingleton<FireBaseAuthAdapterForUseCase>(
      FireBaseAuthAdapterForUseCaseImpl(
          fireBaseMessageAdapter: sl(),
          fireBaseAuthBaseAdapter: sl(),
          fireBaseMessageTokenUpdateUseCaseInputPort: sl(),
          signInUserInfoUseCaseInputPort: sl()));

  sl.registerSingleton<AuthUserCaseInputPort>(
      FireBaseAuthUseCase(fireBaseAdapter: sl()));

  sl.registerSingleton<FBallRemoteDataSource>(FBallRemoteSourceImpl());

  sl.registerSingleton<FBallRepository>(
      FBallRepositoryImpl(fBallRemoteDataSource: sl()));

  sl.registerSingleton<IssueBallTypeRemoteDateSource>(
      IssueBallTypeRemoteDateSourceImpl());

  sl.registerSingleton<IssueBallTypeRepository>(IssueBallTypeRepositoryImpl(
      fireBaseAuthBaseAdapter: sl(), issueBallTypeRemoteDateSource: sl()));

  sl.registerSingleton<IssueBallUseCaseInputPort>(
      IssueBallUseCase(issueBallTypeRepository: sl()));

  sl.registerSingleton<FBallListUpFromInfluencePowerUseCaseInputPort>(
      FBallListUpFromInfluencePowerUseCase(fBallRepository: sl()));

  sl.registerSingleton<FBallTagRemoteDataSource>(
      FBallTagRemoteDataSourceImpl());

  sl.registerSingleton<TagRepository>(
      TagRepositoryImpl(fBallTagRemoteDataSource: sl()));

  sl.registerSingleton<TagRankingFromBallInfluencePowerUseCaseInputPort>(
      TagRankingFromBallInfluencePowerUseCase(tagRepository: sl()));

  sl.registerSingleton<ImageCropUtilInputPort>(ImageCropUtil());

  sl.registerSingleton<CommentChannelBaseServiceUseCaseInputPort>(
      FBallReplyFCMServiceUseCase(
          flutterLocalNotificationsPluginAdapter: sl(),
          fileDownLoaderUseCaseInputPort: sl(),
          signInUserInfoUseCaseInputPort: sl(),
          imageCropUtilInputPort: sl()),
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

  sl.registerFactoryParam<NotificationChannelBaseInputPort, String, String>(
      (String commentKey, param2) {
    if (commentKey == "CommentChannelUseCase") {
      return sl.get(instanceName: "CommentChannelUseCase");
    } else {
      return null;
    }
  }, instanceName: "NotificationChannelBaseInputPortFactory");

  sl.registerSingleton<PageMoveActionUseCaseInputPort>(
      ID001PageMoveAction(issueBallUseCaseInputPort: sl()),
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
      preference: sl(),
      fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<SnsLoginModuleAdapter>(FaceBookLoginAdapterImpl(),
      instanceName: "FaceBookLoginAdapter");

  sl.registerSingleton<SnsLoginModuleAdapter>(KakaoLoginAdapterImpl(),
      instanceName: "KakaoLoginAdapter");

  sl.registerSingleton<SnsLoginModuleAdapter>(NaverLoginAdapterImpl(),
      instanceName: "NaverLoginAdapter");

  sl.registerSingleton<SnsLoginModuleAdapter>(ForutonaLoginAdapterImpl(),
      instanceName: "ForutonaLoginAdapter");

  sl.registerSingleton<LoginUseCaseInputPort>(
      LoginUseCase(
          singUpUseCaseInputPort: sl(),
          fireBaseAuthAdapterForUseCase: sl(),
          snsLoginModuleAdapter: sl.get(instanceName: "FaceBookLoginAdapter")),
      instanceName: "LoginUseCaseFaceBook");

  sl.registerSingleton<LoginUseCaseInputPort>(
      LoginUseCase(
          singUpUseCaseInputPort: sl(),
          fireBaseAuthAdapterForUseCase: sl(),
          snsLoginModuleAdapter: sl.get(instanceName: "KakaoLoginAdapter")),
      instanceName: "LoginUseCaseKakao");

  sl.registerSingleton<LoginUseCaseInputPort>(
      LoginUseCase(
          singUpUseCaseInputPort: sl(),
          fireBaseAuthAdapterForUseCase: sl(),
          snsLoginModuleAdapter: sl.get(instanceName: "NaverLoginAdapter")),
      instanceName: "LoginUseCaseNaver");

  sl.registerFactoryParam<SnsLoginModuleAdapter, SnsSupportService, String>(
      (param1, param2) {
    if (param1 == SnsSupportService.Naver) {
      return sl.get(instanceName: "NaverLoginAdapter");
    } else if (param1 == SnsSupportService.Kakao) {
      return sl.get(instanceName: "KakaoLoginAdapter");
    } else if (param1 == SnsSupportService.FaceBook) {
      return sl.get(instanceName: "FaceBookLoginAdapter");
    } else if (param1 == SnsSupportService.Forutona) {
      return sl.get(instanceName: "ForutonaLoginAdapter");
    } else {
      return null;
    }
  }, instanceName: "SnsLoginModuleAdapter");

  sl.registerSingleton<LogoutUseCaseInputPort>(LogoutUseCase(
      signInUserInfoUseCaseInputPort: sl(),
      fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<UserInfoUpdateUseCaeInputPort>(
      UserInfoUpdateUseCase(fUserRepository: sl()));

  sl.registerSingleton<FlutterImageCompressAdapter>(
      FlutterImageCompressAdapterImpl());

  sl.registerSingleton<UserProfileImageUploadUseCaseInputPort>(
      UserProfileImageUploadUseCase(
          fUserRepository: sl(), flutterImageCompressAdapter: sl()));

  sl.registerSingleton<UserPasswordChangeUseCaseInputPort>(
      UserPasswordChangeUseCase(fUserRepository: sl()));

  sl.registerSingleton<CodeMainPageController>(CodeMainPageControllerImpl());

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

  sl.registerSingleton<PwAuthFromPhoneUseCaseInputPort>(
      PwAuthFromPhoneUseCase(phoneAuthRepository: sl()));

  sl.registerSingleton<FireBaseCreateUserUseCaseInputPort>(
      FireBaseCreateForutonaUserUseCase(fireBaseAuthAdapterForUseCase: sl()),
      instanceName: "FireBaseCreateForutonaUserUseCase");

  sl.registerSingleton<FireBaseCreateUserUseCaseInputPort>(
      FireBaseCreateEtcUserUseCase(),
      instanceName: "FireBaseCreateEtcUserUseCase");

  sl.registerFactoryParam<FireBaseCreateUserUseCaseInputPort, SnsSupportService,
      String>((param1, param2) {
    if (param1 == SnsSupportService.Forutona) {
      return sl.get(instanceName: "FireBaseCreateForutonaUserUseCase");
    } else {
      return sl.get(instanceName: "FireBaseCreateEtcUserUseCase");
    }
  }, instanceName: "FireBaseCreateUserUseCaseInputPort");

  sl.registerSingleton<PwFindPhoneUseCaseInputPort>(
      PwFindPhoneUseCase(phoneAuthRepository: sl()));

  sl.registerSingleton<PwFindEmailUseCaseInputPort>(
      PwFindEmailUseCase(fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<FBallPlayerRemoteDataSource>(
      FBallPlayerRemoteDataSourceImpl());

  sl.registerSingleton<FBallPlayerRepository>(
      FBallPlayerRepositoryImpl(fBallPlayerRemoteDataSource: sl()));

  sl.registerSingleton<UserPlayBallListUpUseCaseInputPort>(
      UserPlayBallListUpUseCase(fBallPlayerRepository: sl()));

  sl.registerSingleton<UserMakeBallListUpUseCaseInputPort>(
      UserMakeBallListUpUseCase(fBallRepository: sl()));



  sl.registerSingleton<FBallValuationRemoteDataSource>(
      FBallValuationRemoteDataSourceImpl());

  sl.registerSingleton<FBallValuationRepository>(FBallValuationRepositoryImpl(
      fireBaseAuthBaseAdapter: sl(), fBallValuationRemoteDataSource: sl()));

  sl.registerSingleton<IssueBallValuationUseCaseInputPort>(
      IssueBallValuationUseCase(fBallValuationRepository: sl()));

  sl.registerSingleton<UserInfoSimple1UseCaseInputPort>(UserInfoSimple1UseCase(
    fUserRepository: sl(),
  ));

  sl.registerSingleton<TagFromBallUuidUseCaseInputPort>(
      TagFromBallUuidUseCase(tagRepository: sl()));

  sl.registerSingleton<FBallListUpFromMapAreaUseCaseInputPort>(
      FBallListUpFromMapAreaUseCase(fBallRepository: sl()));

  sl.registerSingleton<MapScreenPositionUseCaseInputPort>(
      MapScreenPositionUseCase());

  sl.registerSingleton<BallSearchHistoryLocalDataSource>(
      BallSearchHistoryLocalDataSourceImpl());

  sl.registerSingleton<BallSearchBarHistoryRepository>(
      BallSearchBarHistoryRepositoryImpl(localDataSource: sl()));

  sl.registerSingleton<BallSearchBarHistoryUseCaseInputPort>(
      BallSearchBarHistoryUseCase(ballSearchBarHistoryRepository: sl()));

  sl.registerSingleton<FBallListUpFromSearchTitleUseCaseInputPort>(
      FBallListUpFromSearchTitleUseCase(fBallRepository: sl()));

  sl.registerSingleton<FBallListUpFromSearchTagNameUseCaseInputPort>(
      FBallListUpFromSearchTagNameUseCase(fBallRepository: sl()));

  sl.registerSingleton<
          RelationTagRankingFromTagNameOrderByBallPowerUseCaseInputPort>(
      RelationTagRankingFromTagNameOrderByBallPowerUseCase(
          tagRepository: sl()));

  sl.registerSingleton<FBallReplyDataSource>(FBallReplyDataSourceImpl());

  sl.registerSingleton<FBallReplyRepository>(FBallReplyRepositoryImpl(
      fBallReplyDataSource: sl(), fireBaseAuthBaseAdapter: sl()));

  sl.registerSingleton<FBallReplyUseCaseInputPort>(
      FBallReplyUseCase(fBallReplyRepository: sl()));

  sl.registerSingleton<UserPositionForegroundMonitoringUseCaseInputPort>(
      UserPositionForegroundMonitoringUseCase(
          geoLocationUtilBasicUseCaseInputPort: sl(),
          fUserRepository: sl(),
          fireBaseAuthAdapterForUseCase: sl()));
}
