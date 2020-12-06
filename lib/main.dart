import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hydroponic/primarypage/splash.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
// import 'package:hidroponik/primarypage/splash.dart';
// import 'package:plantrobo/primarypage/splash.dart';
// import 'package:hidroponik/primarypage/splash.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  OneSignal.shared
      .init("cdf5e784-850b-452c-9ad4-d6ba4af80177", iOSSettings: null);
  OneSignal.shared
      .setInFocusDisplayType(OSNotificationDisplayType.notification);

  runApp(MyApp());
}

// ! you can customize this error widget with your own
Widget getErrorWidget(BuildContext context, FlutterErrorDetails error) {
  return Container();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ToDo: use this method to hide the status bar on your phone
    SystemChrome.setEnabledSystemUIOverlays([]);

    // ToDo: use this method to show the status bar on your phone
    // SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);

    // ! use this function to avoid the red error with error widget
    ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
      return getErrorWidget(context, errorDetails);
    };
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    return MaterialApp(
        title: "Hidroponik",
        debugShowCheckedModeBanner: false,
        home: Splashscreen());
  }
}
