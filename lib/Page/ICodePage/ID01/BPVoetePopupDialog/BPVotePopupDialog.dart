import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import 'VoteButton.dart';
import 'VoteResultDialog.dart';


class BPVotePopupDialog extends StatelessWidget {
  final FBallResDto fBallResDto;

  final ValuationMediator valuationMediator;

  const BPVotePopupDialog({Key key, this.fBallResDto, this.valuationMediator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => BPVotePopupDialogViewModel(fBallResDto,valuationMediator,sl(),sl()),
        child: Consumer<BPVotePopupDialogViewModel>(builder: (_, model, child) {
          return Container(
              height: 460,
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
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  constraints: BoxConstraints(maxHeight: 36),
                  alignment: Alignment.centerLeft,
                  child: Text("현재 영향력",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(model.bPointStr,
                      style: GoogleFonts.notoSans(
                        fontSize: 22,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        height: 0.9090909090909091,
                      )),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  alignment: Alignment.centerLeft,
                  child: Text("내가 행사한 영향력",
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff2f3035),
                      )),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(16, 0, 16, 0),
                  alignment: Alignment.centerLeft,
                  child: Text(model.usePointStr(),
                      style: GoogleFonts.notoSans(
                        fontSize: 22,
                        color: const Color(0xff000000),
                        fontWeight: FontWeight.w700,
                        height: 0.9090909090909091,
                      )),
                ),
                SizedBox(height: 16,),
                Divider(
                  height: 1,
                  color: Color(0xffCCCCCC),
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding:
                        EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
                    child: Text.rich(TextSpan(
                        text: "사용 가능한 영향   ",
                        style: GoogleFonts.notoSans(
                          fontSize: 14,
                          color: const Color(0xff5b5b5b),
                          height: 0.6428571428571429,
                        ),
                        children: [
                          TextSpan(
                              text: '${model.aValidPoint} BP',
                              style: GoogleFonts.notoSans(
                                fontSize: 14,
                                color: const Color(0xff000000),
                                fontWeight: FontWeight.w700,
                                height: 1.4285714285714286,
                              )),
                        ]))),
                SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    VoteButton(
                      backGroundColor: Color(0xffE6F3FF),
                      borderLineColor: Color(0xff007EFF),
                      labelColor: Color(0xff007EFF),
                      onClick: () {},
                      mainIcon: Icons.upload_outlined,
                      mainIconColor: Color(0xff007EFF),
                      labelText: "영향력 Up",
                      voteButtonViewController: model.plusVoteButtonViewController,
                      isCanPlus: model.isCanPlus
                    ),
                    VoteButton(
                      backGroundColor: Color(0xffFFF1F7),
                      borderLineColor: Color(0xffFF4F9A),
                      labelColor: Color(0xffFF4F9A),
                      onClick: () {},
                      mainIcon: Icons.download_outlined,
                      mainIconColor: Color(0xffFF4F9A),
                      labelText: "영향력 Down",
                      voteButtonViewController: model.minusVoteButtonViewController,
                      isCanPlus: model.isCanPlus
                    )
                  ],
                ),
                SizedBox(height: 33),
                Divider(
                  height: 1,
                ),
                Row(
                  children: [
                    Expanded(
                        child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Color(0xffE4E7E8)))),
                          child: Text("취소",
                              style: GoogleFonts.notoSans(
                                fontSize: 15,
                                color: const Color(0xff454f63),
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333333333,
                              )),
                        ),
                      ),
                    )),
                    Expanded(
                        child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          model.updateBP(context);
                        },
                        child: Container(
                          height: 50,
                          alignment: Alignment.center,
                          child: Text("영향력 행사",
                              style: GoogleFonts.notoSans(
                                fontSize: 15,
                                color: model.hasEffectPoint ? Color(0xff454f63) : Color(0xffB8B8B8),
                                fontWeight: FontWeight.w500,
                                height: 1.3333333333333333,
                              )),
                        ),
                      ),
                    ))
                  ],
                )
              ]));
        }));
  }
}

class BPVotePopupDialogViewModel extends ChangeNotifier {

  final FBallResDto fBallResDto;

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final FBallValuationUseCaseInputPort _fBallValuationUseCaseInputPort;

  int initPoint;


  int aValidPoint = 0;

  VoteButtonViewController plusVoteButtonViewController;
  VoteButtonViewController minusVoteButtonViewController;

  FBallVoteResDto ballVoteResDto;

  bool isLoaded = false;

  final ValuationMediator valuationMediator;

  BPVotePopupDialogViewModel(this.fBallResDto, this.valuationMediator, this._signInUserInfoUseCaseInputPort,this._fBallValuationUseCaseInputPort){
    initPoint = fBallResDto.ballPower;
    plusVoteButtonViewController = new VoteButtonViewController(
      onCurrentPointChange: _plusCurrentPointChange
    );
    minusVoteButtonViewController = new VoteButtonViewController(
      onCurrentPointChange: _minusCurrentPointChange
    );
    init();
  }

  init() async {
    isLoaded = false;
    ballVoteResDto = await this._fBallValuationUseCaseInputPort.getBallVoteState(fBallResDto.ballUuid);
    isLoaded = true;
    notifyListeners();
  }


  bool isCanPlus() {
    if(plusVoteButtonViewController != null && minusVoteButtonViewController !=null){
      var useTicket = plusVoteButtonViewController.getCurrentPoint().abs() + minusVoteButtonViewController.getCurrentPoint().abs();
       if( useTicket <  _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory().influenceTicket){
         return true;
       }
    }
    return false;

  }

  _plusCurrentPointChange(int value){
    notifyListeners();
  }

  _minusCurrentPointChange(int value){
    notifyListeners();
  }

  bool get hasEffectPoint{
    return plusVoteButtonViewController.getCurrentPoint() + minusVoteButtonViewController.getCurrentPoint() > 0 ? true: false;
  }

  String get bPointStr {
    return '${fBallResDto.ballPower} BP';
  }

  String usePointStr() {
    if(isLoaded){
      return '${ballVoteResDto.ballLike + ballVoteResDto.ballDislike} BP';
    }else {
      return "0 BP";
    }

  }


  updateBP(BuildContext context){
    showMaterialModalBottomSheet(
        context: context,
        builder: (context) {
          return VoteResultDialog(
            initPoint: fBallResDto.ballPower,
            likeVote: plusVoteButtonViewController.getCurrentPoint(),
            disLikeVote: minusVoteButtonViewController.getCurrentPoint(),
            ballUuid: fBallResDto.ballUuid,
            valuationMediator: valuationMediator,
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        backgroundColor: Colors.white);

  }

}
