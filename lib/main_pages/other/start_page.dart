import 'package:flutter/material.dart';
import '../home_pages/horizontal_main_page.dart';
import '../home_pages/portrait_main_page.dart';

class HomePage extends StatefulWidget
{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  DateTime? currentBackPressTime;

  @override
  Widget build(BuildContext context)
  {
    return OrientationBuilder(
      builder: (context, orientation)
      {
        return orientation == Orientation.portrait ? PortraitMainPage() : HorizontalMainPage();
      },
    );
  }
}
