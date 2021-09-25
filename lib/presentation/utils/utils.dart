import 'package:flutter/material.dart';

class Utils {
  // source: https://github.com/codestronaut/flutter_responsive_onboarding/blob/main/lib/utils/utils.dart
  static String getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 550 ? 'phone' : 'tablet';
  }
}