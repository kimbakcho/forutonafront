import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GeoPlaceAdapter/GeoPlaceAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Data/Value/Position.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/Common/Loding/CommonLoadingComponent.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import 'H008SearchEmptyRow.dart';

class PlaceListFromSearchTextWidget extends StatelessWidget {
  final String? searchText;
  final PlaceListFromSearchTextWidgetListener?
      placeListFromSearchTextWidgetListener;

  const PlaceListFromSearchTextWidget(
      {Key? key, this.searchText, this.placeListFromSearchTextWidgetListener})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PlaceListFromSearchTextWidgetViewModel(
            searchText: searchText,
            geoPlaceAdapter: sl(),
            geoLocationUtilBasicUseCaseInputPort: sl(),
            placeListFromSearchTextWidgetListener:
                placeListFromSearchTextWidgetListener),
        child: Consumer<PlaceListFromSearchTextWidgetViewModel>(
            builder: (_, model, __) {
          if (!model.isLoaded) {
            return CommonLoadingComponent();
          }
          return model.hasPlaceList()
              ? ListView.builder(
                  padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemCount: model.detailsResponse.length,
                  itemBuilder: (context, index) {
                    return Container(
                        child: Material(
                            color: Colors.white,
                            child: InkWell(
                                onTap: () {
                                  model
                                      .onPlaceTab(model.detailsResponse[index]);
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: Color(0xffE4E7E8),
                                                width: 1))),
                                    padding: EdgeInsets.all(16),
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Text(
                                                model.detailsResponse[index]
                                                    .result!.name!,
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff454f63),
                                                  letterSpacing: -0.28,
                                                  fontWeight: FontWeight.w700,
                                                  height: 1.4285714285714286,
                                                )),
                                          ),
                                          Container(
                                            child: Text(
                                                model.addressComponentToString(
                                                    model
                                                        .detailsResponse[index]
                                                        .result!
                                                        .addressComponents!),
                                                style: GoogleFonts.notoSans(
                                                  fontSize: 14,
                                                  color:
                                                      const Color(0xff454f63),
                                                  letterSpacing: -0.28,
                                                  height: 1.4285714285714286,
                                                )),
                                          )
                                        ])))));
                  })
              : H008SearchEmptyRow();
        }));
  }
}

class PlaceListFromSearchTextWidgetViewModel extends ChangeNotifier {
  final String? searchText;

  final GeoPlaceAdapter? geoPlaceAdapter;

  final GeoLocationUtilBasicUseCaseInputPort?
      geoLocationUtilBasicUseCaseInputPort;

  final PlaceListFromSearchTextWidgetListener?
      placeListFromSearchTextWidgetListener;

  List<DetailsResponse> detailsResponse = List.empty();

  String _sessionToken = Uuid().v4();

  bool isLoaded = false;

  PlaceListFromSearchTextWidgetViewModel(
      {this.geoLocationUtilBasicUseCaseInputPort,
      this.searchText,
      this.geoPlaceAdapter,
      this.placeListFromSearchTextWidgetListener}) {
    init();
  }

  void init() async {
    Component kr = Component("country", "kr");
    var position =
        await geoLocationUtilBasicUseCaseInputPort!.getCurrentWithLastPosition();
    isLoaded = false;
    var autocompleteGet = await geoPlaceAdapter!.autocompleteGet(searchText,
        sessionToken: _sessionToken,
        language: "ko",
        components: [kr],
        location: LatLon(position.latitude!, position.longitude!),
        origin: LatLon(position.latitude!, position.longitude!));

    await _getDetailFromPredictions(autocompleteGet!.predictions!);
    isLoaded = true;
    notifyListeners();
  }

  String addressComponentToString(List<AddressComponent> components) {
    return geoPlaceAdapter!.addressComponentToString(components);
  }

  _getDetailFromPredictions(List<AutocompletePrediction> predictions) async {
    detailsResponse.clear();
    for(int i=0;i<predictions.length;i++) {
      detailsResponse.add(
          (await geoPlaceAdapter!.detailGet(predictions[i].placeId!, language: "ko"))!);
    }
  }

  void onPlaceTab(DetailsResponse detailsResponse) {
    if (placeListFromSearchTextWidgetListener != null) {
      var location = detailsResponse.result!.geometry!.location;
      var position = Position(latitude: location!.lat, longitude: location.lng);
      placeListFromSearchTextWidgetListener!.onPlaceListTabPosition(position);
    }
  }

  hasPlaceList() {
    return detailsResponse.length > 0;
  }
}

abstract class PlaceListFromSearchTextWidgetListener {
  onPlaceListTabPosition(Position position);
}
