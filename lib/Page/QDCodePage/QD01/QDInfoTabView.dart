import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/BallDisPlayUseCase/QuestBallDisPlayUseCase.dart';
import 'package:forutonafront/AppBis/FBall/Domain/Value/QuestBallDescription.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Components/DetailPage/DBallMode.dart';
import 'package:forutonafront/Components/DetailPage/DBallPictures/DBallPictures.dart';
import 'package:forutonafront/Components/DetailPage/DBallTextContent.dart';
import 'package:forutonafront/Components/DetailPage/DBallTitle/DBallLimitTag.dart';
import 'package:forutonafront/Components/DetailPage/DBallYoutubeWidget.dart';
import 'package:forutonafront/Components/FBallReply3/FBallReply3.dart';
import 'package:forutonafront/Components/UserProfileBar/UserProfileBar.dart';
import 'package:forutonafront/Page/ICodePage/IM001/Component/BallImageEdit/BallImageItem.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:provider/provider.dart';

class QDInfoTabView extends StatelessWidget {

  final FBallResDto fBallResDto;


  QDInfoTabView({required this.fBallResDto});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QDInfoTabViewViewModel(fBallResDto: fBallResDto),
      child: Consumer<QDInfoTabViewViewModel>(
        builder: (_, model, child) {
          return Container(
            child: ListView(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              children: [
                UserProfileBar(
                  fUserInfoSimpleResDto: model.fBallResDto.uid,
                ),
                DBallTextContent(
                  content: model.getBallTextContent(),
                ),
                Container(
                  margin: EdgeInsets.all(16),
                  child: DLimitTag(
                    ballUuid: model.fBallResDto.ballUuid!,
                    limitCount: 10,
                    mode: DBallMode.publish,
                  ),
                ),
                DBallPictures(
                  desImages: model.getBallDesImages(),
                ),
                DBallYoutubeWidget(
                  youtubeVideoId: model.getBallYoutubeId(),
                ),
                FBallReply3(
                  ballUuid: model.fBallResDto.ballUuid,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class QDInfoTabViewViewModel extends ChangeNotifier {
  FBallResDto fBallResDto;

  late QuestBallDisPlayUseCase questBallDisPlayUseCase;

  QDInfoTabViewViewModel({required this.fBallResDto}){
    questBallDisPlayUseCase = QuestBallDisPlayUseCase(
      fBallResDto: fBallResDto,
      geoLocatorAdapter: sl()
    );
  }

  String getBallTextContent() {
    return questBallDisPlayUseCase.descriptionText();
  }

  List<BallImageItem?> getBallDesImages() {
    return questBallDisPlayUseCase.getDesImages();

  }

  String getBallYoutubeId() {
    return questBallDisPlayUseCase.getYoutubeId();
  }
}
