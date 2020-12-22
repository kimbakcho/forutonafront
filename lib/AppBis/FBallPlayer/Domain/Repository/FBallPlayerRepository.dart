import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/FBallPlayer/Dto/FBallPlayerResDto.dart';



abstract class FBallPlayerRepository {
  Future<PageWrap<FBallPlayerResDto>> getUserPlayBallList(String playerUid, Pageable pageable);
}