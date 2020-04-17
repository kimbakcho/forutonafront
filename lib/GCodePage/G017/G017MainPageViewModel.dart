import 'package:flutter/material.dart';
import 'package:forutonafront/Common/PersonaSettingNotice/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/Common/PersonaSettingNotice/Repository/PersonaSettingNoticeRepository.dart';

class G017MainPageViewModel extends ChangeNotifier {
  final BuildContext _context;
  int _idx;
  PersonaSettingNoticeResDto personaSettingNoticeResDto;
  PersonaSettingNoticeRepository _personaSettingNoticeRepository =
      PersonaSettingNoticeRepository();
  String htmlUrl = "";

  G017MainPageViewModel(this._context, this._idx) {
    init();
  }

  void init() async {
    personaSettingNoticeResDto =
        await _personaSettingNoticeRepository.getPersonaSettingNoticePage(_idx);
    htmlUrl = new Uri.dataFromString(
            '<html><body>${personaSettingNoticeResDto.noticeContent}</body></html>',
            mimeType: 'text/html',parameters:{'charset': 'utf-8'} )
        .toString();
    notifyListeners();
  }

  getNoticeName() {}

  void onBackTap() {
    Navigator.of(_context).pop();
  }
}
