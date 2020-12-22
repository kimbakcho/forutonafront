import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/FUserInfoSimpleResDto.dart';

abstract class UserInfoListUpUseCaseInputPort {
  Future<PageWrap<FUserInfoSimpleResDto>> search(Pageable pageable);
}