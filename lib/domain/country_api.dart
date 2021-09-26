import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:aareisewarnungen/data/country_model.dart';
import 'package:aareisewarnungen/providers/db_provider.dart';

// full dataset: https://api.npoint.io/7e340412fceec7f5a434
// single item dataset: https://api.npoint.io/00b19995e3e9fee7c163
// original: "https://www.auswaertiges-amt.de/opendata/travelwarning"

final String url = "https://www.auswaertiges-amt.de/opendata/travelwarning";

/*var handler = DatabaseHandler();

Future<int> addCountries(List<Country> listOfCountries) async {
  return await handler.insertCountry(listOfCountries);
}*/

List<Country> parseCountry(String responseBody) {
  Logger.d("about to decode countries json string");
  var list = json.decode(responseBody)["response"];

  Logger.d(list.keys);

  List<Country> countries = [];

  for (final contentListId in list["contentList"]) {
    list[contentListId]["id"] = int.parse(contentListId);
    //print(list[contentListId]);

    /*for (final keyTemp in list[contentListId].keys) {
      print(keyTemp);
      print(list[contentListId][keyTemp].runtimeType); // to debug data types
    }*/
    Country countryTemp = new Country(
        int.parse(contentListId),
        list[contentListId]["lastModified"],
        list[contentListId]["effective"],
        list[contentListId]["flagUrl"],
        list[contentListId]["title"].replaceAll(': Reise- und Sicherheitshinweise', ''),
        list[contentListId]["warning"],
        list[contentListId]["partialWarning"],
        list[contentListId]["situationWarning"],
        list[contentListId]["situationPartWarning"],
        list[contentListId]["lastChanges"].replaceAllMapped(RegExp(r'<[^>]+>'), (match) {
          // docs: https://api.dart.dev/stable/1.20.1/dart-core/String/replaceAllMapped.html
          return '';
        }),
        list[contentListId]["content"]);
    countries.add(countryTemp);
    Logger.d("added country #" + contentListId + "\n");
    //createCountry(countryTemp);

    /*handler.initializeDB().whenComplete(() async {
      await addCountries(countries);
    });*/

    //Logger.d("inserted country #" + contentListId + " into db \n");
  }

  Logger.d("returning " + countries.length.toString() + " countries ");
  //print(countries);

  return countries;
}

Future<List<Country>> fetchCountries() async {
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Logger.d("travelwarning api request responseCode is 200");
    return compute(parseCountry, response.body);
  } else {
    Logger.e("travelwarning json request failed -> responseCode: " + response.statusCode.toString());
    throw Exception(response.statusCode);
  }
}
