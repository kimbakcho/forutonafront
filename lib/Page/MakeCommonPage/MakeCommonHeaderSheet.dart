import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakePageMode.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';


class MakeCommonHeaderSheet extends StatelessWidget {
  final Function(BuildContext) onCreateBall;
  final Function(BuildContext) onModifyBall;
  final Function(int)? onNextPage;
  final MakeCommonHeaderSheetController makeCommonHeaderSheetController;

  MakeCommonHeaderSheet({required this.onCreateBall,
    required this.onModifyBall,
    this.onNextPage,
    required this.makeCommonHeaderSheetController});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          IM001HeaderSheetViewModel(
              makeCommonHeaderSheetController: makeCommonHeaderSheetController
          ),
      child: Consumer<IM001HeaderSheetViewModel>(
        builder: (_, model, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(0)),
                      alignment: Alignment.centerLeft),
                  onPressed: () {
                    if (makeCommonHeaderSheetController.currentPosition.toInt() == 0) {
                      Navigator.of(context).pop();
                    }else {
                      if(onNextPage!= null){
                        onNextPage!(makeCommonHeaderSheetController.currentPosition.toInt() - 1);
                      }
                    }
                  },
                  child: Icon(ForutonaIcon.arrow_back,
                      color: Colors.black, size: 15)),
              DotsIndicator(
                dotsCount: model.getPageLength(),
                position: model.getCurrentPage(),
                decorator: DotsDecorator(
                    color: Colors.grey, activeColor: Colors.black),
              ),
              TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                          EdgeInsets.all(0)),
                      alignment: Alignment.centerRight),
                  onPressed: () {
                    if (model.isCanCompletes(model.getCurrentPage().toInt()) ==
                        false) {
                      return;
                    }

                    if (model.getIsLastPage()) {
                      if (model.makePageMode == MakePageMode.create) {
                        onCreateBall(context);
                      } else if (model.makePageMode == MakePageMode.modify) {
                        onModifyBall(context);
                      }
                    } else {
                      if (onNextPage != null) {
                        onNextPage!(model.getCurrentPage().toInt() + 1);
                      }
                    }
                  },
                  child: Text(model.getIsLastPage() ? "완료" : "다음",
                      style: GoogleFonts.notoSans(
                          color: model.isCanCompletes(model.getCurrentPage()
                              .toInt())
                              ? Color(0xff3497FD)
                              : Color(0xffD4D4D4))))
            ],
          );
        },
      ),
    );
  }
}

class IM001HeaderSheetViewModel extends ChangeNotifier {
  MakePageMode makePageMode = MakePageMode.create;

  MakeCommonHeaderSheetController makeCommonHeaderSheetController;

  IM001HeaderSheetViewModel({required this.makeCommonHeaderSheetController}) {
    this.makeCommonHeaderSheetController._viewModel = this;
  }

  setIsCanComplete(bool value, bool isOpenBottom) {
    if (isOpenBottom) {
      notifyListeners();
    }
  }

  setMakePageMode(MakePageMode makePageMode, bool isOpenBottom) {
    this.makePageMode = makePageMode;
    if (isOpenBottom) {
      notifyListeners();
    }
  }

  getIsLastPage() {
    if (makeCommonHeaderSheetController.currentPosition ==
        (makeCommonHeaderSheetController.pageLength - 1)) {
      return true;
    } else {
      return false;
    }
  }

  double getCurrentPage() {
    return makeCommonHeaderSheetController.currentPosition;
  }

  setCurrentPage(int page, bool isOpenBottom) {
    if (isOpenBottom) {
      notifyListeners();
    }
  }

  bool isCanCompletes(int index) {
    return makeCommonHeaderSheetController.isCanCompletes[index];
  }

  int getPageLength(){
    return makeCommonHeaderSheetController.pageLength;
  }

}

class MakeCommonHeaderSheetController {

  IM001HeaderSheetViewModel? _viewModel;

  List<bool> isCanCompletes = [];

  double currentPosition = 0;

  final int pageLength;

  MakeCommonHeaderSheetController({required this.pageLength}) {
    isCanCompletes = List.filled(this.pageLength, false);
  }

  setIsCanComplete(bool value, bool isOpenBottom, int page) {
    if (this._viewModel != null) {
      isCanCompletes[page] = value;
      this._viewModel!.setIsCanComplete(value, isOpenBottom);
    }
  }

  setMakePageMode(MakePageMode makePageMode, bool isOpenBottom) {
    if (this._viewModel != null) {
      this._viewModel!.setMakePageMode(makePageMode, isOpenBottom);
    }
  }

  setCurrentPage(int page, bool isOpenBottom) {
    if (this._viewModel != null) {
      this.currentPosition = page.toDouble();
      this._viewModel!.setCurrentPage(page, isOpenBottom);
    }
  }

}
