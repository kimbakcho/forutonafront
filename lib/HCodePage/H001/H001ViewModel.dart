import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBIManager.dart';
import 'package:forutonafront/HCodePage/H001/H001Manager.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';

class H001ViewModel
    with ChangeNotifier implements H001Listener{

  H001Manager _h001manager;
  RankingTagListFromBIManager rankingTagListFromBIManager;

  H001ViewModel(){
    _h001manager = sl();
    rankingTagListFromBIManager = RankingTagListFromBIManager();
    _h001manager.subscribe(this);
  }

  @override
  void dispose() {
    _h001manager.unSubscribe(this);
    super.dispose();
  }

  @override
  Future<void> search(Position loadPosition) async {
    await rankingTagListFromBIManager.search(loadPosition);
  }

}
