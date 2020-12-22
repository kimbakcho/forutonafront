import 'package:flutter/cupertino.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Repository/NoInterestBallRepository.dart';
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

  NoInterestBallUseCase({@required this.noInterestBallRepository});

  @override
  deleteByBallUuid(String s) async {
    return await noInterestBallRepository.deleteByBallUuid(s);
  }

  @override
  Future<bool> existsByBallUuid(String ballUuid) async {
    return await noInterestBallRepository.existsByBallUuid(ballUuid);
  }

  @override
  Future<List<String>> findByAll() async {
    return await noInterestBallRepository.findByAll();
  }

  @override
  save(String ballUuid) async {
    return await noInterestBallRepository.save(ballUuid);
  }

}