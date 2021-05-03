import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/AppBis/Tag/Dto/FBallTagResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Page/ICodePage/IM001/IM001BottomSheetBody.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakeCommonHeaderSheet.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakeCommonMainPage.dart';
import 'package:forutonafront/Page/MakeCommonPage/MakePageMode.dart';
import 'package:provider/provider.dart';

class QM01MainPage extends StatelessWidget {
  final MakePageMode makePageMode;
  final FBallResDto? preSetBallResDto;
  final List<FBallTagResDto>? preSetFBallTagResDtos;

  QM01MainPage(
      {Key? key,
      required this.makePageMode,
      this.preSetBallResDto,
      this.preSetFBallTagResDtos})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => QM01MainPageViewModel(),
      child: Consumer<QM01MainPageViewModel>(
        builder: (_, model, child) {
          String? preSetAddress;
          Position? preSetPosition;
          if (preSetBallResDto != null) {
            preSetAddress = preSetBallResDto!.placeAddress;
            preSetPosition = Position(
                longitude: preSetBallResDto!.longitude,
                latitude: preSetBallResDto!.latitude);
          }
          return MakeCommonMainPage(
            makePageMode: makePageMode,
            ballIconPath: "assets/MarkesImages/questballmaker.png",
            makeBottomBodySheet: PageView(
              physics: NeverScrollableScrollPhysics(),
              controller: model.pageController,
              onPageChanged: (value) {
                model.makeCommonHeaderSheetController.setCurrentPage(
                    value, model.makeCommonMainPageController.isBottomOpened);
              },
              children: [
                IM001BottomSheetBody(
                  im001bottomSheetBodyController:
                      model.im001bottomSheetBodyController,
                  makePageMode: makePageMode,
                  preSetBallResDto: preSetBallResDto,
                  preSetFBallTagResDtos: preSetFBallTagResDtos,
                  onComplete: (value) {
                    model.makeCommonHeaderSheetController.setIsCanComplete(value, model.makeCommonMainPageController.isBottomOpened, 0);
                  },
                  onChangeAddress: (value) {},
                  initAddress: "로딩중",
                ),
                Container(
                  child: Text("Quest"),
                )
              ],
            ),
            preSetAddress: preSetAddress,
            preSetPosition: preSetPosition,
            onChangeDisplayAddress: (address) {
              model.im001bottomSheetBodyController
                  .changeDisplayAddress(address);
            },
            makeCommonMainPageController: model.makeCommonMainPageController,
            makeOpenBottomHeaderSheet: MakeCommonHeaderSheet(
              onModifyBall: (context) {},
              onCreateBall: (context) {},
              onNextPage: (value) {
                model.pageController.jumpToPage(value);
                model.makeCommonHeaderSheetController.setCurrentPage(
                    value, model.makeCommonMainPageController.isBottomOpened);
              },
              makeCommonHeaderSheetController:
                  model.makeCommonHeaderSheetController,
            ),
          );
        },
      ),
    );
  }
}

class QM01MainPageViewModel extends ChangeNotifier {
  IM001BottomSheetBodyController im001bottomSheetBodyController =
      IM001BottomSheetBodyController();
  MakeCommonMainPageController makeCommonMainPageController =
      MakeCommonMainPageController();

  MakeCommonHeaderSheetController makeCommonHeaderSheetController =
      MakeCommonHeaderSheetController(pageLength: 2);

  PageController pageController = PageController();
}
