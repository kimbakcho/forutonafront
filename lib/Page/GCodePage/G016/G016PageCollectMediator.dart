import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/Common/SearchCollectMediator/SearchCollectMediator.dart';
import 'package:forutonafront/ManagerBis/Notice/Domain/NoticeUseCaseInputPort.dart';
import 'package:forutonafront/ManagerBis/Notice/Dto/NoticeResDto.dart';

class G016PageCollectMediator extends SearchCollectMediator<NoticeResDto>{


  NoticeUseCaseInputPort _noticeUseCaseInputPort;


  G016PageCollectMediator(this._noticeUseCaseInputPort);

  @override
  bool isNullSearchUseCase() {
    if(_noticeUseCaseInputPort == null){
      return true;
    }else {
      return false;
    }
  }

  @override
  Future<PageWrap<NoticeResDto>> searchUseCase(Pageable pageable) async {
    pageable.sort = "modifyDate,DESC";
    var pageWrap = await _noticeUseCaseInputPort.getNotices(pageable);
     return pageWrap;
  }


}