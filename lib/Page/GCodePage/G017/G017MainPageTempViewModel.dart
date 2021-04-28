import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/PersonaSettingNoticeResDto.dart';

class G017MainPageTempViewModel extends ChangeNotifier {
  final BuildContext? context;
  final int? idx;

  final PersonaSettingNoticeUseCaseInputPort?
      _personaSettingNoticeUseCaseInputPort;

  PersonaSettingNoticeResDto? personaSettingNoticeResDto;

  String htmlUrl = "";

  G017MainPageTempViewModel(
      {this.context,
      this.idx,
      required
          PersonaSettingNoticeUseCaseInputPort
              personaSettingNoticeUseCaseInputPort})
      : _personaSettingNoticeUseCaseInputPort =
            personaSettingNoticeUseCaseInputPort {
    init();
  }

  void init() async {
    personaSettingNoticeResDto = await _personaSettingNoticeUseCaseInputPort!
        .getPersonaSettingNoticePage(idx!);

    _loadHtml(personaSettingNoticeResDto!.noticeContent!);
    notifyListeners();
  }

  void _loadHtml(String html) {
    htmlUrl = new Uri.dataFromString('<html><body>$html</body></html>',
        mimeType: 'text/html', parameters: {'charset': 'utf-8'}).toString();
  }

  getNoticeName() {}

  void onBackTap() {
    Navigator.of(context!).pop();
  }
}
