import 'dart:async';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:toast/toast.dart';
import 'constants.dart';
import 'main_pages/Other/start_page.dart';

class SplashScreen extends StatefulWidget
{
  @override
  SplashScreenState createState() => new SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin
{
  var _visible = true;
  AnimationController? animationController;
  Animation<double>? animation;
  startTime() async
  {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() async
  {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    if(androidInfo.version.sdkInt >= 33.0)
    {
      PermissionStatus permissionStatus = await Permission.notification.status;
      if(permissionStatus.isGranted)
      {
        debugPrint("PERMISSION GRANTED");
      }
      else
      {
        await Permission.notification.request();
      }
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
  }

  @override
  void initState()
  {
    super.initState();
    animationController = new AnimationController(vsync: this, duration: new Duration(seconds: 2));
    animation = new CurvedAnimation(parent: animationController!, curve: Curves.easeOut);

    animation!.addListener(() => this.setState(() {}));
    animationController!.forward();

    setState(()
    {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);
    return Scaffold(
      backgroundColor: Constants.OrangeColor,
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>
          [
            new Image.asset(
              'assets/images/image.gif',
              width: animation!.value * 250,
              height: animation!.value * 250,
            ),
          ],
        ),
      ),
    );
  }
}
