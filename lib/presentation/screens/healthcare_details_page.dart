import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:aareisewarnungen/data/healthcare_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:dynamic_color_theme/dynamic_color_theme.dart';

//import 'package:dio/dio.dart';
//import 'package:path_provider/path_provider.dart';

class HealthcareDetailsPage extends StatelessWidget {
  final Healthcare healthcare;

  HealthcareDetailsPage({required this.healthcare});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(healthcare.name),
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
              Padding(
                padding: EdgeInsets.all(7.0),
                child: Text(
                  healthcare.name,
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
              ),
              SizedBox(
                height: 20.0,
              ),
              SelectableText.rich(
                TextSpan(
                  text: 'Download:\n ', // default text style
                  children: <TextSpan>[
                    TextSpan(text: healthcare.url, style: TextStyle(fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              SizedBox(
                height: 16.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
