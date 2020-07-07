import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/Background/Presentation/MainBackGround.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Adapter/LocationAdapter.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import 'package:forutonafront/Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import 'package:forutonafront/Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import 'package:forutonafront/Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/FaceBookLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/ForutonaLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/KakaoLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/NaverLoginAdapterImpl.dart';
import 'package:forutonafront/Common/SnsLoginMoudleAdapter/SnsLoginModuleAdapter.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/FireBaseMessage/Presentation/FireBaseMessageController.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BackGroundMessageUseCase/BackGroundMessageUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/BaseMessageUseCase/BaseMessageUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/FireBaseTokenUpdateUseCase/FireBaseMessageTokenUpdateUseCaseInputPort.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/LaunchMessageUseCase/LaunchMessageUseCase.dart';
import 'package:forutonafront/FireBaseMessage/UseCase/ResumeMessageUseCase/ResumeMessageUseCase.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCaeInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPasswordChangeUseCase/UserPasswordChangeUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/FUser/UserPasswordChangeUseCase/UserPasswordChangeUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Login/LoginUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Logout/LogoutUseCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/MainPage/CodeMainPageController.dart';
import 'package:forutonafront/Preference.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:get_it/get_it.dart';

import 'Background/BackgroundFetchAdapter/BackgroundFetchAdapter.dart';
import 'Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import 'Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import 'Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import 'Common/SignValid/FireBaseSignInUseCase/FireBaseSignInValidUseCase.dart';
import 'FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCase.dart';
import 'FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import 'ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'ForutonaUser/Domain/UseCase/FUser/UserInfoUpdateUseCase/UserInfoUpdateUseCase.dart';
import 'ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCase.dart';
import 'ForutonaUser/Domain/UseCase/FUser/UserProfileImageUploadUseCase/UserProfileImageUploadUseCaseInputPort.dart';
import 'ForutonaUser/Domain/UseCase/SignUp/SingUpUseCase.dart';
import 'ForutonaUser/Domain/UseCase/SignUp/SingUpUseCaseInputPort.dart';
import 'ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCase.dart';
import 'Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseInputPort.dart';

final sl = GetIt.instance;

init() {
  sl.registerSingleton<Preference>(Preference());

  sl.registerSingleton<GeolocatorAdapter>(GeolocatorAdapterImpl());

  sl.registerSingleton<LocationAdapter>(LocationAdapterImpl());

  sl.registerSingleton<SharedPreferencesAdapter>(
      SharedPreferencesAdapterImpl());

  sl.registerSingleton<GeoLocationUtilUseCaseInputPort>(GeoLocationUtilUseCase(
      geolocatorAdapter: sl(),
      locationAdapter: sl(),
      sharedPreferencesAdapter: sl(),
      preference: sl()));

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

  sl.registerFactory<BackgroundUserPositionUseCaseInputPort>(() =>
      BackgroundUserPositionUseCase(
          geoLocationUtilUseCaseInputPort: sl(),
          fUserRepository: sl(),
          fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<BackgroundFetchAdapter>(BackgroundFetchAdapter());

  sl.registerFactory<MainBackGround>(() => MainBackGroundImpl(
      backgroundFetchAdapter: sl(),
      backgroundUserPositionUseCaseInputPort: sl()));

  sl.registerSingleton<AuthUserCaseInputPort>(
      FireBaseAuthUseCase(fireBaseAdapter: sl()));

  sl.registerSingleton<FBallRemoteDataSource>(FBallRemoteSourceImpl());

  sl.registerSingleton<FBallRepository>(
      FBallRepositoryImpl(fBallRemoteDataSource: sl()));

  sl.registerSingleton<FBallListUpFromInfluencePowerUseCaseInputPort>(
      FBallListUpFromInfluencePowerUseCase(fBallRepository: sl()));

  sl.registerSingleton<FBallTagRemoteDataSource>(
      FBallTagRemoteDataSourceImpl());

  sl.registerSingleton<TagRepository>(
      TagRepositoryImpl(fBallTagRemoteDataSource: sl()));

  sl.registerSingleton<TagRankingFromBallInfluencePowerUseCaseInputPort>(
      TagRankingFromBallInfluencePowerUseCase(tagRepository: sl()));

  sl.registerSingleton<BaseMessageUseCaseInputPort>(BackGroundMessageUseCase(),
      instanceName: "BackGroundMessageUseCase");
  sl.registerSingleton<BaseMessageUseCaseInputPort>(LaunchMessageUseCase(),
      instanceName: "LaunchMessageUseCase");
  sl.registerSingleton<BaseMessageUseCaseInputPort>(BaseMessageUseCase(),
      instanceName: "BaseMessageUseCase");
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

  sl.registerSingleton<SingUpUseCaseInputPort>(
      SingUpUseCase(fUserRepository: sl()));

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
}
