import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01BallTitle/ID01LimitTag.dart';
import 'package:provider/provider.dart';

class ID01BallTitle extends StatelessWidget {

  final FBallResDto fBallResDto;

  const ID01BallTitle({Key key, this.fBallResDto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01BallTitleViewModel(fBallResDto),
      child: Consumer<ID01BallTitleViewModel>(
        builder: (_, model, child) {
          return Container(
            padding: EdgeInsets.only(left: 16,right: 16,bottom: 16),
            child: Column(
              children: [
                ID01LimitTag(ballUuid: model.fBallResDto.ballUuid)
              ],
            ),
          );
        },
      ),
    );
  }
}

class ID01BallTitleViewModel extends ChangeNotifier {

  final FBallResDto fBallResDto;

  ID01BallTitleViewModel(this.fBallResDto);

}
