import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01BallTitle/ID01BallTitle.dart';
import 'package:forutonafront/Page/ICodePage/ID01/ID01Component/ID01RemainTimeWidget.dart';

import 'package:provider/provider.dart';

class ID01MainBottomSheetBody extends StatefulWidget {
  final FBallResDto fBallResDto;

  final double topPosition;

  const ID01MainBottomSheetBody({Key key, this.fBallResDto, this.topPosition}) : super(key: key);

  @override
  _ID01MainBottomSheetBodyState createState() =>
      _ID01MainBottomSheetBodyState();
}

class _ID01MainBottomSheetBodyState extends State<ID01MainBottomSheetBody> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainBottomSheetBodyViewModel(widget.fBallResDto),
      child: Consumer<ID01MainBottomSheetBodyViewModel>(
          builder: (_, model, child) {
        return Container(
          height: widget.topPosition,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ID01RemainTimeWidget(
                  limitTime: model.fBallResDto.activationTime,
                ),
                ID01BallTitle(fBallResDto: model.fBallResDto)

              ],
            ),
          )

        );
      }),
    );
  }
}

class ID01MainBottomSheetBodyViewModel extends ChangeNotifier {
  final FBallResDto fBallResDto;

  ID01MainBottomSheetBodyViewModel(this.fBallResDto);
}
