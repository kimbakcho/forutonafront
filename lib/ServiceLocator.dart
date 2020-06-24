import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/Background/Presentation/MainBackGround.dart';
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
import 'package:forutonafront/ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:get_it/get_it.dart';

import 'Background/BackgroundFetchAdapter/BackgroundFetchAdapter.dart';
import 'Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCase.dart';
import 'FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';

import 'ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import 'Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCase.dart';
import 'Tag/Domain/UseCase/TagRankingFromBallInfluencePower/TagRankingFromBallInfluencePowerUseCaseInputPort.dart';

final sl = GetIt.instance;

init() {
  sl.registerSingleton<GeoLocationUtilUseCaseInputPort>(GeoLocationUtilUseCase());

  sl.registerSingleton<FireBaseAuthBaseAdapter>(FireBaseAuthBaseAdapterImpl());

  sl.registerSingleton<FUserRemoteDataSource>(FUserRemoteDataSourceImpl());

  sl.registerSingleton<FUserRepository>(
      FUserRepositoryImpl(fireBaseAuthBaseAdapter: sl(), fUserRemoteDataSource: sl()));

  sl.registerSingleton<FireBaseMessageTokenUpdateUseCaseInputPort>(FireBaseMessageTokenUpdateUseCase(fUserRepository: sl()));

  sl.registerSingleton<FireBaseMessageAdapter>(FireBaseMessageAdapterImpl(
      fireBaseAuthBaseAdapter: sl(),
      fireBaseMessageTokenUpdateUseCaseInputPort: sl()
  ));

  sl.registerSingleton<FireBaseAuthAdapterForUseCase>(FireBaseAuthAdapterForUseCaseImpl(
    fireBaseMessageAdapter: sl(),
    fireBaseAuthBaseAdapter: sl(),
    fireBaseMessageTokenUpdateUseCaseInputPort: sl()
  ));

  sl.registerFactory<BackgroundUserPositionUseCaseInputPort>(() =>
      BackgroundUserPositionUseCase(
          geoLocationUtilUseCaseInputPort: sl(),
          fUserRepository: sl(),
          fireBaseAuthAdapterForUseCase: sl()));

  sl.registerSingleton<BackgroundFetchAdapter>(BackgroundFetchAdapter());

  sl.registerFactory<MainBackGround>(
      () => MainBackGroundImpl(backgroundFetchAdapter: sl()));

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



  sl.registerSingleton<BaseMessageUseCaseInputPort>(BackGroundMessageUseCase(),instanceName: "BackGroundMessageUseCase");
  sl.registerSingleton<BaseMessageUseCaseInputPort>(LaunchMessageUseCase(),instanceName: "LaunchMessageUseCase");
  sl.registerSingleton<BaseMessageUseCaseInputPort>(BaseMessageUseCase(),instanceName: "BaseMessageUseCase");
  sl.registerSingleton<BaseMessageUseCaseInputPort>(ResumeMessageUseCase(),instanceName: "ResumeMessageUseCase");


  sl.registerSingleton<FireBaseMessageController>(FireBaseMessageController(
    baseMessageUseCase: sl.get(instanceName: "BaseMessageUseCase"),
    launchMessageUseCase: sl.get(instanceName: "LaunchMessageUseCase"),
    resumeMessageUseCase: sl.get(instanceName: "ResumeMessageUseCase"),
    fireBaseMessageAdapter: sl(),
  ));


}
