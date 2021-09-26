import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aareisewarnungen/data/country_model.dart';
import 'package:aareisewarnungen/presentation/utils/utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:timeago/timeago.dart' as timeago;
//import 'package:flutter_icons/flutter_icons.dart';
//import 'package:step_progress_indicator/step_progress_indicator.dart';

class UserDetailsPage extends StatelessWidget {
  final User user;

  UserDetailsPage({required this.user});

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
        title: Text(user.title),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
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
                    tag: user.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      child: Container(
                        constraints: BoxConstraints(maxHeight: Utils.getDeviceType() == 'phone' ? 200 : 230, maxWidth: Utils.getDeviceType() == 'phone' ? 300 : 330),
                        child: Image.network(user.flagUrl, fit: BoxFit.cover),
                        /*Align(
                          alignment: Alignment.center,
                          widthFactor: 0.50,
                          heightFactor: 0.50,
                          child: Image.network(user.flagUrl, fit: BoxFit.cover),
                        ),*/
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 19.0,
                ),
                Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Text(
                    user.title,
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
                          constraints: BoxConstraints(minHeight: 20, minWidth: 40, maxHeight: 30, maxWidth: 50),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
                          color: user.warning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "Warnung",
                            child: Icon(
                              user.warning == true ? Icons.warning : Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 20, minWidth: 40, maxHeight: 30, maxWidth: 50),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
                          color: user.partialWarning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "eingeschränkte Warnung",
                            child: Icon(
                              user.partialWarning == true ? Icons.warning : Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 20, minWidth: 40, maxHeight: 30, maxWidth: 50),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
                          color: user.situationWarning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "situationsbedingte Warnung",
                            child: Icon(
                              user.situationWarning == true ? Icons.warning : Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Container(
                          constraints: BoxConstraints(minHeight: 20, minWidth: 40, maxHeight: 30, maxWidth: 50),
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(6))),
                          color: user.situationPartWarning == true ? Colors.orange : Colors.lightGreen,
                          child: Tooltip(
                            message: "eingeschränkte situationsbedingte Warnung",
                            child: Icon(
                              user.situationPartWarning == true ? Icons.warning : Icons.remove,
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
                        semanticLabel: 'Letzte Änderung',
                      ),
                      Tooltip(
                        message: "letzte Änderung: " + DateFormat('dd.MM.yyyy H:m').format(DateTime.fromMillisecondsSinceEpoch(user.lastModified * 1000)),
                        child: Text(
                          " " + timeago.format(DateTime.fromMillisecondsSinceEpoch(user.lastModified * 1000), locale: 'de'), // source: https://stackoverflow.com/a/50632411 - users: Mahesh Jamdade & Alex Haslam - License: CC BY-SA 4.0
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
                        message: "effective -> " + DateFormat('dd.MM.yyyy H:m').format(DateTime.fromMillisecondsSinceEpoch(user.effective * 1000)),
                        child: Text(
                          " " + timeago.format(DateTime.fromMillisecondsSinceEpoch(user.effective * 1000), locale: 'de'), // source: https://stackoverflow.com/a/50632411 - users: Mahesh Jamdade & Alex Haslam - License: CC BY-SA 4.0
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
                  padding: EdgeInsets.all(8.0),
                  child: HtmlWidget(
                    user.content,
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
    );
  }
}