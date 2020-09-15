import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'RankingTagListFromBIManager.dart';

class RankingTagListFromBI extends StatelessWidget {

  final RankingTagListFromBIManager rankingTagListFromBIManager;
  RankingTagListFromBI({this.rankingTagListFromBIManager});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RankingTagListFromBIViewModel(rankingTagListFromBIManager: rankingTagListFromBIManager),
      child: Consumer<RankingTagListFromBIViewModel>(
        builder: (_,model,__){
          return Container(child: Text("Test"));
        }
      )
    );
  }
}

class RankingTagListFromBIViewModel extends ChangeNotifier implements RankingTagListFromBIListener{

  RankingTagListFromBIManager rankingTagListFromBIManager;
  RankingTagListFromBIViewModel({this.rankingTagListFromBIManager}){
    if(rankingTagListFromBIManager != null){
      rankingTagListFromBIManager.subscribe(this);
    }
  }


  @override
  void dispose() {
    if(rankingTagListFromBIManager != null){
      rankingTagListFromBIManager.unSubscribe(this);
    }
    super.dispose();
  }

  @override
  search() {
    // TODO: implement search
    throw UnimplementedError();
  }


}
