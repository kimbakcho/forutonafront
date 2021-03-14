import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Page/ICodePage/ID001/ValuationMediator/ValuationMediator.dart';
import 'package:forutonafront/Page/ICodePage/ID01/BPVoetePopupDialog/BPVotePopupDialog.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class ID01MainScaffoldBottomSheet extends StatelessWidget {

  final FBallResDto fBallResDto;

  final ValuationMediator valuationMediator;

  const ID01MainScaffoldBottomSheet({Key key, this.fBallResDto, this.valuationMediator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainScaffoldBottomSheetViewModel(fBallResDto,sl(),valuationMediator),
      child: Consumer<ID01MainScaffoldBottomSheetViewModel>(
        builder: (_, model, child) {
          return Container(
            height: 50,
            color: Colors.white.withOpacity(0.7),
            child: Row(
              children: [
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 8, 16),
                      child: Icon(Icons.card_giftcard),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
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
                      model.showVotePopupDialog(context);
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: 16),
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          border:
                              Border.all(color: Color(0xff3A3E3F), width: 1)),
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
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ID01MainScaffoldBottomSheetViewModel extends ChangeNotifier implements ValuationMediatorComponent {

  final FBallResDto fBallResDto;

  final SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort;

  final ValuationMediator valuationMediator;

  ID01MainScaffoldBottomSheetViewModel(this.fBallResDto, this._signInUserInfoUseCaseInputPort, this.valuationMediator){
    syncUserInfo();
  }

  syncUserInfo() async {
    if(_signInUserInfoUseCaseInputPort.isLogin){
      await _signInUserInfoUseCaseInputPort.saveSignInInfoInMemoryFromAPiServer();
      notifyListeners();
    }
  }

  showVotePopupDialog(BuildContext context) {
    showMaterialModalBottomSheet(
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
  }

  int get userInfluenceTicketCount {
    if(_signInUserInfoUseCaseInputPort.isLogin){
      return _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory().influenceTicket;
    }else {
      return 0;
    }

  }

  @override
  String ballUuid;

  @override
  valuationReqNotification() {
    syncUserInfo();
  }
}
