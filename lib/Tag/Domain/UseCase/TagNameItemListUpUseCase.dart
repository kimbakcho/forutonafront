import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Tag/Domain/Repository/TagRepository.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Tag/Dto/TextMatchTagBallReqDto.dart';

import 'TagItemListUpUseCase.dart';

class TagNameItemListUpUseCase implements TagItemListUpUseCaseInputPort {

  final TextMatchTagBallReqDto reqDto;
  
  final TagRepository tagRepository;
  
  TagNameItemListUpUseCase( {this.reqDto,this.tagRepository});

  @override
  Future<PageWrap<FBallTagResDto>> search(Pageable pageable) async {
    searchPosition = Position(latitude: reqDto.mapCenterLatitude,longitude: reqDto.mapCenterLongitude);
    return await tagRepository.findByTagItem(reqDto, pageable);
  }

  @override
  Position searchPosition;

}