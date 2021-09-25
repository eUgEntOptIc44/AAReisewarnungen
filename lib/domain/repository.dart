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

Future<int> addUsers(List<User> listOfUsers) async {
  return await handler.insertUser(listOfUsers);
}*/

List<User> parseUser(String responseBody) {
  Logger.d("about to decode countries json string");
  var list = json.decode(responseBody)["response"];

  Logger.d(list.keys);

  List<User> users = [];

  for (final contentListId in list["contentList"]) {
    list[contentListId]["id"] = int.parse(contentListId);
    //print(list[contentListId]);

    /*for (final keyTemp in list[contentListId].keys) {
      print(keyTemp);
      print(list[contentListId][keyTemp].runtimeType); // to debug data types
    }*/
    User userTemp = new User(
        int.parse(contentListId),
        list[contentListId]["lastModified"],
        list[contentListId]["effective"],
        list[contentListId]["flagUrl"],
        list[contentListId]["title"].replaceAll(': Reise- und Sicherheitshinweise', ''),
        list[contentListId]["warning"],
        list[contentListId]["partialWarning"],
        list[contentListId]["situationWarning"],
        list[contentListId]["lastChanges"].replaceAllMapped(RegExp(r'<[^>]+>'), (match) {
          // docs: https://api.dart.dev/stable/1.20.1/dart-core/String/replaceAllMapped.html
          return '';
        }),
        list[contentListId]["content"]);
    users.add(userTemp);
    Logger.d("added country #" + contentListId + "\n");
    //createCountry(userTemp);

    /*handler.initializeDB().whenComplete(() async {
      await addUsers(users);
    });*/

    //Logger.d("inserted country #" + contentListId + " into db \n");
  }

  Logger.d("returning " + users.length.toString() + " countries ");
  //print(users);

  return users;
}

Future<List<User>> fetchUsers() async {
  final http.Response response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    Logger.d("travelwarning api request responseCode is 200");
    return compute(parseUser, response.body);
  } else {
    Logger.e("travelwarning json request failed -> responseCode: " + response.statusCode.toString());
    throw Exception(response.statusCode);
  }
}
