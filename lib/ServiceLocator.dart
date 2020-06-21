import 'package:forutonafront/Background/Domain/UseCase/BackgroundUserPositionUseCaseInputPort.dart';
import 'package:forutonafront/Background/Presentation/MainBackGround.dart';
import 'package:forutonafront/Common/FireBaseAdapter/FireBaseAdapter.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallRepository.dart';
import 'package:forutonafront/ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import 'package:forutonafront/ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/AuthUserCaseInputPort.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/Auth/FireBaseAuthUseCase.dart';
import 'package:get_it/get_it.dart';

import 'Background/BackgroundFetchAdapter/BackgroundFetchAdapter.dart';
import 'Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCase.dart';
import 'Common/Geolocation/Domain/UseCases/GeoLocationUtilUseCaseInputPort.dart';
import 'FBall/Domain/UseCase/FBallListUpFromInfluencePower/FBallListUpFromInfluencePowerUseCaseInputPort.dart';
import 'ForutonaUser/Domain/Repository/FUserRepository.dart';

final sl = GetIt.instance;
  init(){
    sl.registerSingleton<GeoLocationUtilUseCaseInputPort>(GeoLocationUtilUseCase());
    sl.registerSingleton<FireBaseAdapter>(FireBaseAdapter());
    sl.registerSingleton<FUserRemoteDataSource>(FUserRemoteDataSourceImpl());
    sl.registerSingleton<FUserRepository>(FUserRepositoryImpl(fireBaseAdapter: sl(),fUserRemoteDataSource: sl()));
    sl.registerFactory<BackgroundUserPositionUseCaseInputPort>(() => BackgroundUserPositionUseCase(geoLocationUtilUseCaseInputPort: sl(),fUserRepository: sl(),fireBaseAdapter: sl()));
    sl.registerSingleton<BackgroundFetchAdapter>(BackgroundFetchAdapter());
    sl.registerFactory<MainBackGround>(() => MainBackGroundImpl(backgroundFetchAdapter: sl()));

    sl.registerSingleton<AuthUserCaseInputPort>(FireBaseAuthUseCase(fireBaseAdapter: sl()));

    sl.registerSingleton<FBallRemoteDataSource>(FBallRemoteSourceImpl());
    sl.registerSingleton<FBallRepository>(FBallRepositoryImpl(fBallRemoteDataSource:sl()));

  }