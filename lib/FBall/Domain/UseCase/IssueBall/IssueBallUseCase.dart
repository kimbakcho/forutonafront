import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:forutonafront/FBall/Data/DataStore/IssueBallTypeRemoteDateSource.dart';
import 'package:forutonafront/FBall/Data/Repository/IssueBallTypeRepositoryImpl.dart';
import 'package:forutonafront/FBall/Data/Value/FBallType.dart';
import 'package:forutonafront/FBall/Domain/Repository/IssueBallTypeRepository.dart';
import 'package:forutonafront/FBall/Dto/IssueBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/IssueBallUpdateReqDto.dart';
import 'package:forutonafront/ICodePage/IM001/BallImageItemDto.dart';
import 'package:forutonafront/ServiceLocator.dart';
import 'IssueBallUseCaseInputPort.dart';
import 'IssueBallUseCaseOutputPort.dart';

class IssueBallUseCase implements IssueBallUseCaseInputPort {
  IssueBallTypeRepository _issueBallTypeRepository =
      new IssueBallTypeRepositoryImpl(
        fireBaseAuthBaseAdapter: sl(),
          issueBallTypeRemoteDateSource: new IssueBallTypeRemoteDateSourceImpl());

  @override
  Future<int> ballHit({@required FBallReqDto reqDto,@required IssueBallUseCaseOutputPort outputPort}) async {
    if(outputPort != null){
      outputPort.onBallHit();
    }
    return await _issueBallTypeRepository.ballHit(reqDto);
  }

  @override
  Future<int> joinBall({@required FBallJoinReqDto reqDto}) async{
    return await _issueBallTypeRepository.joinBall(reqDto);
  }

  @override
  Future<FBallResDto> selectBall({@required String ballUuid,@required IssueBallUseCaseOutputPort outputPort}) async{
    FBallReqDto fBallReqDto = FBallReqDto(FBallType.IssueBall, ballUuid);
    var fBall = await _issueBallTypeRepository.selectBall(fBallReqDto);
    var result = FBallResDto.fromFBall(fBall);
    if(outputPort != null){
      outputPort.onSelectBall(result);
    }
    return result;
  }

  @override
  Future<int> deleteBall({String ballUuid,@required IssueBallUseCaseOutputPort outputPort}) async{
    FBallReqDto fBallReqDto = FBallReqDto(FBallType.IssueBall, ballUuid);

    var result = await _issueBallTypeRepository.deleteBall(fBallReqDto);
    if(outputPort != null){
      outputPort.onDeleteBall();
    }
    return result;
  }

  @override
  Future<List<BallImageItemDto>> ballImageListUpLoadAndFillUrls({List<BallImageItemDto> refSrcList}) async {
    List<Uint8List> images = [];
    List<BallImageItemDto> uploadListImageItemDto = [];
    for (var o in refSrcList) {
      if (o.imageByte != null) {
        var image = await decodeImageFromList(o.imageByte);
        var compressImage = await FlutterImageCompress.compressWithList(
          o.imageByte,
          minHeight: image.height.toInt(),
          minWidth: image.width.toInt(),
          quality: 70,
        );
        images.add(Uint8List.fromList(compressImage));
        uploadListImageItemDto.add(o);
      }
    }
    //이미지 업로드 해서 URL 가져옴
    var fBallImageUploadResDto = await _issueBallTypeRepository.ballImageUpload(images: images);
    for (int i = 0; i < fBallImageUploadResDto.urls.length; i++) {
      uploadListImageItemDto[i].imageUrl = fBallImageUploadResDto.urls[i];
    }
    return refSrcList;
  }

  @override
  Future<FBallResDto> insertBall({@required IssueBallInsertReqDto reqDto,@required IssueBallUseCaseOutputPort outputPort}) async {
    var saveFBall = await _issueBallTypeRepository.insertBall(reqDto);
    var result = FBallResDto.fromFBall(saveFBall);
    if(outputPort != null){
      outputPort.onInsertBall(result);
    }
    return result;
  }

  @override
  Future<int> updateBall({@required IssueBallUpdateReqDto reqDto,@required IssueBallUseCaseOutputPort outputPort}) async {
    var result = await _issueBallTypeRepository.updateBall(reqDto);
    if(outputPort != null){
      outputPort.onUpdateBall();
    }
    return result;
  }

}
