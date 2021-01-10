import 'package:flutter/material.dart';
import 'package:forutonafront/Common/SwitchWidget/SwitchStyle1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class G015MainPageTempViewModel extends ChangeNotifier {
  final BuildContext _context;

  bool isChatMessageAlarm = true;
  bool isMyContentReplyAlarm = true;
  bool isMyReplyReplyAlarm = true;
  bool isFollowNewContent = true;
  bool isSponsorNewContent = true;

  SwitchStyle1Controller chatAlarmSwitchController = new SwitchStyle1Controller();
  SwitchStyle1Controller myContentReplyAlarmSwitchController = new SwitchStyle1Controller();
  SwitchStyle1Controller myReplyReplyAlarmSwitchController = new SwitchStyle1Controller();
  SwitchStyle1Controller followNewContentSwitchController = new SwitchStyle1Controller();
  SwitchStyle1Controller sponsorNewContentSwitchController = new SwitchStyle1Controller();


  G015MainPageTempViewModel(this._context){
    init();
  }

  void init() async {
    // isChatMessageAlarm = await getAlarmSetting("ChatAlarmSetting");
    // chatAlarmSwitchController.moveSwitch(isChatMessageAlarm);
    // isMyContentReplyAlarm = await getAlarmSetting("MyContentReplyAlarm");
    // myContentReplyAlarmSwitchController.moveSwitch(isMyContentReplyAlarm);
    // isMyReplyReplyAlarm = await getAlarmSetting("MyReplyReplyAlarm");
    // myReplyReplyAlarmSwitchController.moveSwitch(isMyReplyReplyAlarm);
    // isFollowNewContent = await getAlarmSetting("FollowNewContent");
    // followNewContentSwitchController.moveSwitch(isFollowNewContent);
    // isSponsorNewContent = await getAlarmSetting("SponsorNewContent");
    // sponsorNewContentSwitchController.moveSwitch(isSponsorNewContent);
    notifyListeners();
  }

  Future<bool> getAlarmSetting(String key) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    bool chatAlarmSetting = true;
    if(!sharedPreferences.containsKey(key)){
      sharedPreferences.setBool(key,true);
      chatAlarmSetting = true;
    }else {
      chatAlarmSetting = sharedPreferences.getBool(key);
    }
    return chatAlarmSetting;
  }

  Future<bool> saveAlarmSetting(String key,bool value) async {
    var sharedPreferences = await SharedPreferences.getInstance();
    var chatAlarmSetting = sharedPreferences.setBool(key,value);
    return chatAlarmSetting;
  }

  void onChatAlarmChange(bool value) async {
    this.isChatMessageAlarm = value;
    await saveAlarmSetting("ChatAlarmSetting",value);
    notifyListeners();
  }
  void onMyContentReplyAlarmChange(bool value) async {
    this.isMyContentReplyAlarm = value;
    await saveAlarmSetting("MyContentReplyAlarm",value);
    notifyListeners();
  }
  void onMyReplyReplyAlarmChange(bool value) async {
    this.isMyReplyReplyAlarm = value;
    await saveAlarmSetting("MyReplyReplyAlarm",value);
    notifyListeners();
  }
  void onFollowNewContentChange(bool value)async  {
    this.isFollowNewContent = value;
    await saveAlarmSetting("FollowNewContent",value);
    notifyListeners();
  }
  void onSponsorNewContentChange(bool value) async{
    this.isSponsorNewContent = value;
    await saveAlarmSetting("SponsorNewContent",value);
    notifyListeners();
  }
  void onBackTap() {
    Navigator.of(_context).pop();
  }






}