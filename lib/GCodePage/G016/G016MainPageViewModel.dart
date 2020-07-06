import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PageableDto/Pageable.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:forutonafront/GCodePage/G017/G017MainPage.dart';

class G016MainPageViewModel extends ChangeNotifier {
  final BuildContext context;

  final PersonaSettingNoticeUseCaseInputPort
      _personaSettingNoticeUseCaseInputPort;

  List<PersonaSettingNotice> notice = [];
  Pageable _pageable = Pageable(0, 10, "noticeWriteDateTime,DESC");
  final ScrollController mainScrollController;

  G016MainPageViewModel(
      {@required
          this.context,
      @required
          PersonaSettingNoticeUseCaseInputPort
              personaSettingNoticeUseCaseInputPort,
      @required
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
    var wrapDto = await _personaSettingNoticeUseCaseInputPort
        .getPersonaSettingNotice(_pageable);
    notice = wrapDto.content
        .map((x) => PersonaSettingNotice.fromPersonaSettingNoticeResDto(x))
        .toList();
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
        var wrapDto = await _personaSettingNoticeUseCaseInputPort
            .getPersonaSettingNotice(_pageable);
        if (_pageable.page == 0) {
          notice = wrapDto.content
              .map(
                  (x) => PersonaSettingNotice.fromPersonaSettingNoticeResDto(x))
              .toList();
        } else {
          notice.addAll(wrapDto.content
              .map(
                  (x) => PersonaSettingNotice.fromPersonaSettingNoticeResDto(x))
              .toList());
        }
      }
    }
  }

  void onBackTap() {
    Navigator.of(context).pop();
  }

  void goNoticePageInner(int idx) {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return G017MainPage(idx);
    }));
  }
}
