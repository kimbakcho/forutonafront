import 'package:google_place/google_place.dart';
import 'package:injectable/injectable.dart';

import '../../Preference.dart';

abstract class GeoPlaceAdapter {
  Future<AutocompleteResponse?> autocompleteGet(String? input, {
    String sessionToken,
    int offset,
    LatLon origin,
    LatLon location,
    int radius,
    String language,
    String types,
    List<Component> components,
    bool strictbounds = false,
  });

  Future<DetailsResponse?> detailGet(String placeId, {
    String language,
    String region,
    String sessionToken,
    String fields,
  });

  String addressComponentToString(List<AddressComponent> components);
}
@Injectable(as: GeoPlaceAdapter)
class GooglePlaceAdapter implements GeoPlaceAdapter {
  GooglePlace? googlePlace;

  GooglePlaceAdapter() {
    googlePlace = GooglePlace(Preference.kGoogleApiKey);
  }

  @override
  Future<AutocompleteResponse?> autocompleteGet(String? input,
      {String? sessionToken,
        int? offset,
        LatLon? origin,
        LatLon? location,
        int? radius,
        String? language,
        String? types,
        List<Component>? components,
        bool strictbounds = false}) async {
    Component kr = Component("country", "kr");
    AutocompleteResponse? response = await googlePlace!.autocomplete.get(input!,
        language: "ko",
        components: [kr],
        origin: origin,
        location: location,
        offset: offset,
        radius: radius,
        sessionToken: sessionToken,
        strictbounds: strictbounds,
        types: types);
    return response;
  }

  @override
  Future<DetailsResponse?> detailGet(String placeId,
      {String? language, String? region, String? sessionToken, String? fields}) async {
    var detailsResponse = await googlePlace!.details.get(placeId,
        sessionToken: sessionToken,
        fields: fields,
        language: language,
        region: region
    );
    return detailsResponse;
  }


  @override
  String addressComponentToString(List<AddressComponent> components) {
      String result = "";
      var reverseList = components.reversed.toList();
      if(reverseList.length >1){
        reverseList.removeRange(0, 2);

      }
      reverseList.forEach((element) {
        result+=element.shortName! + " ";
      });
      return result;

  }
}
