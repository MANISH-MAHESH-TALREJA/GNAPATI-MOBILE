import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart' hide ModalBottomSheetRoute;
import 'package:flutter/services.dart';
import 'constants.dart';
import 'notification_utility.dart';
import 'splash_screen.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: const FirebaseOptions(apiKey: "AIzaSyA9h4v9OTF-MThTsrTcpgjkFCgkJgx6vdE", appId: "1:431532816074:android:aa61ac4fc3ecd4bdb2e633", messagingSenderId: "431532816074", projectId: "manish-ganpati-bappa"));
  await NotificationUtility.initializeAwesomeNotification();

  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarIconBrightness:Brightness.dark));
  runApp(MaterialApp(
    title: Constants.AppName,
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.deepOrange, fontFamily: Constants.AppFont, useMaterial3: false, appBarTheme: const AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark
    )),
    home: SplashScreen(),
  ));
}
