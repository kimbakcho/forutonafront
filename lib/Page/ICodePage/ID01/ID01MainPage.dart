import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Domain/UseCase/selectBall/SelectBallUseCaseInputPort.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/Components/SolidBottomSheet/src/solidBottomSheet.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sliding_sheet/sliding_sheet.dart';

import 'ID01MainBottomSheet/ID01MainBottomSheetHeader.dart';
import 'ID01MainBottomSheet/ID01MainBottomSheetBody.dart';

class ID01MainPage extends StatelessWidget {
  final String ballUuid;

  final FBallResDto fBallResDto;

  const ID01MainPage({Key key, this.ballUuid, this.fBallResDto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ID01MainPageViewModel(
        context,
        ballUuid,
        fBallResDto,
        sl()
      ),
      child: Consumer<ID01MainPageViewModel>(
        builder: (_, model, child) {
          return Scaffold(
              body: model.isBallLoaded
                  ? SlidingSheet(
                      cornerRadius: 16,
                      isBackdropInteractable: true,
                      snapSpec: SnapSpec(
                        snap: true,
                        snappings: [88, model.middleSnapPosition, model.topSnapPosition],
                        initialSnap: model.middleSnapPosition,
                        positioning: SnapPositioning.pixelOffset,
                        onSnap: (state, snap) {
                          print(state);
                        },
                      ),
                      body: Stack(
                        children: [
                          GoogleMap(
                              initialCameraPosition:
                                  model._googleMapInitPosition),
                        ],
                      ),
                      minHeight: 100,
                      builder: (context, state) {
                        return ID01MainBottomSheetBody(
                            topPosition: model.topSnapPosition,
                            fBallResDto: fBallResDto);
                      },
                      headerBuilder: (context, state) {
                        return ID01MainBottomSheetHeader(
                            fBallResDto: fBallResDto);
                      },
                    )
                  : CommonLoadingComponent());
        },
      ),
    );
  }
}

class ID01MainPageViewModel extends ChangeNotifier {
  final String ballUuid;

  final SelectBallUseCaseInputPort _selectBallUseCaseInputPort;

  bool isBallLoaded = false;

  FBallResDto fBallResDto;

  CameraPosition _googleMapInitPosition;

  BuildContext _context;

  Widget _bottomWidget;

  ID01MainPageViewModel(this._context, this.ballUuid, this.fBallResDto,
      this._selectBallUseCaseInputPort) {
    this._loadBall();
  }

  _loadBall() async {
    isBallLoaded = false;
    if (fBallResDto == null) {
      notifyListeners();
      this.fBallResDto =
          await this._selectBallUseCaseInputPort.selectBall(ballUuid);
    }
    _init();
    isBallLoaded = true;
    notifyListeners();
  }

  _init() {
    _googleMapInitPosition = CameraPosition(
        target: LatLng(this.fBallResDto.latitude, this.fBallResDto.longitude),
        zoom: 14.4);
  }

  getBottomSheet() {
    return _bottomWidget;
  }

  get middleSnapPosition{
    return MediaQuery.of(_context).size.height*0.45;
  }

  get topSnapPosition {
    return MediaQuery.of(_context).size.height-(MediaQuery.of(_context).padding.top+58);
  }

}
