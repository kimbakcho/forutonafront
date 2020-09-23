import 'package:flutter/material.dart';
import 'package:forutonafront/Common/FDio.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/FBallPlayer/Data/DataSource/FBallPlayerRemoteDataSource.dart';
import 'package:forutonafront/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/FBallPlayer/Dto/FBallPlayerResDto.dart';
import 'package:injectable/injectable.dart';


@LazySingleton(as: FBallPlayerRepository)
class FBallPlayerRepositoryImpl implements FBallPlayerRepository {
  final FBallPlayerRemoteDataSource _fBallPlayerRemoteDataSource;

  FBallPlayerRepositoryImpl(
      {@required FBallPlayerRemoteDataSource fBallPlayerRemoteDataSource})
      : _fBallPlayerRemoteDataSource = fBallPlayerRemoteDataSource;

  @override
  Future<PageWrap<FBallPlayerResDto>> getUserPlayBallList(
      String playerUid, Pageable pageable) async {
    return await _fBallPlayerRemoteDataSource.getUserPlayBallList(
        playerUid: playerUid,pageable: pageable, noneTokenFDio: FDio.noneToken());
  }


}
