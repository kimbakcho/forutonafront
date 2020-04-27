import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2Support.dart';
import 'package:provider/provider.dart';

import 'H00302PageViewModel.dart';

class H00302Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<H00302PageViewModel>(context);
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<H00302PageViewModel>(builder: (_, model, child) {
          return Container(
              margin: EdgeInsets.only(bottom: 53),
              child: Stack(children: <Widget>[
                ListView.builder(
                    controller: model.scrollController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return BallStyle2Support.selectBallWidget(
                          model.userToMakerBallList.contents[index]);
                    },
                    itemCount: model.userToMakerBallList.contents.length)
              ]));
        }));
  }

}
