import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Dto/UserPolicyResDto.dart';

class G022MainPageViewModel extends ChangeNotifier {
  final BuildContext? context;
  final String? policyTitle;
  final String? policyName;
  final UserPolicyUseCaseInputPort? _userPolicyUseCaseInputPort;

  UserPolicyResDto? userPolicyResDto;
  String? htmlUrl;

  G022MainPageViewModel(
      {required this.context,
      required this.policyTitle,
      required this.policyName,
      required UserPolicyUseCaseInputPort userPolicyUseCaseInputPort})
      : _userPolicyUseCaseInputPort = userPolicyUseCaseInputPort {
    init();
  }

  void init() async {
    userPolicyResDto = await _userPolicyUseCaseInputPort!.getUserPolicy(policyName!);
    _loadHtml(userPolicyResDto!.policyContent!);
    notifyListeners();
  }

  void onBackTap() {
    Navigator.of(context!).pop();
  }

  void _loadHtml(String html) {
    htmlUrl = new Uri.dataFromString('<html><body>$html</body></html>',
        mimeType: 'text/html', parameters: {'charset': 'utf-8'}).toString();
  }
}
