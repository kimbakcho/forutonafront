import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:injectable/injectable.dart';

abstract class NoInterestBallUseCaseInputPort {
  save(String ballUuid);
  Future<List<String>> findByAll();
  Future<bool>  existsByBallUuid(String ballUuid);
  deleteByBallUuid(String s);
}

@LazySingleton(as: NoInterestBallUseCaseInputPort)
class NoInterestBallUseCase extends NoInterestBallUseCaseInputPort {
  final NoInterestBallRepository noInterestBallRepository;
  final SignInUserInfoUseCaseInputPort signInUserInfoUseCaseInputPort;

  NoInterestBallUseCase({required this.noInterestBallRepository,required this.signInUserInfoUseCaseInputPort});

  @override
  deleteByBallUuid(String s) async {
    String uid = "";
    if(signInUserInfoUseCaseInputPort.isLogin!){
      uid=signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!.uid!;
    }
    return await noInterestBallRepository.deleteByBallUuid(s,uid);
  }

  @override
  Future<bool> existsByBallUuid(String ballUuid) async {
    String uid = "";
    if(signInUserInfoUseCaseInputPort.isLogin!){
      uid=signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!.uid!;
    }
    return await noInterestBallRepository.existsByBallUuid(ballUuid,uid);
  }

  @override
  Future<List<String>> findByAll() async {
    String uid = "";
    if(signInUserInfoUseCaseInputPort.isLogin!){
      uid=signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!.uid!;
    }
    return await noInterestBallRepository.findByAll(uid);
  }

  @override
  save(String ballUuid) async {
    String uid = "";
    if(signInUserInfoUseCaseInputPort.isLogin!){
      uid=signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!.uid!;
    }
    return await noInterestBallRepository.save(ballUuid,uid);
  }

}