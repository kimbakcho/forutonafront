import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Page/Dto/PageWrap.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/Page/GCodePage/G017/G017MainPageTemp.dart';

class G016MainPageTempViewModel extends ChangeNotifier {
  final BuildContext context;

  final PersonaSettingNoticeUseCaseInputPort
      _personaSettingNoticeUseCaseInputPort;

  List<PersonaSettingNoticeResDto> notice = [];
  Pageable _pageable = Pageable(page:0,size: 10,sort: "noticeWriteDateTime,DESC");
  final ScrollController mainScrollController;

  G016MainPageTempViewModel(
      {required
          this.context,
      required
          PersonaSettingNoticeUseCaseInputPort
              personaSettingNoticeUseCaseInputPort,
      required
          this.mainScrollController})
      : _personaSettingNoticeUseCaseInputPort =
            personaSettingNoticeUseCaseInputPort {
    mainScrollController.addListener(onScrollListener);
    init();
  }

  init() async {
    _pageable.page = 0;
    _pageable.size = 10;
    _pageable.sort = "noticeWriteDateTime,DESC";
    PageWrap<PersonaSettingNoticeResDto> wrapDto =
        await _personaSettingNoticeUseCaseInputPort
            .getPersonaSettingNotice(_pageable);
    notice = wrapDto.content!;
    notifyListeners();
  }

  onScrollListener() async {
    if (mainScrollController.offset >=
            mainScrollController.position.maxScrollExtent &&
        !mainScrollController.position.outOfRange) {
      _pageable.page = _pageable.page! + 1;
      var wrapDto = await _personaSettingNoticeUseCaseInputPort
          .getPersonaSettingNotice(_pageable);
      if (wrapDto.last!) {
        return;
      } else if (wrapDto.first!) {
        notice = wrapDto.content!;
      } else {
        notice.addAll(wrapDto.content!);
      }
    }
  }

  void onBackTap() {
    Navigator.of(context).pop();
  }

  void goNoticePageInner(int idx) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return G017MainPageTemp(idx);
    }));
  }
}
