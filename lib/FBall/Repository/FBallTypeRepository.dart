import 'package:forutonafront/FBall/Dto/FBallInsertReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallJoinReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Repository/Impl/IssueBallTypeRepository.dart';

abstract class FBallTypeRepository<T1 extends FBallInsertReqDto,T2 extends FBallResDto> {
  Future<int> insertBall(T1 reqDto);
  Future<T2> selectBall(FBallReqDto reqDto);
  Future<int> updateBall(T1 reqDto);
  Future<int> deleteBall(FBallReqDto reqDto);
  Future<int> joinBall(FBallJoinReqDto reqDto);
  Future<int> ballHit(FBallReqDto reqDto);
  factory FBallTypeRepository.create(FBallType fBallType){
    if(fBallType == FBallType.IssueBall){
      FBallTypeRepository<FBallInsertReqDto,FBallResDto> instance = IssueBallTypeRepository();
      return instance;
    }else if(fBallType == FBallType.QuestBall){
      return null;
    }else {
      return null;
    }
  }

}