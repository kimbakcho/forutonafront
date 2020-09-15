import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Components/TagList/RankingTagListFromBI.dart';
import 'package:forutonafront/HCodePage/H001/BallListMediator.dart';
import 'package:forutonafront/HCodePage/H001/H001ViewModel.dart';
import 'package:forutonafront/MainPage/BottomNavigation.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class H001Page extends StatelessWidget {
  final BallListMediator _influencePowerBallListMediator;

  H001Page({BallListMediator influencePowerBallListMediator})
      : _influencePowerBallListMediator = influencePowerBallListMediator;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => H001ViewModel(
            context: context,
            fireBaseAuthAdapterForUseCase: sl(),
            geoLocationUtilUseCaseInputPort: sl(),
            influencePowerBallListMediator: _influencePowerBallListMediator),
        child: Consumer<H001ViewModel>(builder: (_, model, __) {
          return Stack(children: <Widget>[
            Scaffold(
                body: Container(
                    color: Color(0xfff2f0f1),
                    child: Stack(children: <Widget>[
                      Column(
                        children: <Widget>[
                          RankingTagListFromBI(),
                          Expanded(
                            child: ListView.builder(
                              itemBuilder: (_, index) {
                                return Container(
                                    key: Key(model.ballList[index].ballUuid),
                                    child: FlatButton(
                                      onPressed: (){
                                        model.moveDetailPage(index);
                                      },
                                        child: Text(
                                      model.ballList[index].ballUuid,
                                    )));
                              },
                              itemCount: model.ballList.length,
                            ),
                          ),
                          BottomNavigation()
                        ],
                      ),
                      model.isLoading ? CommonLoadingComponent() : Container()
                    ])))
          ]);
        }));
  }


}
