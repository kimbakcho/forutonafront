import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Data/Value/UserPolicy.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCase.dart';
import 'package:forutonafront/ForutonaUser/Domain/UseCase/UserPolicy/UserPolicyUseCaseInputPort.dart';

class G022MainPageViewModel extends ChangeNotifier {
  final BuildContext context;
  final String policyTitle;
  final String policyName;
  final UserPolicyUseCaseInputPort _userPolicyUseCaseInputPort;

  UserPolicy userPolicy;
  String htmlUrl;

  G022MainPageViewModel(
      {@required this.context,
      @required this.policyTitle,
      @required this.policyName,
      @required UserPolicyUseCaseInputPort userPolicyUseCaseInputPort})
      : _userPolicyUseCaseInputPort = userPolicyUseCaseInputPort {
    init();
  }

  void init() async {
    userPolicy = UserPolicy.fromUserPolicyResDto(
        await _userPolicyUseCaseInputPort.getUserPolicy(policyName));
    _loadHtml(userPolicy.policyContent);
    notifyListeners();
  }

  void onBackTap() {
    Navigator.of(context).pop();
  }

  void _loadHtml(String html) {
    htmlUrl = new Uri.dataFromString('<html><body>${html}</body></html>',
        mimeType: 'text/html', parameters: {'charset': 'utf-8'}).toString();
  }
}
