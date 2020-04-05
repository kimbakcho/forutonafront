import 'package:flutter/material.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/UserToMakerBallReqDto.dart';
import 'package:forutonafront/FBall/Dto/UserToMakerBallResDto.dart';
import 'package:forutonafront/FBall/Widget/IssueBall/Style2/IssueBallWidgetStyle2.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'H00302PageViewModel.dart';

class H00302Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var viewModel = Provider.of<H00302PageViewModel>(context);
    return ChangeNotifierProvider.value(
        value: viewModel,
        child: Consumer<H00302PageViewModel>(builder: (_, model, child) {
          return Container(
              margin: EdgeInsets.only(bottom: 53.h),
              child: Stack(children: <Widget>[
                ListView.builder(
                    controller: model.scrollController,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return selectBallWidget(
                          model.userToMakerBallList.contents[index]);
                    },
                    itemCount: model.userToMakerBallList.contents.length)
              ]));
        }));
  }
  Widget selectBallWidget(UserToMakerBallResDto content) {
    if (content.fBallType == FBallType.IssueBall) {
      return IssueBallWidgetStyle2(content);
    } else if (content.fBallType == FBallType.QuestBall) {
      return Container(
        child: Text("Quest"),
      );
    } else {
      return Container(child: Text("don't know"));
    }
  }
}
