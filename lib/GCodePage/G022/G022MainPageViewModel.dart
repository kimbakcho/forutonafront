import 'package:flutter/material.dart';
import 'package:forutonafront/ForutonaUser/Dto/UserPolicyResDto.dart';
import 'package:forutonafront/ForutonaUser/Repository/UserPolicyRepository.dart';

class G022MainPageViewModel extends ChangeNotifier{
  final BuildContext _context;
  final String policyTitle;
  final String _policyName;
  UserPolicyRepository _userPolicyRepository = new UserPolicyRepository();
  UserPolicyResDto userPolicyResDto;
  String htmlUrl;

  G022MainPageViewModel(this._context,this.policyTitle,this._policyName){
    init();

  }
  void init() async {
    userPolicyResDto = await _userPolicyRepository.getPersonaSettingNotice(_policyName);
    _loadHtml(userPolicyResDto.policyContent);
    notifyListeners();
  }
  void onBackTap() {
    Navigator.of(_context).pop();
  }


  void _loadHtml(String html) {
    htmlUrl = new Uri.dataFromString(
        '<html><body>${html}</body></html>',
        mimeType: 'text/html',parameters:{'charset': 'utf-8'} )
        .toString();
  }
}