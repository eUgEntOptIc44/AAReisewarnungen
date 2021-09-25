import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:aareisewarnungen/data/healthcare_model.dart';
import 'package:aareisewarnungen/presentation/screens/healthcare_details_page.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:dynamic_color_theme/dynamic_color_theme.dart';

class HealthcareTile extends StatelessWidget {
  final Healthcare healthcare;

  HealthcareTile({required this.healthcare});

  @override
  Widget build(BuildContext context) {
    Color color = DynamicColorTheme.of(context).color;
    bool isDark = DynamicColorTheme.of(context).isDark;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: healthcare.id,
              child: Container(
                color: Colors.transparent,
                child: Tooltip(
                  message: 'pdf download',
                  child: Icon(
                    Icons.picture_as_pdf,
                    color: color,
                  ),
                ),
              ),
              /*CircleAvatar(
                backgroundImage: NetworkImage('https://picsum.photos/200/200'),
              ),*/
            ),
            title: Text('${healthcare.name}'),
            subtitle: Align(
              alignment: Alignment.center,
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Row(children: [
                  Icon(
                    Icons.update,
                    //color: Colors.black,
                    size: 18.0,
                    semanticLabel: 'Letzte Änderung',
                  ),
                  Tooltip(
                    message: "letzte Änderung: " + DateFormat('dd.MM.yyyy H:m').format(DateTime.fromMillisecondsSinceEpoch(healthcare.lastModified * 1000)),
                    child: Text(
                      " " + timeago.format(DateTime.fromMillisecondsSinceEpoch(healthcare.lastModified * 1000), locale: 'de'), // source: https://stackoverflow.com/a/50632411 - users: Mahesh Jamdade & Alex Haslam - License: CC BY-SA 4.0
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ]),
              ),
            ), //Text('${healthcare.lastModified}'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HealthcareDetailsPage(healthcare: healthcare)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
