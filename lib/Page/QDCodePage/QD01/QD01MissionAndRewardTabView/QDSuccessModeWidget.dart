import 'package:flutter/material.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/GoogleMapSupport/MapMakerDescriptorContainer.dart';
import 'package:forutonafront/Components/DetailMap/DetailMap.dart';
import 'package:forutonafront/Forutonaicon/forutona_icon_icons.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'QDPointWidget.dart';

class QDSuccessModeWidget extends StatelessWidget {
  final String mainTitle;

  final String descriptionText;

  final Icon titleIcon;

  final String photoDescriptionText;

  final bool hasCheckIn;

  final Position? checkInPosition;

  final String? checkInAddress;

  final String? checkInDescriptionText;

  QDSuccessModeWidget(
      {required this.mainTitle,
      required this.descriptionText,
      required this.titleIcon,
      required this.photoDescriptionText,
      required this.hasCheckIn,
      this.checkInDescriptionText,
      this.checkInPosition,
      this.checkInAddress});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => QDPhotoCertificationWidgetViewModel(),
        child: Consumer<QDPhotoCertificationWidgetViewModel>(
            builder: (_, model, child) {
          return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 34,
                          width: 34,
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: titleIcon,
                        ),
                        Expanded(
                            child: Container(
                          margin: EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                mainTitle,
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff000000),
                                  letterSpacing: -0.24,
                                  fontWeight: FontWeight.w500,
                                  height: 1.4166666666666667,
                                ),
                                textAlign: TextAlign.left,
                              ),
                              Text(
                                descriptionText,
                                style: GoogleFonts.notoSans(
                                  fontSize: 12,
                                  color: const Color(0xff3a3e3f),
                                  letterSpacing: -0.24,
                                  height: 1.4166666666666667,
                                ),
                                textAlign: TextAlign.left,
                              )
                            ],
                          ),
                        ))
                      ],
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Text(
                      photoDescriptionText,
                      style: GoogleFonts.notoSans(
                        fontSize: 14,
                        color: const Color(0xff3a3e3f),
                        letterSpacing: -0.28,
                        height: 1.2857142857142858,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    hasCheckIn
                        ? SizedBox(
                            height: 16,
                          )
                        : Container(),
                    hasCheckIn
                        ? QDPointWidget(
                            title: "체크인 장소",
                            icon: Icon(
                              ForutonaIcon.checkin2,
                              size: 16,
                              color: Color(0xff6B46FF),
                            ),
                            onTap: (position, address) {
                              model.jumpCheckInDetailMap(
                                  context, position, address);
                            },
                            position: checkInPosition!,
                            address: checkInAddress!)
                        : Container(),
                    hasCheckIn
                        ? SizedBox(
                            height: 16,
                          )
                        : Container(),
                    hasCheckIn
                        ? Text(checkInDescriptionText!,
                            style: GoogleFonts.notoSans(
                              fontSize: 14,
                              color: const Color(0xff3a3e3f),
                              letterSpacing: -0.28,
                              height: 1.2857142857142858,
                            ),
                            textAlign: TextAlign.left)
                        : Container()
                  ]));
        }));
  }
}

class QDPhotoCertificationWidgetViewModel extends ChangeNotifier {
  MapMakerDescriptorContainer _mapMakerDescriptorContainer = sl();

  void jumpCheckInDetailMap(
      BuildContext context, Position position, String address) {
    var qCheckInFlag = _mapMakerDescriptorContainer
        .getBitmapDescriptor(MapMakerDescriptorType.QCheckInFlag);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DetailMap(
          address: address,
          position: position,
          marker: Marker(
            markerId: MarkerId("QCheckInFlag"),
            anchor: Offset(0.5, 1),
            icon: qCheckInFlag,
            position: LatLng(position.latitude!, position.longitude!),
          ));
    }));
  }
}
