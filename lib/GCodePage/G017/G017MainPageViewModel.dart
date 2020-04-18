import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/PersonaSettingNoticeRepository.dart';


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
    _loadHtml(personaSettingNoticeResDto.noticeContent);
    notifyListeners();
  }

  void _loadHtml(String html) {
    htmlUrl = new Uri.dataFromString(
            '<html><body>${html}</body></html>',
            mimeType: 'text/html',parameters:{'charset': 'utf-8'} )
        .toString();
  }

  getNoticeName() {}

  void onBackTap() {
    Navigator.of(_context).pop();
  }
}
