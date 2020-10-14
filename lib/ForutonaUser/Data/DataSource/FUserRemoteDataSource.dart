import 'package:dio/dio.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Domain/Entity/FUserInfo.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserAccountUpdateReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinReqDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/FUserSnsCheckJoinResDto.dart';
import 'package:forutonafront/ForutonaUser/Dto/SnsSupportService.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPositionUpdateReqDto.dart';
import 'package:google_maps_flutter_platform_interface/src/types/location.dart';
import 'package:http_parser/http_parser.dart';
import 'package:injectable/injectable.dart';

abstract class FUserRemoteDataSource {
  Future<void> updateUserPosition(LatLng latLng, FDio tokenFDio);

  Future<void> updateFireBaseMessageToken(String token, FDio tokenFDio);

  Future<bool> checkNickNameDuplication(String nickName, FDio noneTokenFDio);

  Future<String> uploadUserProfileImage(List<int> imageByte, FDio tokenFDio);

  Future<FUserInfoResDto> updateAccountUserInfo(
      FUserAccountUpdateReqDto reqDto, FDio tokenFDio);

  Future<void> pWChange(String pw, FDio tokenFDio);

  Future<FUserSnsCheckJoinResDto> getSnsUserJoinCheckInfo(
      SnsSupportService snsService, String accessToken, FDio noneTokenFDio);

  Future<FUserInfoJoinResDto> joinUser(
      FUserInfoJoinReqDto reqDto, FDio noneTokenFDio);

  Future<FUserInfo> findByMe(FDio tokenFDio);

  Future<PageWrap<FUserInfoSimpleResDto>> getUserNickNameWithFullTextMatchIndex(
      String searchNickName, Pageable pageable, FDio noneTokenFDio);
}

@LazySingleton(as: FUserRemoteDataSource)
class FUserRemoteDataSourceImpl implements FUserRemoteDataSource {
  @override
  Future<void> updateUserPosition(LatLng latLng, FDio tokenFDio) async {
    await tokenFDio.put("/v1/FUserInfo/UserPosition",
        data: UserPositionUpdateReqDto(
          lng: latLng.longitude,
          lat: latLng.latitude,
        ).toJson());
  }

  @override
  Future<void> updateFireBaseMessageToken(String token, FDio tokenFDio) async {
    await tokenFDio.put("/v1/FUserInfo/FireBaseMessageToken",
        queryParameters: {"token": token});
  }

  @override
  Future<bool> checkNickNameDuplication(
      String nickName, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get(
        "/v1/FUserInfo/CheckNickNameDuplication",
        queryParameters: {"nickName": nickName});
    return response.data;
  }

  @override
  Future<String> uploadUserProfileImage(
      List<int> imageByte, FDio tokenFDio) async {
    FormData formData = FormData.fromMap({
      "ProfileImage": MultipartFile.fromBytes(imageByte,
          contentType: MediaType("image", "jpeg"), filename: "ProfileImage.jpg")
    });
    var response =
        await tokenFDio.put("/v1/FUserInfo/ProfileImage", data: formData);
    return response.data;
  }

  @override
  Future<FUserInfoResDto> updateAccountUserInfo(
      FUserAccountUpdateReqDto reqDto, FDio tokenFDio) async {
    var response = await tokenFDio.put("/v1/FUserInfo/AccountUserInfo",
        data: reqDto.toJson());
    return FUserInfoResDto.fromJson(response.data);
  }

  @override
  Future<int> pWChange(String pw, FDio tokenFDio) async {
    var response = await tokenFDio
        .put("/v1/FUserInfo/PwChange", queryParameters: {"pw": pw});
    return response.data;
  }

  @override
  Future<FUserSnsCheckJoinResDto> getSnsUserJoinCheckInfo(
      SnsSupportService snsService,
      String accessToken,
      FDio noneTokenFDio) async {
    var response = await noneTokenFDio.get("/v1/FUserInfo/SnsUserJoinCheckInfo",
        queryParameters: {
          "snsService": snsService,
          "accessToken": accessToken
        });
    return FUserSnsCheckJoinResDto.fromJson(response.data);
  }

  @override
  Future<FUserInfoJoinResDto> joinUser(
      FUserInfoJoinReqDto reqDto, FDio noneTokenFDio) async {
    var response = await noneTokenFDio.post("/v1/FUserInfo/JoinUser",
        data: reqDto.toJson());
    return FUserInfoJoinResDto.fromJson(response.data);
  }

  @override
  Future<FUserInfo> findByMe(FDio tokenFDio) async {
    var response = await tokenFDio.get("/v1/FUserInfo");
    return FUserInfo.fromJson(response.data);
  }

  @override
  Future<PageWrap<FUserInfoSimpleResDto>> getUserNickNameWithFullTextMatchIndex(
      String searchNickName, Pageable pageable, FDio noneTokenFDio) async {
    var params = pageable.toJson();
    params["searchNickName"] = searchNickName;
    var response = await noneTokenFDio.get("/v1/FUserInfo/UserNickNameWithFullTextMatchIndex",
        queryParameters: params);
    return PageWrap.fromJson(response.data, FUserInfoSimpleResDto.fromJson);
  }
}
