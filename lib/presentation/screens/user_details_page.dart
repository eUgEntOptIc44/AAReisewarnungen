import 'package:flutter/material.dart';
import 'package:flutter_responsive_onboarding/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:aareisewarnungen/data/country_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:step_progress_indicator/step_progress_indicator.dart';

int UserWarningLevel(User user) {
  int warningLevel = 0;
  if (user.warning == true) {
    warningLevel += 1;
  }
  if (user.partialWarning == true) {
    warningLevel += 1;
  }
  if (user.situationWarning == true) {
    warningLevel += 1;
  }
  return warningLevel;
}

String warningLevelString(int index) {
  List<String> keys = [
    "Warnung",
    "eingeschränkte Warnung",
    "situationsbedingte Warnung"
  ];

  return keys[index];
}

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 16.0,
              ),
              GridView.count(
              crossAxisCount: Utils.getDeviceType() == 'phone' ? 1 : 2,
              children: [
                Container(
              Center(
                child: Hero(
                  tag: user.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(6.0)),
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        widthFactor: 0.50,
                        heightFactor: 0.50,
                        child: Image.network(user.flagUrl),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22.0,
              ),
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  user.title,
                  style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
    ),
    Container(
              Padding(
                padding: EdgeInsets.all(7.0),
                child: StepProgressIndicator(
                  totalSteps: 3,
                  currentStep: UserWarningLevel(user),
                  size: 30,
                  selectedColor: Colors.orange,
                  unselectedColor: Colors.lightGreen, //[200],
                  customStep: (index, colorTemp, _) => colorTemp == Colors.orange
                      ? Container(
                          color: colorTemp,
                          child: Tooltip(
                            message: warningLevelString(index),
                            child: Icon(
                              Icons.warning,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : Container(
                          color: colorTemp,
                          child: Tooltip(
                            message: warningLevelString(index),
                            child: Icon(
                              Icons.remove,
                              color: Colors.black,
                            ),
                          ),
                        ),
                ),
              ),
              SizedBox(
                height: 12.0,
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
                      message: "letzte Änderung: " + DateFormat('dd.MM.yyyy Hm').format(DateTime.fromMillisecondsSinceEpoch(user.lastModified * 1000)),
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
                      width: 5.0,
                    ),
                    Icon(
                      Icons.update,
                      //color: Colors.black,
                      size: 18.0,
                      semanticLabel: 'effective',
                    ),
                    Tooltip(
                      message: "effective -> " + DateFormat('dd.MM.yyyy Hm').format(DateTime.fromMillisecondsSinceEpoch(user.effective * 1000)),
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
    ),
  ]),

              SizedBox(
                height: 12.0,
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
    );
  }
}
