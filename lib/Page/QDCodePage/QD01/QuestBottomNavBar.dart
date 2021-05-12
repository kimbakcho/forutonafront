import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/FBallValuation/Domain/UseCase/FBallValuationUseCase/FBallValuationUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBallValuation/Dto/FBallVoteResDto.dart';
import 'package:forutonafront/AppBis/ForutonaUser/Domain/UseCase/FUser/SigInInUserInfoUseCase/SignInUserInfoUseCaseInputPort.dart';
import 'package:forutonafront/Components/ButtonStyle/CircleIconBtn.dart';
import 'package:forutonafront/Components/DetailPage/DBallLikeButton.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/QDCodePage/Value/QuestEnterUserMode.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class QuestBottomNavBar extends StatefulWidget {
  final FBallResDto fBallResDto;

  const QuestBottomNavBar({Key? key, required this.fBallResDto})
      : super(key: key);

  @override
  _QuestBottomNavBarState createState() => _QuestBottomNavBarState();
}

class _QuestBottomNavBarState extends State<QuestBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          QuestBottomNavBarViewModel(fBallResDto: widget.fBallResDto),
      child: Consumer<QuestBottomNavBarViewModel>(
        builder: (context, model, child) {
          return
            Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: model.isLoaded ? Row(
              children: [
                SizedBox(
                  width: 16,
                ),
                DBallLikeButton(
                  icon: ForutonaIcon.like,
                  color: Color(0xff007EFF),
                  controller: model.likeButtonController,
                  initCount: model.fBallResDto.ballLikes!, initMyCount: model.fBallVoteResDto.ballLike!,
                  onTab: (){
                    model.likeVote();
                  },
                ),
                DBallLikeButton(
                  icon: ForutonaIcon.like,
                  color: Color(0xffFF4F9A),
                  controller: model.disLikeButtonController,
                  initCount: model.fBallResDto.ballDisLikes!, initMyCount: model.fBallVoteResDto.ballDislike!,
                  onTab: (){
                    model.dislikeVote();
                  },
                )
              ],
            ):Container(),
          );
        },
      ),
    );
  }
}

class QuestBottomNavBarViewModel extends ChangeNotifier {
  SignInUserInfoUseCaseInputPort _signInUserInfoUseCaseInputPort = sl();

  FBallValuationUseCaseInputPort _fBallValuationUseCaseInputPort = sl();

  FBallResDto fBallResDto;
  
  bool isLoaded = false;

  DBallLikeButtonController likeButtonController = DBallLikeButtonController();

  DBallLikeButtonController disLikeButtonController = DBallLikeButtonController();

  late QuestEnterUserMode questEnterUserMode;

  late FBallVoteResDto fBallVoteResDto;

  QuestBottomNavBarViewModel({required this.fBallResDto}) {
    if (!_signInUserInfoUseCaseInputPort.isLogin!) {
      questEnterUserMode = QuestEnterUserMode.NoneLogin;
    } else if (fBallResDto.uid!.uid ==
        _signInUserInfoUseCaseInputPort.reqSignInUserInfoFromMemory()!.uid) {
      questEnterUserMode = QuestEnterUserMode.Maker;
    } else {
      questEnterUserMode = QuestEnterUserMode.Participant;
    }
    _load();
  }

  void likeVote(){
    fBallResDto.ballLikes = fBallResDto.ballLikes!+1;
    fBallVoteResDto.ballLike = fBallVoteResDto.ballLike!+1;
    likeButtonController.setCount(fBallResDto.ballLikes!);
    likeButtonController.setMyCount(fBallVoteResDto.ballLike!);
    notifyListeners();
  }

  void dislikeVote() {
    fBallResDto.ballDisLikes = fBallResDto.ballDisLikes!+1;
    fBallVoteResDto.ballDislike = fBallVoteResDto.ballDislike!+1;
    disLikeButtonController.setCount(fBallResDto.ballDisLikes!);
    disLikeButtonController.setMyCount(fBallVoteResDto.ballDislike!);
    notifyListeners();

  }

  void _load() async {
    isLoaded = false;
    notifyListeners();
    fBallVoteResDto = await _fBallValuationUseCaseInputPort.getBallVoteState(fBallResDto.ballUuid!);

    isLoaded = true;
    notifyListeners();
  }


  

  
}
