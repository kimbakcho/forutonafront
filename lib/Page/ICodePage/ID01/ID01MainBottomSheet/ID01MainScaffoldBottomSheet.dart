import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/Page/ICodePage/ID01/BPVoetePopupDialog/BPVotePopupDialog.dart';
import 'package:forutonafront/Page/LCodePage/L001/L001BottomSheet/BottomSheet/L001BottomSheet.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ID01MainScaffoldBottomSheet extends StatefulWidget {
  final FBallResDto fBallResDto;

  final ValuationMediator valuationMediator;

  ID01MainScaffoldBottomSheet(
      {Key key, this.fBallResDto, this.valuationMediator})
      : super(key: key);

  @override
  _ID01MainScaffoldBottomSheetState createState() =>
      _ID01MainScaffoldBottomSheetState();
}

class _ID01MainScaffoldBottomSheetState
    extends State<ID01MainScaffoldBottomSheet>
    with SingleTickerProviderStateMixin {
  Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = createTicker((Duration elapsed) {
      setState(() {});
    });
    _ticker.start();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID01MainScaffoldBottomSheetViewModel(
            widget.fBallResDto, sl(), widget.valuationMediator),
        child: Consumer<ID01MainScaffoldBottomSheetViewModel>(
            builder: (_, model, child) {
          return Container(
              height: 50,
              color: Colors.white.withOpacity(0.7),
              child: Row(children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: "준비중입니다.");
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
                      child: Icon(Icons.card_giftcard),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: "준비중입니다.");
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(8, 16, 8, 16),
                      child: Icon(Icons.share),
                    ),
                  ),
                ),
                Spacer(),
                Material(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.transparent,
                    child: InkWell(
                      customBorder: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        side: BorderSide(color: Color(0xff3A3E3F), width: 1),
                      ),
                      onTap: () {
                        model.voteAction(context);
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.only(right: 16),
                            padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                            decoration: BoxDecoration(
                                color: model.userInfluenceTicketCount <= 0
                                    ? Colors.black.withOpacity(0.5)
                                    : Colors.transparent,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                border: Border.all(
                                    color: Color(0xff3A3E3F), width: 1)),
                            child: Row(
                              children: [
                                Container(
                                  child: Icon(Icons.how_to_vote),
                                  margin: EdgeInsets.only(right: 8),
                                ),
                                Text('${model.userInfluenceTicketCount}')
                              ],
                            ),
                          ),
                          model.userInfluenceTicketCount <= 0
                              ? Positioned(
                                  right: 16,
                                  child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: Text(
                                      model.modelNextTicketRemainTime(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ))
              ]));
        }));
  }
}

class ID01MainScaffoldBottomSheetViewModel extends ChangeNotifier
    implements ValuationMediatorComponent {
  final FBallResDto fBallResDto;

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final ValuationMediator valuationMediator;

  ID01MainScaffoldBottomSheetViewModel(this.fBallResDto,
      this._signInUserInfoUseCaseInputPort, this.valuationMediator);

  bool syncLoadingFlag = false;

  syncUserInfo() async {
    syncLoadingFlag = true;
    if (_signInUserInfoUseCaseInputPort.isLogin) {
      await _signInUserInfoUseCaseInputPort
          .saveSignInInfoInMemoryFromAPiServer();
      notifyListeners();
    }
    syncLoadingFlag = false;
  }

  showVotePopupDialog(BuildContext context) async {
    await showMaterialModalBottomSheet(
        context: context,
        builder: (context) {
          return BPVotePopupDialog(
            fBallResDto: fBallResDto,
            valuationMediator: valuationMediator,
          );
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0))),
        backgroundColor: Colors.white);
    syncUserInfo();
  }

  modelNextTicketRemainTime() {
    if (!_signInUserInfoUseCaseInputPort.isLogin) {
      return "";
    }
    var nextGiveInfluenceTicketTime = _signInUserInfoUseCaseInputPort
        .reqSignInUserInfoFromMemory()
        .nextGiveInfluenceTicketTime;
    var difference = nextGiveInfluenceTicketTime.difference(DateTime.now());
    if (difference.isNegative) {
      if (syncLoadingFlag == false) {
        syncUserInfo();
      }
      return "";
    } else if (difference.inHours > 1) {
      return '${difference.inHours} h';
    } else if (difference.inHours <= 1) {
      return '${(difference.inSeconds / 60).toInt().toString().padLeft(2, '0')}:${(difference.inSeconds % 60).toString().padLeft(2, '0')}';
    }
  }

  int get userInfluenceTicketCount {
    if (_signInUserInfoUseCaseInputPort.isLogin) {
      return _signInUserInfoUseCaseInputPort
          .reqSignInUserInfoFromMemory()
          .influenceTicket;
    } else {
      return 0;
    }
  }

  @override
  String ballUuid;

  @override
  valuationReqNotification() {
    syncUserInfo();
  }

  void voteAction(BuildContext context) async {
    if (_signInUserInfoUseCaseInputPort.isLogin) {
      if (userInfluenceTicketCount > 0) {
        showVotePopupDialog(context);
      } else {
        Fluttertoast.showToast(msg: "영향력이 부족합니다.");
      }
    } else {
      await showMaterialModalBottomSheet(
          context: context,
          expand: false,
          backgroundColor: Colors.transparent,
          enableDrag: true,
          builder: (context) {
            return L001BottomSheet();
          });
      syncUserInfo();
    }
  }
}
