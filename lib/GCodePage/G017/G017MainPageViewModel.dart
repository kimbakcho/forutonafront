import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/PersonaSettingNotice.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/PersonaSettingNotice/PersonaSettingNoticeUseCaseInputPort.dart';


class G017MainPageViewModel extends ChangeNotifier {
  final BuildContext context;
  final int idx;

  final PersonaSettingNoticeUseCaseInputPort
      _personaSettingNoticeUseCaseInputPort;

  PersonaSettingNotice personaSettingNoticeResDto;

  String htmlUrl = "";

  G017MainPageViewModel(
      {this.context,
      this.idx,
      @required
          PersonaSettingNoticeUseCaseInputPort
              personaSettingNoticeUseCaseInputPort})
      : _personaSettingNoticeUseCaseInputPort =
            personaSettingNoticeUseCaseInputPort {
    init();
  }

  void init() async {
    personaSettingNoticeResDto =
        PersonaSettingNotice.fromPersonaSettingNoticeResDto(
            await _personaSettingNoticeUseCaseInputPort
                .getPersonaSettingNoticePage(idx));

    _loadHtml(personaSettingNoticeResDto.noticeContent);
    notifyListeners();
  }

  void _loadHtml(String html) {
    htmlUrl = new Uri.dataFromString('<html><body>${html}</body></html>',
        mimeType: 'text/html', parameters: {'charset': 'utf-8'}).toString();
  }

  getNoticeName() {}

  void onBackTap() {
    Navigator.of(context).pop();
  }
}
