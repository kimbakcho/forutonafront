import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class RecruitParticipantsAppBar extends StatelessWidget {
  final RecruitParticipantsAppBarController? controller;

  final Function? onComplete;

  RecruitParticipantsAppBar({this.controller, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RecruitParticipantsAppBarViewModel(controller:  controller),
      child: Consumer<RecruitParticipantsAppBarViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                    onPressed: () {
                      if (onComplete != null) {
                        onComplete!();
                      }
                    },
                    child: Text("모임 시작",
                        style: model.isCanComplete
                            ? GoogleFonts.notoSans(
                                fontSize: 14,
                                color: Color(0xff007EFF),
                                fontWeight: FontWeight.w700,
                                shadows: [
                                    Shadow(
                                      color: Colors.black.withOpacity(0.4),
                                      offset: Offset(0, 3),
                                      blurRadius: 16,
                                    )
                                  ])
                            : GoogleFonts.notoSans(
                                fontSize: 14,
                                color: Color(0xffD4D4D4),
                                fontWeight: FontWeight.w700,
                              )))
              ],
            ),
          );
        },
      ),
    );
  }
}

class RecruitParticipantsAppBarViewModel extends ChangeNotifier {
  bool isCanComplete = false;

  final RecruitParticipantsAppBarController? controller;

  RecruitParticipantsAppBarViewModel({this.controller}) {
    if (this.controller != null) {
      this.controller!._viewModel = this;
    }
  }

  setIsCanComplete(bool value) {
    this.isCanComplete = value;
    notifyListeners();
  }
}

class RecruitParticipantsAppBarController {
  RecruitParticipantsAppBarViewModel? _viewModel;

  setIsCanComplete(bool value) {
    if (_viewModel != null) {
      _viewModel!.setIsCanComplete(value);
    }
  }
}
