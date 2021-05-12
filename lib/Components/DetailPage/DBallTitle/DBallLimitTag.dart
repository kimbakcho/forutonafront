import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../DBallMode.dart';

class DLimitTag extends StatelessWidget {
  final int limitCount;

  final String? ballUuid;

  final DBallMode? mode;

  final List<FBallTagResDto>? preViewfBallTagResDtos;

  const DLimitTag(
      {Key? key,
      this.limitCount = 3,
      this.ballUuid,
      this.mode,
      this.preViewfBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => DLimitTagViewModel(
          ballUuid, limitCount, sl(), mode, preViewfBallTagResDtos),
      child: Consumer<DLimitTagViewModel>(
        builder: (_, model, child) {
          return Container(
            height: 18,
            alignment: Alignment.centerLeft,
            child: model.isLoaded
                ? Wrap(
                    spacing: 5.0,
                    children: model._buildTagWidget(),
                  )
                : Container(),
          );
        },
      ),
    );
  }
}

class DLimitTagViewModel extends ChangeNotifier {
  bool isLoaded = false;

  final int? limitCount;

  final String? ballUuid;

  final TagFromBallUuidUseCaseInputPort? _tagFromBallUuidUseCaseInputPort;

  final DBallMode? id01Mode;

  final List<FBallTagResDto>? preViewfBallTagResDtos;

  List<FBallTagResDto>? tags;

  DLimitTagViewModel(
    this.ballUuid,
    this.limitCount,
    this._tagFromBallUuidUseCaseInputPort,
    this.id01Mode,
    this.preViewfBallTagResDtos,
  ) {
    this.init();
  }

  init() async {
    if (id01Mode == DBallMode.preview) {
      this.tags = preViewfBallTagResDtos;
    } else {
      this.tags = await _tagFromBallUuidUseCaseInputPort!
          .getTagFromBallUuid(ballUuid: ballUuid!);
    }

    isLoaded = true;
    notifyListeners();
  }

  _buildTagWidget() {
    List<Widget> widgets = [];
    if (this.tags!.isEmpty) {
      return [Container()];
    }
    for (int i = 0; i < min(limitCount!, this.tags!.length); i++) {
      widgets.add(Text(
        '#${this.tags![i].tagItem}',
        style: GoogleFonts.notoSans(
          fontSize: 14,
          color: const Color(0xff007eff),
          fontWeight: FontWeight.w300,
        ),
        overflow: TextOverflow.ellipsis,
      ));
    }
    return widgets;
  }
}
