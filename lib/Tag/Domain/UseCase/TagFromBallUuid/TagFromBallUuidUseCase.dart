import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Data/DataSource/FBallTagRemoteDataSource.dart';
import 'package:forutonafront/Tag/Data/Entity/FBallTag.dart';
import 'package:forutonafront/Tag/Data/Repository/TagRepositoryImpl.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';

import 'TagFromBallUuidUseCaseInputPort.dart';
import 'TagFromBallUuidUseCaseOutputPort.dart';

class TagFromBallUuidUseCase implements TagFromBallUuidUseCaseInputPort{

  TagRepository _tagRepository = TagRepositoryImpl(fBallTagRemoteDataSource: FBallTagRemoteDataSourceImpl());

  @override
  Future<List<FBallTagResDto>> getTagFromBallUuid({@required TagFromBallReqDto reqDto,
    TagFromBallUuidUseCaseOutputPort outputPort}) async {
    var fBallTagWrap = await _tagRepository.tagFromBallUuid(reqDto);
    var result = fBallTagWrap.tags.map((x) => FBallTagResDto.fromFBalltag(x)).toList();
    outputPort.onTagFromBallUuid(result);
    return result;
  }

}