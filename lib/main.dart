import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:aareisewarnungen/presentation/screens/home_page.dart';

import 'package:flutter_easylogger/console_overlay.dart';
import 'package:flutter_easylogger/console_widget.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
//import 'package:flutter_flipperkit/flutter_flipperkit.dart';

import 'package:timeago/timeago.dart' as timeago;

import 'package:dynamic_color_theme/color_picker_dialog.dart';
import 'package:dynamic_color_theme/dynamic_color_theme.dart';

const kDarkBlue = const Color(0xFF1C136B);
const kWhite = Colors.white;
const kLightGrey = const Color(0xFFE8E8E8);
const kDarkGrey = const Color(0xFF303030);

void main() {
  Logger.init(
    true,
    isShowFile: true,
    isShowTime: true,
    isShowNavigation: true,
    levelVerbose: 247,
    levelDebug: 26,
    levelInfo: 28,
    levelWarn: 3,
    levelError: 9,
    phoneVerbose: Colors.white54,
    phoneDebug: Colors.blue,
    phoneInfo: Colors.green,
    phoneWarn: Colors.yellow,
    phoneError: Colors.redAccent,
  );

  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.dumpErrorToConsole(details);
    Logger.e(details);
    //if (kReleaseMode) exit(1);
  };

  //FlipperClient flipperClient = FlipperClient.getDefault();

  /*flipperClient.addPlugin(new FlipperNetworkPlugin(
      // If you use http library, you must set it to false and use https://pub.dev/packages/flipperkit_http_interceptor
      // useHttpOverrides: false,
      // Optional, for filtering request
      filter: (HttpClientRequest request) {
    String url = '${request.uri}';
    if (url.startsWith('https://via.placeholder.com') || url.startsWith('https://gravatar.com')) {
      return false;
    }
    return true;
  }));*/
  //flipperClient.addPlugin(new FlipperSharedPreferencesPlugin());
  //flipperClient.start();

  // Add a new locale messages
  timeago.setLocaleMessages('de', timeago.DeMessages());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return DynamicColorTheme(
      data: (Color color, bool isDark) {
        return _buildTheme(color, isDark);
      },
      defaultColor: kDarkBlue,
      defaultIsDark: false,
      themedWidgetBuilder: (BuildContext context, ThemeData theme) {
        return MaterialApp(
          title: 'AA Reisewarnungen',
          theme: theme,
          debugShowCheckedModeBanner: false,
          home: HomePage(),
        );
      },
    );
  }

  ThemeData _buildTheme(Color accentColor, bool isDark) {
    final ThemeData base = isDark ? ThemeData.dark() : ThemeData.light();
    final Color primaryColor = isDark ? kDarkGrey : kWhite;

    return base.copyWith(
      accentColor: accentColor,
      accentTextTheme: _buildTextTheme(base.accentTextTheme, accentColor),
      cardColor: primaryColor,
      floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
        backgroundColor: accentColor,
      ),
      iconTheme: base.iconTheme.copyWith(
        color: accentColor,
      ),
      primaryColor: primaryColor,
      primaryIconTheme: base.primaryIconTheme.copyWith(
        color: accentColor,
      ),
      primaryTextTheme: _buildTextTheme(base.primaryTextTheme, accentColor),
      scaffoldBackgroundColor: primaryColor,
      textSelectionTheme: _buildTextSelectionTheme(base.textSelectionTheme, accentColor, isDark),
      textTheme: _buildTextTheme(base.textTheme, accentColor),
    );
  }

  TextTheme _buildTextTheme(TextTheme base, Color color) {
    return base.copyWith(
      bodyText2: base.bodyText2!.copyWith(
        fontSize: 16,
      ),
      bodyText1: base.bodyText1!.copyWith(
        color: color,
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
      button: base.button!.copyWith(
        color: color,
      ),
      caption: base.caption!.copyWith(
        color: color,
        fontSize: 14,
      ),
      headline5: base.headline5!.copyWith(
        color: color,
        fontSize: 24,
      ),
      subtitle1: base.subtitle1!.copyWith(
        color: color,
        fontSize: 18,
      ),
      headline6: base.headline6!.copyWith(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextSelectionThemeData _buildTextSelectionTheme(TextSelectionThemeData base, Color accentColor, bool isDark) {
    return base.copyWith(
      cursorColor: accentColor,
      selectionColor: isDark ? kDarkGrey : kLightGrey,
      selectionHandleColor: accentColor,
    );
  }
}

/*
dark mode implementation -> source: https://gist.github.com/ben-xx/10000ed3bf44e0143cf0fe7ac5648254
BUG: some

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();

  /// InheritedWidget style accessor to our State object.
  /// We can call this static method from any descendant context to find our
  /// State object and switch the themeMode field value & call for a rebuild.
  static _MyAppState of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  /// 1) our themeMode "state" field
  ThemeMode _themeMode = ThemeMode.system;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AAReisewarnungen',
      theme: ThemeData(),
      darkTheme: ThemeData.dark(),
      themeMode: _themeMode, // 2) ← ← ← use "state" field here //////////////
      home: HomePage(),
    );
  }

  /// 3) Call this to change theme from any context using "of" accessor
  /// e.g.:
  /// MyApp.of(context).changeTheme(ThemeMode.dark);
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }
}
*/
