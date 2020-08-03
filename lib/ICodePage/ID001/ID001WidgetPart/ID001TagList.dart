import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseOutputPort.dart';
import 'package:forutonafront/Tag/Dto/FBallTagResDto.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ID001TagList extends StatelessWidget {
  final String ballUuid;

  const ID001TagList({Key key, this.ballUuid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => ID001TagListViewModel(
            ballUuid: ballUuid, tagFromBallUuidUseCaseInputPort: sl()),
        child: Consumer<ID001TagListViewModel>(builder: (_, tagModel, __) {
          return Container(
            height: 30,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: tagModel.getBallTagsSize(),
                itemBuilder: (_, index) {
                  return Container(
                      child: RawMaterialButton(
                          constraints: BoxConstraints(),
                          padding: EdgeInsets.only(left: 10),
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          onPressed: () {},
                          child: Text(
                            '#${tagModel.ballTags[index].tagItem}',
                            style: GoogleFonts.notoSans(
                              fontSize: 13,
                              color: const Color(0xff454f63),
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          )));
                }),
          );
        }));
  }
}

class ID001TagListViewModel extends ChangeNotifier
    implements TagFromBallUuidUseCaseOutputPort {
  final String ballUuid;
  final TagFromBallUuidUseCaseInputPort _tagFromBallUuidUseCaseInputPort;
  List<FBallTagResDto> ballTags = [];

  ID001TagListViewModel(
      {@required this.ballUuid,
      TagFromBallUuidUseCaseInputPort tagFromBallUuidUseCaseInputPort})
      : _tagFromBallUuidUseCaseInputPort = tagFromBallUuidUseCaseInputPort {
    _tagFromBallUuidUseCaseInputPort.getTagFromBallUuid(
        ballUuid: ballUuid, outputPort: this);
  }

  int getBallTagsSize() {
    return ballTags.length;
  }

  @override
  onTagFromBallUuid(List<FBallTagResDto> ballTags) {
    this.ballTags = ballTags;
    notifyListeners();
  }
}