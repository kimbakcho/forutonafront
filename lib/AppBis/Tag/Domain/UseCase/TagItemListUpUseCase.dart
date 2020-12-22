import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';

abstract class TagItemListUpUseCaseInputPort {

  Position searchPosition;

  Future<PageWrap<FBallTagResDto>> search(Pageable pageable);
}