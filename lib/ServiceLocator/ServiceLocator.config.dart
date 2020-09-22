// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../Common/AndroidIntentAdapter/AndroidIntentAdapter.dart';
import '../Common/AvatarIamgeMaker/AvatarImageMakerUseCase.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyInputPort.dart';
import '../Common/GoogleServey/UseCase/BaseGoogleServey/BaseGoogleSurveyUseCase.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/BaseOpenTalk/BaseOpenTalkInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelBaseServiceUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/CommentChannelUseCase.dart';
import '../FBall/Data/DataStore/FBallRemoteDataSource.dart';
import '../Common/Notification/NotiChannel/Domain/CommentChannel/Service/FBallReplyFCMServiceUseCase.dart';
import '../ForutonaUser/Data/DataSource/FUserRemoteDataSource.dart';
import '../ForutonaUser/Domain/Repository/FUserRepository.dart';
import '../ForutonaUser/Data/Repository/FUserRepositoryImpl.dart';
import '../Common/FileDownLoader/FileDownLoaderUseCaseInputPort.dart';
import '../ForutonaUser/FireBaseAuthAdapter/FireBaseAuthAdapterForUseCase.dart';
import '../ForutonaUser/FireBaseAuthAdapter/FireBaseAuthBaseAdapter.dart';
import '../FireBaseMessage/Adapter/FireBaseMessageAdapter.dart';
import '../Common/FlutterImageCompressAdapter/FlutterImageCompressAdapter.dart';
import '../Common/FlutterLocalNotificationPluginAdapter/FlutterLocalNotificationsPluginAdapter.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCase.dart';
import '../Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import '../Common/Geolocation/Adapter/GeolocatorAdapter.dart';
import '../Common/GoogleServey/UseCase/GoogleProposalOnServiceSurvey/GoogleProposalOnServiceSurveyUseCase.dart';
import '../Common/GoogleServey/UseCase/GoogleSurveyErrorReport/GoogleSurveyErrorReportUseCase.dart';
import '../Common/ImageCropUtil/ImageUtilInputPort.dart';
import '../Common/KakaoTalkOpenTalk/UseCase/InquireAboutAnything/InquireAboutAnythingUseCase.dart';
import '../Common/Geolocation/Adapter/LocationAdapter.dart';
import '../Common/GoogleMapSupport/MapBallMarkerFactory.dart';
import '../Common/GoogleMapSupport/MapBitmapDescriptorUseCaseInputPort.dart';
import '../Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import '../Common/MapScreenPosition/MapScreenPositionUseCase.dart';
import '../Common/MapScreenPosition/MapScreenPositionUseCaseInputPort.dart';
import '../Common/Notification/NotiChannel/NotificationChannelBaseInputPort.dart';
import '../Preference.dart';
import '../Common/SharedPreferencesAdapter/SharedPreferencesAdapter.dart';
import '../ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCase.dart';
import '../ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import '../ForutonaUser/Domain/UseCase/FUser/UpdateFCMTokenUseCase/UpdateFCMTokenUseCaseInputPort.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  gh.factory<AndroidIntentAdapter>(() => AndroidIntentAdapterImpl());
  gh.factory<BaseGoogleSurveyInputPort>(() => BaseGoogleSurveyUseCase(),
      instanceName: 'BaseGoogleSurveyUseCase');
  gh.factory<BaseGoogleSurveyInputPort>(
      () => GoogleProposalOnServiceSurveyUseCase(),
      instanceName: 'GoogleProposalOnServiceSurveyUseCase');
  gh.factory<BaseGoogleSurveyInputPort>(() => GoogleSurveyErrorReportUseCase(),
      instanceName: 'GoogleSurveyErrorReportUseCase');
  gh.factory<BaseOpenTalkInputPort>(() => InquireAboutAnythingUseCase());
  gh.factory<FBallRemoteDataSource>(() => FBallRemoteSourceImpl());
  gh.factory<FUserRemoteDataSource>(() => FUserRemoteDataSourceImpl());
  gh.factory<FileDownLoaderUseCaseInputPort>(() => FileDownLoaderUseCase());
  gh.factory<FireBaseAuthBaseAdapter>(() => FireBaseAuthBaseAdapterImpl());
  gh.factory<FlutterImageCompressAdapter>(
      () => FlutterImageCompressAdapterImpl());
  gh.factory<FlutterLocalNotificationsPluginAdapter>(
      () => FlutterLocalNotificationsPluginAdapterImpl());
  gh.factory<GeolocatorAdapter>(() => GeolocatorAdapterImpl());
  gh.factory<ImageUtilInputPort>(() => ImageAvatarUtil(),
      instanceName: 'ImageAvatarUtil');
  gh.factory<ImageUtilInputPort>(() => ImageBorderAvatarUtil(),
      instanceName: 'ImageBorderAvatarUtil');
  gh.factory<ImageUtilInputPort>(() => ImagePngResizeUtil(),
      instanceName: 'ImagePngResizeUtil');
  gh.factory<LocationAdapter>(() => LocationAdapterImpl());
  gh.factory<MapBitmapDescriptorUseCaseInputPort>(() =>
      MapBitmapDescriptorUseCase(
        imagePngResizeUtil: get<ImageUtilInputPort>(),
        imageBorderAvatarUtil: get<ImageUtilInputPort>(),
        fileDownLoaderUseCaseInputPort: get<FileDownLoaderUseCaseInputPort>(),
      ));
  gh.factory<MapScreenPositionUseCaseInputPort>(
      () => MapScreenPositionUseCase());
  gh.factory<NotificationChannelBaseInputPort>(() => CommentChannelUseCase());
  gh.factory<Preference>(() => Preference());
  gh.factory<SharedPreferencesAdapter>(() => SharedPreferencesAdapterImpl());
  gh.factory<AvatarImageMakerUseCaseInputPort>(() => AvatarImageMakerUseCase(
      fileDownLoaderUseCaseInputPort: get<FileDownLoaderUseCaseInputPort>(),
      imageUtilInputPort: get<ImageUtilInputPort>()));
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
  gh.factory<SignInUserInfoUseCaseInputPort>(
      () => SignInUserInfoUseCase(fUserRepository: get<FUserRepository>()));
  gh.factory<UpdateFCMTokenUseCaseInputPort>(
      () => UpdateFCMTokenUseCase(fUserRepository: get<FUserRepository>()));
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
  gh.factory<FireBaseMessageAdapter>(() => FireBaseMessageAdapterImpl(
        signInUserInfoUseCaseInputPort: get<SignInUserInfoUseCaseInputPort>(),
        fireBaseAuthBaseAdapter: get<FireBaseAuthBaseAdapter>(),
        updateFCMTokenUseCaseInputPort: get<UpdateFCMTokenUseCaseInputPort>(),
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
  gh.factory<MapBallMarkerFactory>(() => MapBallMarkerFactory(
      mapMakerDescriptorContainer: get<MapMakerDescriptorContainer>()));
  return get;
}
