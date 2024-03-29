import 'package:flutter/material.dart';
import 'package:forutonafront/AppBis/FBall/Dto/FBallResDto.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/DistanceDisplayUtil.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilForeGroundUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class DBallAddressWidget extends StatelessWidget {
  final String address;

  final Position position;

  final EdgeInsets padding;

  final Function(Position)? onTabAddress;

  const DBallAddressWidget(
      {Key? key, required this.address, required this.position, this.padding = const EdgeInsets
          .fromLTRB(8, 0, 62, 0), this.onTabAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => DBallAddressWidgetViewModel(position: position,address: address),
    child: Consumer<DBallAddressWidgetViewModel>(
    builder: (_, model, child) {
    return Container(
    height: 37,
    child: Material(
    color: Colors.transparent,
    child: InkWell(
    onTap: (){
    if(onTabAddress != null){
    onTabAddress!(Position(longitude: position.longitude,latitude: position.latitude));
    }

    },
    child: Row(
    children: [
    Icon(Icons.location_on,color: Color(0xff454F63),),
    Expanded(
    child: Container(
    margin: EdgeInsets.only(left: 6),
    child: Text(model.address,
    overflow: TextOverflow.ellipsis,
    style: GoogleFonts.notoSans(
    fontSize: 14,
    color: const Color(0xff454F63),
    letterSpacing: -0.28,
    fontWeight: FontWeight.w500,
    )),
    )),
    Container(
    margin: EdgeInsets.only(left: 6, right: 6),
    height: 19,
    width: 2,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: Color(0xffE4E7E8),
    ),
    ),
    Container(
    margin: EdgeInsets.only(left: 8),
    child:
    Text(model.loaded ? model.displayDistanceWithUser! : "계산중",
    style: GoogleFonts.notoSans(
    fontSize: 14,
    color: const Color(0xffff5d76),
    letterSpacing: -0.28,
    fontWeight: FontWeight.w500,
    )),
    )
    ],
    ),
    ),
    )
    ,
    padding: padding,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20))),
    );
    },
    )
    ,
    );
  }
}

class DBallAddressWidgetViewModel extends ChangeNotifier {

  final String address;

  final Position position;

  final GeoLocationUtilForeGroundUseCaseInputPort
  _geoLocationUtilForeGroundUseCaseInputPort = sl();

  bool loaded = false;

  String? displayDistanceWithUser;

  DBallAddressWidgetViewModel({required this.address, required this.position}) {
    this.init();
  }

  init() async {
    loaded = false;
    notifyListeners();
    Position ballPosition = new Position(
        longitude: position.longitude, latitude: position.latitude);
    this.displayDistanceWithUser =
    await _geoLocationUtilForeGroundUseCaseInputPort
        .reqBallDistanceDisplayText(ballLatLng: ballPosition);
    loaded = true;
    notifyListeners();
  }
}
