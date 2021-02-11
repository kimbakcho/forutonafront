import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ID01LimitTag extends StatelessWidget {
  final int limitCount;

  final String ballUuid;

  const ID01LimitTag({Key key, this.limitCount = 3, this.ballUuid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01LimitTagViewModel(
        ballUuid,
        limitCount,
        sl(),
      ),
      child: Consumer<ID01LimitTagViewModel>(
        builder: (_, model, child) {
          return Container(
            child: model.isLoaded ?
            Row(
              children: model._buildTagWidget(),
            ): Container(),
          );
        },
      ),
    );
  }
}

class ID01LimitTagViewModel extends ChangeNotifier {
  bool isLoaded = false;

  final int limitCount;

  final String ballUuid;

  final TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort;

  List<FBallTagResDto> tags;

  ID01LimitTagViewModel(
    this.ballUuid,
    this.limitCount,
    this._tagFromBallUuidUseCaseInputPort,
  ) {
    this.init();
  }

  init() async {
    this.tags = await _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        ballUuid: ballUuid);
    isLoaded = true;
    notifyListeners();
  }

  _buildTagWidget() {
    List<Widget> widgets = [];
    if(this.tags.isEmpty){
      return [Container()];
    }
    for (int i = 0; i < limitCount; i++) {
      widgets.add(Text(
        '#${this.tags[i].tagItem}',
        style: GoogleFonts.notoSans(
          fontSize: 12,
          color: const Color(0xff007eff),
          fontWeight: FontWeight.w300,
        ),
        overflow: TextOverflow.ellipsis,
      ));
    }
    return widgets;
  }
}
