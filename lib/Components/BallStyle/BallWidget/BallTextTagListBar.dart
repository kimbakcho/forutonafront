import 'package:flutter/material.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BallTextTagListBar extends StatelessWidget {

  final String ballUuid;

  const BallTextTagListBar({Key key, this.ballUuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          BallTextTagListBarViewModel(tagFromBallUuidUseCaseInputPort: sl(),ballUuid: ballUuid),
      child: Consumer<BallTextTagListBarViewModel>(
        builder: (_, model, __) {
          return Container(
            height: 16,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
                padding: EdgeInsets.all(0),
                shrinkWrap: true,
                itemCount: model.tagDtos.length,
                itemBuilder: (_, index) {
                  return Text("#${model.tagDtos[index].tagItem}",
                    style: GoogleFonts.notoSans(
                      fontSize: 12,
                      color: const Color(0xff007eff),
                      fontWeight: FontWeight.w300,
                    ),
                  );
                }),
          );
        },
      ),
    );
  }
}

class BallTextTagListBarViewModel extends ChangeNotifier
    implements TagFromBallUuidUseCaseOutputPort {
  final TagFromBallUuidUseCaseInputPort tagFromBallUuidUseCaseInputPort;
  final String ballUuid;
  List<FBallTagResDto> tagDtos = [];

  BallTextTagListBarViewModel(
      {this.tagFromBallUuidUseCaseInputPort, this.ballUuid}) {
    init();
  }

  Future<void> init() async {
    this.tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        ballUuid: this.ballUuid, outputPort: this);
  }

  @override
  onTagFromBallUuid(List<FBallTagResDto> ballTags) {
    this.tagDtos = ballTags;
    notifyListeners();
  }


}
