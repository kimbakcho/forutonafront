import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/Repository/FUserRepository.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';

import '../UserInfoListUpUseCaseInputPort.dart';

class UserNickNameWithFullTextMatchIndexUseCase
    implements UserInfoListUpUseCaseInputPort {
  final String searchText;

  final FUserRepository fUserRepository;

  UserNickNameWithFullTextMatchIndexUseCase(
      {required this.searchText, required this.fUserRepository});

  @override
  Future<PageWrap<FUserInfoSimpleResDto>> search(Pageable pageable) async {
    return await fUserRepository.findByUserNickNameWithFullTextMatchIndex(
        searchText, pageable);
  }
}
