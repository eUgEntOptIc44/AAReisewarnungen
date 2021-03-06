import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aareisewarnungen/data/country_model.dart';
import 'package:aareisewarnungen/presentation/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:timeago/timeago.dart' as timeago;
//import 'package:flutter_icons/flutter_icons.dart';
//import 'package:step_progress_indicator/step_progress_indicator.dart';

class CountryDetailsPage extends StatelessWidget {
  final Country country;

  CountryDetailsPage({required this.country});

  /*void customLaunch(command) async {
    if (await canLaunch(command)) {
      await launch(command);
    } else {
      print('Error');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Container(
            constraints: BoxConstraints(maxWidth: 900),
            color: Colors.transparent,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 19.0,
                ),
                Center(
                  child: Hero(
                    tag: country.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      child: Container(
                        constraints: BoxConstraints(maxHeight: Utils.getDeviceType() == 'phone' ? 140 : 230, maxWidth: Utils.getDeviceType() == 'phone' ? 200 : 330),
                        child: Image.network(country.flagUrl, fit: BoxFit.cover),
                        /*Align(
                          alignment: Alignment.center,
                          widthFactor: 0.50,
                          heightFactor: 0.50,
                          child: Image.network(country.flagUrl, fit: BoxFit.cover),
                        ),*/
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Utils.getDeviceType() == 'phone' ? 16.0 : 19.0,
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    country.title,
                    style: TextStyle(
                      fontSize: Utils.getDeviceType() == 'phone' ? 23.0 : 25.0,
                      fontWeight: FontWeight.w700,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  height: 12.0,
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Row(children: [
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 25, minWidth: 45, maxHeight: 35, maxWidth: 55),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9))),
                          color: country.warning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "Warnung",
                            child: Icon(
                              country.warning == true ? Icons.warning : Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 25, minWidth: 45, maxHeight: 35, maxWidth: 55),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9))),
                          color: country.partialWarning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "eingeschr??nkte Warnung",
                            child: Icon(
                              country.partialWarning == true ? Icons.warning : Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 25, minWidth: 45, maxHeight: 35, maxWidth: 55),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9))),
                          color: country.situationWarning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "situationsbedingte Warnung",
                            child: Icon(
                              country.situationWarning == true ? Icons.warning : Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 25, minWidth: 45, maxHeight: 35, maxWidth: 55),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(9))),
                          color: country.situationPartWarning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "eingeschr??nkte situationsbedingte Warnung",
                            child: Icon(
                              country.situationPartWarning == true ? Icons.warning : Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(7.0),
                    child: Row(children: [
                      Icon(
                        Icons.update,
                        //color: Colors.black,
                        size: 18.0,
                        semanticLabel: 'Letzte ??nderung',
                      ),
                      Tooltip(
                        message: "letzte ??nderung: " + DateFormat('dd.MM.yyyy H:m').format(DateTime.fromMillisecondsSinceEpoch(country.lastModified * 1000)),
                        child: Text(
                          " " + timeago.format(DateTime.fromMillisecondsSinceEpoch(country.lastModified * 1000), locale: 'de'), // source: https://stackoverflow.com/a/50632411 - users: Mahesh Jamdade & Alex Haslam - License: CC BY-SA 4.0
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                      SizedBox(
                        width: 7.0,
                      ),
                      Icon(
                        Icons.update,
                        //color: Colors.black,
                        size: 18.0,
                        semanticLabel: 'effective',
                      ),
                      Tooltip(
                        message: "effective -> " + DateFormat('dd.MM.yyyy H:m').format(DateTime.fromMillisecondsSinceEpoch(country.effective * 1000)),
                        child: Text(
                          " " + timeago.format(DateTime.fromMillisecondsSinceEpoch(country.effective * 1000), locale: 'de'), // source: https://stackoverflow.com/a/50632411 - users: Mahesh Jamdade & Alex Haslam - License: CC BY-SA 4.0
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ]),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: HtmlWidget(
                    country.content,
                    onErrorBuilder: (context, element, error) => Text('$element error: $error'),
                    onLoadingBuilder: (context, element, loadingProgress) => CircularProgressIndicator(),
                    webView: false,
                  ),
                ),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}