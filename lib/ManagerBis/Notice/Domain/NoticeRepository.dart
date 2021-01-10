import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ManagerBis/Notice/Dto/NoticeResDto.dart';

abstract class NoticeRepository {
  Future<PageWrap<NoticeResDto>> findByAll(Pageable pageable);
}