import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:aareisewarnungen/data/country_model.dart';
import 'package:aareisewarnungen/main.dart';
import 'package:aareisewarnungen/domain/country_api.dart';
import 'package:aareisewarnungen/presentation/components/loading_widget.dart';
import 'package:aareisewarnungen/presentation/components/user_tile.dart';
import 'package:aareisewarnungen/presentation/screens/healthcare_page.dart';

import 'package:flutter_easylogger/console_overlay.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import 'package:dynamic_color_theme/color_picker_dialog.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';

import 'package:diacritic/diacritic.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<User> _users = <User>[];
  List<User> _usersDisplay = <User>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers().then((value) {
      setState(() {
        _isLoading = false;
        Logger.d("adding users to listview ...");
        _users.addAll(value);
        _usersDisplay = _users;
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
        title: Text('Länder'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero, // Remove any padding from the ListView.
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
              title: const Text('Dark mode umschalten'),
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
                return index == 0 ? _searchBar() : UserTile(user: this._usersDisplay[index - 1]);
              } else {
                return LoadingView();
              }
            },
            itemCount: _usersDisplay.length + 1,
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
          searchText = removeDiacritics(searchText.toLowerCase());
          setState(() {
            _usersDisplay = _users.where((u) {
              var countryTitle = removeDiacritics(u.title.toLowerCase());
              var countryLastChanges = removeDiacritics(u.lastChanges.toLowerCase());
              //var countryContent = removeDiacritics(u.content.toLowerCase()); // removed due to memory consumption -> TODO: if possible replace with faster method
              return countryTitle.contains(searchText) || countryLastChanges.contains(searchText); // || countryContent.contains(searchText);
            }).toList();
          });
        },
        // controller: _textController,
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Land suchen',
        ),
      ),
    );
  }
}
