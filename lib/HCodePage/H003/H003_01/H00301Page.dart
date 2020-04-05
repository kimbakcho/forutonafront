import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:forutonafront/FBall/Dto/FBallType.dart';
import 'package:forutonafront/FBall/Dto/UserToPlayBallResDto.dart';
import 'package:forutonafront/FBall/Widget/IssueBall/Style2/IssueBallWidgetStyle2.dart';
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
            margin: EdgeInsets.only(bottom: 53.h),
              child: Stack(children: <Widget>[
            ListView.builder(
              controller: model.scrollController,
              physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return selectBallWidget(
                      model.userToPlayBallList.contents[index]);
                },
                itemCount: model.userToPlayBallList.contents.length)
          ]));
        }));
  }

  Widget selectBallWidget(UserToPlayBallResDto content) {
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
