import 'dart:convert';

import 'package:http/http.dart' as http;

const GOOGLE_API_KEY = 'AIzaSyBWl9swKP2YPyjVH0IdIIf8j0sJHcr3GTw';

class LocationHelper {
  static String generateLocationPreviewImage(
      {double latitude, double longitude}) {
    return 'https://image.maps.ls.hereapi.com/mia/1.6/mapview?apiKey=LVKIs5qTuP6P-4afphggtczAVAdDqZUPdmLGj7YtbGw&c=$latitude,$longitude&u=1k&h=300&w=400';
  }

  static Future<String> getPlaceAddress(double lat, double long) async {
    var url =
        'https://revgeocode.search.hereapi.com/v1/revgeocode?at=$lat%2C$long&lang=en-US&apiKey=LVKIs5qTuP6P-4afphggtczAVAdDqZUPdmLGj7YtbGw';
    final response = await http.get(url);
    final decodedData = json.decode(response.body);
    final itemsMap = decodedData["items"][0]["address"];
    print(itemsMap);
    return '${itemsMap["label"]} ${itemsMap["street"]} ${itemsMap["district"]} ${itemsMap["city"]} ${itemsMap["district"]} ${itemsMap["state"]} ${itemsMap["countryName"]}';
  }
}
