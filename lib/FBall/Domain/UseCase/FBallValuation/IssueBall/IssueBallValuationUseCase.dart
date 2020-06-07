import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Data/DataStore/FBallValuationRemoteDataSource.dart';
import 'package:forutonafront/FBall/Data/Entity/FBallValuationWrap.dart';
import 'package:forutonafront/FBall/Data/Repository/FBallValuationRepositoryImpl.dart';
import 'package:forutonafront/FBall/Domain/Repository/FBallValuationRepository.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallValuation/FBallValuationResDto.dart';

import 'IssueBallValuationUseCaseInputPort.dart';
import 'IssueBallValuationUseCaseOutputPort.dart';

class IssueBallValuationUseCase implements IssueBallValuationUseCaseInputPort {
  FBallValuationRepository _fBallValuationRepository =
      FBallValuationRepositoryImpl(
          fBallValuationRemoteDataSource: FBallValuationRemoteDataSourceImpl());

  Future<void> deleteFBallValuation({@required String valueUuid,int deletePoint,IssueBallValuationUseCaseOutputPort outputPort}) async {
    if(outputPort != null){
      outputPort.onDeleteFBallValuation(deletePoint);
    }
    await _fBallValuationRepository.deleteFBallValuation(valueUuid: valueUuid);
  }

  @override
  Future<FBallValuationResDto> getFBallValuation({@required FBallValuationReqDto reqDto,IssueBallValuationUseCaseOutputPort outputPort}) async{
    FBallValuationWrap fBallValuationWrap = await _fBallValuationRepository.getFBallValuation(reqDto: reqDto);
    FBallValuationResDto fBallValuationResDto;
    if(fBallValuationWrap.hasFBallValuation()){
      fBallValuationResDto = FBallValuationResDto.fromFBallValuation(fBallValuationWrap.getFBallValuation());
    }
    if(outputPort != null){
      outputPort.onFBallValuation(fBallValuationResDto);
    }
    return fBallValuationResDto;
  }

  @override
  Future<FBallValuationResDto> save({@required FBallValuationInsertReqDto reqDto,IssueBallValuationUseCaseOutputPort outputPort}) async{

    var tempFBallValuation = FBallValuationResDto.fromFBallValuationInsertReqDto(reqDto);
    if(outputPort != null){
      outputPort.onSave(tempFBallValuation);
    }
    var fBallValuation = await _fBallValuationRepository.save(reqDto: reqDto);

    var fBallValuationResDto = FBallValuationResDto.fromFBallValuation(fBallValuation);
    return fBallValuationResDto;
  }

}
