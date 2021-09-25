import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:aareisewarnungen/data/healthcare_model.dart';
import 'package:aareisewarnungen/main.dart';
import 'package:aareisewarnungen/domain/healthcare_api.dart';
import 'package:aareisewarnungen/presentation/components/loading_widget.dart';
import 'package:aareisewarnungen/presentation/components/healthcare_tile.dart';
import 'package:aareisewarnungen/presentation/screens/home_page.dart';

import 'package:flutter_easylogger/console_overlay.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import 'package:dynamic_color_theme/color_picker_dialog.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';

class HealthcarePage extends StatefulWidget {
  @override
  _HealthcarePageState createState() => _HealthcarePageState();
}

class _HealthcarePageState extends State<HealthcarePage> {
  List<Healthcare> _healthcare = <Healthcare>[];
  List<Healthcare> _healthcareDisplay = <Healthcare>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHealthcares().then((value) {
      setState(() {
        _isLoading = false;
        Logger.d("adding healthcare to listview ...");
        _healthcare.addAll(value);
        _healthcareDisplay = _healthcare;
        Logger.d("showing " + value.length.toString() + " list items ");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Color color = DynamicColorTheme.of(context).color;
    bool isDark = DynamicColorTheme.of(context).isDark;

    return Scaffold(
      appBar: AppBar(
        title: Text('Gesundheitshinweise'),
      ),
      drawer: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              /*decoration: BoxDecoration(
                color: Colors.blue,
              ),*/
              child: Padding(
                padding: EdgeInsets.all(12.0),
                child: Text('AA Reisewarnungen'),
              ),
            ),
            ListTile(
              title: const Text('Reisehinweise'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Gesundheitshinweise'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HealthcarePage(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Lizenzen'),
              onTap: () {
                showLicensePage(
                  // source: https://stackoverflow.com/questions/62685417/how-do-i-set-up-the-showlicensepage-function-to-work-with-flutter#62685702
                  context: context,
                  // applicationIcon: Image.asset(name)
                  // applicationName: "App Name"
                  // Other parameters
                );
              },
            ),
            ListTile(
              title: const Text('Logs anzeigen'),
              onTap: () {
                ConsoleOverlay.show(context); // source: https://github.com/niezhiyang/flutter_logger/
              },
            ),
            ListTile(
              title: const Text('Logs verstecken'),
              onTap: () {
                ConsoleOverlay.remove(); // source: https://github.com/niezhiyang/flutter_logger/
              },
            ),
            ListTile(
              title: const Text('dark mode'),
              onTap: () {
                DynamicColorTheme.of(context).setIsDark(
                  isDark: !isDark,
                  shouldSave: true,
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Container(
          child: ListView.builder(
            itemBuilder: (context, index) {
              if (!_isLoading) {
                return index == 0 ? _searchBar() : HealthcareTile(healthcare: this._healthcareDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _healthcareDisplay.length + 1,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: color,
        icon: Icon(Icons.color_lens),
        label: Text(''), // Text('Color Picker'),
        onPressed: () {
          showDialog(
            builder: (BuildContext context) {
              return WillPopScope(
                child: ColorPickerDialog(
                  defaultColor: kDarkBlue,
                  defaultIsDark: false,
                  title: 'Farbe wählen',
                  cancelButtonText: 'Abbrechen',
                  confirmButtonText: 'OK',
                  shouldAutoDetermineDarkMode: true,
                  shouldShowLabel: true,
                ),
                onWillPop: () async {
                  DynamicColorTheme.of(context).resetToSharedPrefsValues();
                  return true;
                },
              );
            },
            context: context,
          );
        },
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _healthcareDisplay = _healthcare.where((u) {
              var healthcareName = u.name.toLowerCase();
              return healthcareName.contains(searchText);
            }).toList();
          });
        },
        // controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Gesundheitshinweis suchen',
        ),
      ),
    );
  }
}
