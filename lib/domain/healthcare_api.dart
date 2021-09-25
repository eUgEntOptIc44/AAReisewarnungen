import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:aareisewarnungen/data/healthcare_model.dart';
//import 'package:aareisewarnungen/providers/db_provider.dart';

final String url = "https://www.auswaertiges-amt.de/opendata/healthcare";

/*var handler = DatabaseHandler();

Future<int> addHealthcares(List<Healthcare> listOfHealthcares) async {
  return await handler.insertHealthcare(listOfHealthcares);
}*/

List<Healthcare> parseHealthcare(List<int> responseBody) {
  Logger.d("about to decode healthcare json string");
  var list = json.decode(utf8.decode(responseBody))["response"];

  Logger.d(list.keys);

  List<Healthcare> healthcareItems = [];

  for (final contentListId in list["contentList"]) {
    list[contentListId]["id"] = int.parse(contentListId);

    if (list[contentListId].keys == null) {
      continue;
    } else if (list[contentListId]["name"] == null) {
      continue;
    } else if (list[contentListId]["url"] == null) {
      continue;
    }
    print(list[contentListId]);

    /*for (final keyTemp in list[contentListId].keys) {
        print(keyTemp);
        print(list[contentListId][keyTemp].runtimeType); // to debug data types
      }*/
    Healthcare userTemp = new Healthcare(list[contentListId]["id"], list[contentListId]["lastModified"], list[contentListId]["name"], list[contentListId]["url"]);
    healthcareItems.add(userTemp);
    Logger.d("added healthcare #" + contentListId + "\n");
    //createCountry(userTemp);

    /*handler.initializeDB().whenComplete(() async {
        await addHealthcares(users);
      });*/

    //Logger.d("inserted healthcare #" + contentListId + " into db \n");

  }

  Logger.d("returning " + healthcareItems.length.toString() + " healthcare item(s) ");
  //print(healthcareItems);

  return healthcareItems;
}

Future<List<Healthcare>> fetchHealthcares() async {
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Logger.d("healthcare api request responseCode is 200");
    return compute(parseHealthcare, response.bodyBytes); // Notice: we're using bytes instead of a string here to decode to UTF-8 and preserve umlauts, etc. -> source: https://stackoverflow.com/a/55868078 - user: Richard Heap - 2019 - CC BY-SA 4.0
  } else {
    Logger.e("healthcare api json request failed -> responseCode: " + response.statusCode.toString());
    throw Exception(response.statusCode);
  }
}
