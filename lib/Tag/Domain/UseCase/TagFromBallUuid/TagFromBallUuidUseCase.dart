import 'package:flutter/cupertino.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TagFromBallReqDto.dart';

import 'TagFromBallUuidUseCaseInputPort.dart';
import 'TagFromBallUuidUseCaseOutputPort.dart';

class TagFromBallUuidUseCase implements TagFromBallUuidUseCaseInputPort {
  final TagRepository _tagRepository;

  TagFromBallUuidUseCase({@required TagRepository tagRepository})
      : _tagRepository = tagRepository;

  @override
  Future<List<FBallTagResDto>> getTagFromBallUuid(
      {@required TagFromBallReqDto reqDto,
      TagFromBallUuidUseCaseOutputPort outputPort}) async {
    var fBallTagWrap = await _tagRepository.tagFromBallUuid(reqDto);
    var result =
        fBallTagWrap.tags.map((x) => FBallTagResDto.fromFBalltag(x)).toList();
    if (outputPort != null) {
      outputPort.onTagFromBallUuid(result);
    }

    return result;
  }
}
