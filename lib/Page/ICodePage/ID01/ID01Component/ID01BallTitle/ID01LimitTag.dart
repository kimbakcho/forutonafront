import 'dart:math';

import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/Tag/Domain/UseCase/TagFromBallUuid/TagFromBallUuidUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../ID01Mode.dart';

class ID01LimitTag extends StatelessWidget {
  final int limitCount;

  final String? ballUuid;

  final ID01Mode? id01Mode;

  final List<FBallTagResDto>? preViewfBallTagResDtos;

  const ID01LimitTag(
      {Key? key, this.limitCount = 3, this.ballUuid, this.id01Mode, this.preViewfBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          ID01LimitTagViewModel(
              ballUuid,
              limitCount,
              sl(),
              id01Mode,
              preViewfBallTagResDtos
          ),
      child: Consumer<ID01LimitTagViewModel>(
        builder: (_, model, child) {
          return Container(
            height: 18,
            alignment: Alignment.centerLeft,
            child: model.isLoaded ?
            Wrap(
              spacing: 5.0,
              children: model._buildTagWidget(),
            ) : Container(

            ),
          );
        },
      ),
    );
  }
}

class ID01LimitTagViewModel extends ChangeNotifier {
  bool isLoaded = false;

  final int? limitCount;

  final String? ballUuid;

  final TagFromBallUuidUseCaseInputPort? _tagFromBallUuidUseCaseInputPort;

  final ID01Mode? id01Mode;

  final List<FBallTagResDto>? preViewfBallTagResDtos;

  List<FBallTagResDto>? tags;

  ID01LimitTagViewModel(this.ballUuid,
      this.limitCount,
      this._tagFromBallUuidUseCaseInputPort, this.id01Mode,
      this.preViewfBallTagResDtos,) {
    this.init();
  }

  init() async {
    if (id01Mode == ID01Mode.preview){
      this.tags = preViewfBallTagResDtos;
    }else {
      this.tags = await _tagFromBallUuidUseCaseInputPort!.getTagFromBallUuid(
          ballUuid: ballUuid!);
    }

    isLoaded = true;
    notifyListeners();
  }

  _buildTagWidget() {
    List<Widget> widgets = [];
    if (this.tags!.isEmpty) {
      return [Container()];
    }
    for (int i = 0; i < min(limitCount!,this.tags!.length); i++) {
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
