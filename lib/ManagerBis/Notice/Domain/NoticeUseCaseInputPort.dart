import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ManagerBis/Notice/Domain/NoticeRepository.dart';
import 'package:forutonafront/ManagerBis/Notice/Dto/NoticeResDto.dart';
import 'package:injectable/injectable.dart';

abstract class NoticeUseCaseInputPort {
  Future<PageWrap<NoticeResDto>> getNotices(Pageable pageable);
}

@Injectable(as: NoticeUseCaseInputPort)
class NoticeUseCase implements NoticeUseCaseInputPort{

  NoticeRepository _noticeRepository;

  NoticeUseCase(this._noticeRepository);

  @override
  Future<PageWrap<NoticeResDto>> getNotices(Pageable pageable) async{
    return await _noticeRepository.findByAll(pageable);
  }


}