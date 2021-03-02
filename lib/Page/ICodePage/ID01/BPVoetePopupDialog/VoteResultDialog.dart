import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/Value/LikeActionType.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteReqDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class VoteResultDialog extends StatefulWidget {
  final int initPoint;

  final int effectPoint;

  final int likeVote;

  final int disLikeVote;

  final ValuationMediator valuationMediator;

  final String ballUuid;

  const VoteResultDialog(
      {Key key,
      this.initPoint,
      this.effectPoint,
      this.valuationMediator,
      this.likeVote,
      this.disLikeVote,
      this.ballUuid})
      : super(key: key);

  @override
  _VoteResultDialogState createState() => _VoteResultDialogState();
}

class _VoteResultDialogState extends State<VoteResultDialog> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => VoteResultDialogViewModel(
            widget.initPoint,
            widget.valuationMediator,
            widget.likeVote,
            widget.disLikeVote,
            widget.ballUuid),
        child: Consumer<VoteResultDialogViewModel>(builder: (_, model, child) {
          return Container(
              height: 261,
              child: Column(children: [
                Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  constraints: BoxConstraints(maxHeight: 36),
                  alignment: Alignment.centerLeft,
                  child: Text("영향력 행사",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                      )),
                ),
                Divider(
                  height: 1,
                  color: Color(0xffCCCCCC),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
                  constraints: BoxConstraints(maxHeight: 36),
                  alignment: Alignment.centerLeft,
                  child: Text("영향력이 높을수록 더 멀리 전파됩니다.",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(children: [
                  Container(
                      margin: EdgeInsets.only(left: 16, right: 16),
                      child: Text("${model.initPoint} BP",
                          style: GoogleFonts.notoSans(
                            fontSize: 22,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                            height: 0.9090909090909091,
                          ))),
                  Container(
                    child: Icon(
                      Icons.forward,
                      color: Color(0xffB8B8B8),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 16),
                      child: Text("${model.nextPoint} BP",
                          style: GoogleFonts.notoSans(
                            fontSize: 22,
                            color: const Color(0xff000000),
                            fontWeight: FontWeight.w700,
                            height: 0.9090909090909091,
                          )))
                ]),
                Spacer(),
                Material(
                  color: Color(0xffE6F3FF),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      children: [
                        Expanded(
                            child: Container(
                          child: Text("확인",
                              style: GoogleFonts.notoSans(
                                fontSize: 15,
                                color: const Color(0xff007eff),
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333333333,
                              )),
                          alignment: Alignment.center,
                          height: 50,
                        ))
                      ],
                    ),
                  ),
                )
              ]));
        }));
  }
}

class VoteResultDialogViewModel extends ChangeNotifier {
  final int initPoint;

  int nextPoint;

  final ValuationMediator valuationMediator;

  final int likeVote;

  final int disLikeVote;

  final String ballUuid;

  VoteResultDialogViewModel(this.initPoint, this.valuationMediator,
      this.likeVote, this.disLikeVote, this.ballUuid) {
    nextPoint = initPoint;
    updateNextPoint();
  }

  updateNextPoint() {
    Future.delayed(Duration(milliseconds: 500), () async {
      FBallVoteReqDto fBallVoteReqDto = FBallVoteReqDto();
      fBallVoteReqDto.ballUuid= ballUuid;
      fBallVoteReqDto.likeActionType  = LikeActionType.Vote;
      fBallVoteReqDto.disLikePoint = disLikeVote;
      fBallVoteReqDto.likePoint = likeVote;
      FBallVoteResDto fBallVoteResDto = await valuationMediator.voteAction(fBallVoteReqDto);
      nextPoint = fBallVoteResDto.ballPower;
      notifyListeners();
    });
  }
}
