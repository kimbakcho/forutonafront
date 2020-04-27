import 'package:flutter/material.dart';

import 'package:forutonafront/FBall/Widget/BallStyle/Style2/BallStyle2Support.dart';

import 'package:forutonafront/HCodePage/H003/H003_01/H00301PageViewModel.dart';
import 'package:provider/provider.dart';

class H00301Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<H00301PageViewModel>(context);
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<H00301PageViewModel>(builder: (_, model, child) {
          return Container(
            margin: EdgeInsets.only(bottom: 53),
              child: Stack(children: <Widget>[
            ListView.builder(
              controller: model.scrollController,
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return BallStyle2Support.selectBallWidget(
                      model.userToPlayBallList.contents[index]);
                },
                itemCount: model.userToPlayBallList.contents.length)
          ]));
        }));
  }


}
