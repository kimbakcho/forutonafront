import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/PersonaSettingNoticeRepository.dart';

import 'package:forutonafront/GCodePage/G017/G017MainPage.dart';

class G016MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  PersonaSettingNoticeRepository _personaSettingNoticeRepository =
      new PersonaSettingNoticeRepository();
  List<PersonaSettingNoticeResDto> notice = [];
  Pageable _pageable = Pageable(0, 10, "noticeWriteDateTime,DESC");
  ScrollController mainScrollController = new ScrollController();

  G016MainPageViewModel(this._context) {
    mainScrollController.addListener(onScrollListener);
    init();
  }

  init() async {
    _pageable.page = 0;
    _pageable.size = 10;
    _pageable.sort = "noticeWriteDateTime,DESC";
    var wrapDto = await _personaSettingNoticeRepository
        .getPersonaSettingNotice(_pageable);
    notice = wrapDto.content;
    notifyListeners();
  }

  onScrollListener() async {
    if (mainScrollController.offset >=
            mainScrollController.position.maxScrollExtent &&
        !mainScrollController.position.outOfRange) {
      _pageable.page++;
      if (_pageable.page * _pageable.size > notice.length) {
        return;
      } else {
        var wrapDto = await _personaSettingNoticeRepository
            .getPersonaSettingNotice(_pageable);
        if (_pageable.page == 0) {
          notice = wrapDto.content;
        } else {
          notice.addAll(wrapDto.content);
        }
      }
    }
  }

  void onBackTap() {
    Navigator.of(_context).pop();
  }

  void goNoticePageInner(int idx) {
    Navigator.of(_context).push(MaterialPageRoute(builder: (_){
      return G017MainPage(idx);
    }));
  }
}
