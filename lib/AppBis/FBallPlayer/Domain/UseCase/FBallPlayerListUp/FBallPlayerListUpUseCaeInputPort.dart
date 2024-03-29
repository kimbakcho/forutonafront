import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBallPlayer/Domain/Repository/FBallPlayerRepository.dart';
import 'package:forutonafront/AppBis/FBallPlayer/Dto/FBallPlayerResDto.dart';
import 'package:injectable/injectable.dart';

abstract class FBallPlayerListUpInputPort {
  Future<PageWrap<FBallPlayerResDto>> userPlayBallListUp(
      String playUid, Pageable pageable,
      {FBallPlayerListUpOutputPort outputPort});
}

abstract class FBallPlayerListUpOutputPort {
  void searchResult(PageWrap<FBallPlayerResDto> listUpItem);
}
@LazySingleton(as: FBallPlayerListUpInputPort)
class FBallPlayerListUpUseCae implements FBallPlayerListUpInputPort {
  FBallPlayerRepository _fBallPlayerRepository;

  FBallPlayerListUpUseCae(
      {required FBallPlayerRepository fBallPlayerRepository})
      : _fBallPlayerRepository = fBallPlayerRepository;

  @override
  Future<PageWrap<FBallPlayerResDto>> userPlayBallListUp(
      String playerUid, Pageable pageable,
      {FBallPlayerListUpOutputPort? outputPort}) async {
    PageWrap<FBallPlayerResDto> userToPlayBallWrap =
        await _fBallPlayerRepository.getUserPlayBallList(playerUid,pageable);

    if (outputPort != null) {
      outputPort.searchResult(userToPlayBallWrap);
    }
    return userToPlayBallWrap;
  }
}
