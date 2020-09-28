import 'package:flutter/material.dart';
import 'package:forutonafront/Common/GeoPlaceAdapter/GeoPlaceAdapter.dart';
import 'package:forutonafront/Common/Geolocation/Domain/UseCases/GeoLocationUtilBasicUseCaseInputPort.dart';
import 'package:forutonafront/ServiceLocator/ServiceLocator.dart';
import 'package:google_place/google_place.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class PlaceListFromSearchTextWidget extends StatelessWidget {

  final String searchText;

  const PlaceListFromSearchTextWidget({Key key, this.searchText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          PlaceListFromSearchTextWidgetViewModel(
              searchText: searchText,
              geoPlaceAdapter: sl(),
              geoLocationUtilBasicUseCaseInputPort: sl()
          ),
      child: Consumer<PlaceListFromSearchTextWidgetViewModel>(
        builder: (_, model, __) {
          return ListView.builder(
            shrinkWrap: true,
              itemCount: model.predictions.length,
              itemBuilder: (context,index){
                return Container(child: Text(model.predictions[index].description));
              }
          );
        },
      ),
    );
  }
}

class PlaceListFromSearchTextWidgetViewModel extends ChangeNotifier {
  final String searchText;

  final GeoPlaceAdapter geoPlaceAdapter;

  final GeoLocationUtilBasicUseCaseInputPort geoLocationUtilBasicUseCaseInputPort;

  List<AutocompletePrediction> predictions = [];

  String _sessionToken = Uuid().v4();


  PlaceListFromSearchTextWidgetViewModel(
      {this.geoLocationUtilBasicUseCaseInputPort, this.searchText, this.geoPlaceAdapter}) {
    init();
  }

  void init() async {

    Component kr = Component("country", "kr");
    var position = await geoLocationUtilBasicUseCaseInputPort
        .getCurrentWithLastPosition();

    var autocompleteGet = await geoPlaceAdapter.autocompleteGet(
        searchText, sessionToken: _sessionToken,
        language: "ko",
        components: [kr],
        location: LatLon(position.latitude, position.longitude),
        origin: LatLon(position.latitude, position.longitude)
    );

    this.predictions = autocompleteGet.predictions;
    notifyListeners();
  }
}