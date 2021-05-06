import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Components/MapPositionSelector/MapPositionSelectorWithBottom.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/Page/QMCodePage/QM01/QM01MainPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class PositionSelectorWidget extends StatelessWidget {
  final PositionSelectorWidgetController? controller;

  final String mapIconPath;

  final String label;

  final String hint;

  final String hint2;

  PositionSelectorWidget(
      {this.controller,
      required this.mapIconPath,
      required this.label,
      required this.hint,
      required this.hint2});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => PositionSelectorWidgetViewModel(
          mapIconPath: mapIconPath,
          controller: controller,
          label: label,
          hint2: hint2),
      child: Consumer<PositionSelectorWidgetViewModel>(
        builder: (_, model, child) {
          return Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    color: const Color(0xff000000),
                    letterSpacing: -0.28,
                    fontWeight: FontWeight.w700,
                    height: 1.2142857142857142,
                  ),
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () {
                      model.showMapPositionSelector(context);
                    },
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(15)))),
                        backgroundColor:
                            MaterialStateProperty.all(Color(0xffF6F6F6))),
                    child: model.getSelectedAddressWidget()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  hint,
                  style: GoogleFonts.notoSans(
                    fontSize: 12,
                    color: const Color(0xff7a7a7a),
                    letterSpacing: -0.24,
                    height: 1.1666666666666667,
                  ),
                  textAlign: TextAlign.left,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class PositionSelectorWidgetViewModel extends ChangeNotifier {
  PositionSelectorWidgetController? controller;
  Position? selectPosition;
  String? selectAddress;
  String mapIconPath;

  final String label;

  final String hint2;

  PositionSelectorWidgetViewModel(
      {this.controller,
      required this.mapIconPath,
      required this.label,
      required this.hint2}) {
    if (controller != null) {
      controller!._viewModel = this;
    }
  }

  showMapPositionSelector(BuildContext context) async {
    var qm01MainPageViewModel =
        Provider.of<QM01MainPageViewModel>(context, listen: false);

    var currentPosition =
        qm01MainPageViewModel.makeCommonMainPageController.getCurrentPosition();

    var initPosition = CameraPosition(
        target: LatLng(currentPosition!.latitude!, currentPosition.longitude!),
        zoom: 14.4);

    await showDialog(
        context: context,
        builder: (context) {
          return MapPositionSelectorWithBottom(
            iconPath: mapIconPath,
            initCameraPosition: initPosition,
            onSelectPosition: (position, address) {
              selectPosition = position;
              selectAddress = address;
              Navigator.of(context).pop();
            },
            bottomBtnText: "지정",
            bottomTitle: label,
          );
        });
    notifyListeners();
  }

  Widget getSelectedAddressWidget() {
    if (selectAddress == null) {
      return Container(
        alignment: Alignment.center,
        height: 46,
        constraints: BoxConstraints(
            maxWidth: double.infinity, minWidth: double.infinity),
        child: Text(
          hint2,
          style: GoogleFonts.notoSans(
            fontSize: 14,
            color: const Color(0xff2f3035),
            letterSpacing: -0.28,
            fontWeight: FontWeight.w500,
            height: 1.2142857142857142,
          ),
        ),
      );
    } else {
      return Container(
        height: 46,
        constraints: BoxConstraints(
            maxWidth: double.infinity, minWidth: double.infinity),
        child: Row(
          children: [
            Container(
              child: Icon(
                ForutonaIcon.checkin2,
                color: Colors.black,
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
                child: Text(
              selectAddress!,
              style: GoogleFonts.notoSans(
                fontSize: 14,
                color: const Color(0xff2f3035),
                letterSpacing: -0.28,
                fontWeight: FontWeight.w500,
                height: 1.2142857142857142,
              ),
              textAlign: TextAlign.left,
            ))
          ],
        ),
      );
    }
  }
}

class PositionSelectorWidgetController {
  PositionSelectorWidgetViewModel? _viewModel;

  Position? getSelectPosition() {
    if (_viewModel != null) {
      return _viewModel!.selectPosition;
    } else {
      return null;
    }
  }
  String? getSelectAddress(){
    if (_viewModel != null) {
      return _viewModel!.selectAddress;
    } else {
      return null;
    }
  }

}
