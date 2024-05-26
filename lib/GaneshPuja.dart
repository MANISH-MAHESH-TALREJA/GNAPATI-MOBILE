import 'package:flutter/material.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'Constants.dart';
import 'MainPages/Other/AppBarDrawer.dart';
import 'PujaOutput.dart';
import 'package:ganpati/MainPages/Other/AppBarDrawer.dart';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:ganpati/Models/NationalSongsModel.dart';

// ignore: must_be_immutable
class NavratriPuja extends StatefulWidget
{
  String url;
  List<String> titles;
  NavratriPuja(this.url, this.titles);
  @override
  State<StatefulWidget> createState() => _NavratriPujaState();
}

class _NavratriPujaState extends State<NavratriPuja>
{
  bool orange =true, white=false, green=false;
  var data;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context)
  {
    return OrientationBuilder(
        builder: (context, orientation)
        {
          return Scaffold(
              key: _scaffoldKey,
              appBar: RepublicDrawer().RepublicAppBar(context,widget.titles),
              body: FutureBuilder(
                future: getProductList(widget.url),
                builder: (context, AsyncSnapshot snapshot)
                {
                  switch (snapshot.connectionState)
                  {
                    case ConnectionState.none:
                    case ConnectionState.waiting:
                      return new RepublicDrawer().TirangaProgressBar(context, orientation);
                    default:
                      if (snapshot.hasError)
                        return Center(child: Image.asset("assets/images/ganpati_09.gif"));
                      else
                        return WorshipScaffold(context, snapshot, orientation);
                  }
                },
              )
          );
        }
    );
  }

  List<NationalSongsModel> categories;
  Future<List<NationalSongsModel>> getProductList(String page) async
  {
    Response response;
    response = await get(Uri.parse(page));
    int statusCode = response.statusCode;
    final body = json.decode(response.body);
    print(body);
    if (statusCode == 200)
    {
      categories = (body as List).map((i) => NationalSongsModel.fromJson(i)).toList();
      return categories;
    }
    else
    {
      return categories = [];
    }
  }

  // ignore: non_constant_identifier_names
  Widget WorshipScaffold(BuildContext context, AsyncSnapshot snapshot, Orientation orientation)
  {
    List<NationalSongsModel> data = snapshot.data;
    return ContainedTabBarView(
      tabs: [Text('CHALISA', style: TextStyle(color: Constants.BlueColor)), Text('STUTI', style: TextStyle(color: Constants.BlueColor)), Text('AARTI', style: TextStyle(color: Constants.BlueColor))],
      tabBarProperties: TabBarProperties(
          alignment: TabBarAlignment.center,
          innerPadding: const EdgeInsets.symmetric(
            horizontal: 10.0,
            vertical: 8.0,
          ),
          indicator: ContainerTabIndicator(
            radius: BorderRadius.circular(10.0),
            color: Constants.GreenColor,
            borderWidth: 2.0,
            borderColor: Constants.OrangeColor,
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey[400]),

      views: [PujaOutput(data[2].link, data[2].english, data[2].hindi), PujaOutput(data[1].link, data[1].english, data[1].hindi), PujaOutput(data[0].link, data[0].english, data[0].hindi)],
      onChange: (index) => print(index),
    );
  }
}
