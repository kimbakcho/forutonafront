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
      {@required String ballUuid,
      TagFromBallUuidUseCaseOutputPort outputPort}) async {
    List<FBallTagResDto> results = await _tagRepository.tagFromBallUuid(ballUuid);
    if (outputPort != null) {
      outputPort.onTagFromBallUuid(results);
    }
    return results;
  }
}
