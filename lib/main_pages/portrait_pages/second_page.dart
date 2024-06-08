import 'package:flutter/material.dart';
import 'package:ganpati/constants.dart';
import 'package:toast/toast.dart';
import '../../first_tab_pages/parent_pages/image_files.dart';
import '../../first_tab_pages/parent_pages/national_songs.dart';
import '../../first_tab_pages/parent_pages/national_symbols.dart';
import '../../general_utility_functions.dart';
import '../../second_tab_pages/parent_pages/ringtone_files.dart';
import '../../second_tab_pages/parent_pages/video_files.dart';

class SecondPage extends StatefulWidget
{
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage>
{
  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            NavratriCard("assets/images/ganpati_05.gif", Color(0xFFFF9500), "AARTI",NationalSongsList(Constants.NationalSongsAPI, Constants.AppBarSongs)),
            NavratriCard("assets/images/ganpati_03.gif", Color(0xFFFF9500), "STATUS",VideoFiles(Constants.VideoStatusAPI, Constants.AppBarStatus)),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: GestureDetector(
            onTap: () async => await check() ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> NationalSymbols(Constants.UnknownFactsAPI, Constants.AppBarIndia))) : showToast("KINDLY CHECK YOUR INTERNET CONNECTION"),
            child: Stack(
              children:
              [
                Container(
                    height: MediaQuery.of(context).size.height*0.15,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        image: DecorationImage(
                            image: AssetImage('assets/images/navratri_08.gif'),
                            fit: BoxFit.fill
                        ),
                        color: Colors.transparent
                    )
                ),
                Positioned.fill(
                    child: Container(
                        height: MediaQuery.of(context).size.height*0.15,
                        width: MediaQuery.of(context).size.width*0.9,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          color: Colors.purpleAccent.withOpacity(0.9),
                        )
                    )
                ),
                Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width*0.25,
                          child: Image(image: AssetImage("assets/images/navratri_07.gif"), fit:BoxFit.fill
                          )
                      ),
                    )
                ),
                Positioned.fill(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                          height: 90,
                          width: MediaQuery.of(context).size.width*0.25,
                          child: Image(image: AssetImage("assets/images/navratri_07.gif"), fit:BoxFit.fill
                          )
                      ),
                    )
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      'जय श्री गणेश',textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white, fontSize: 26.0, fontWeight: FontWeight.bold),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:
          [
            NavratriCard("assets/images/ganpati_09.gif", Constants.GreenColor, "WALLPAPER", ImageFiles(Constants.WallpaperAPI, Constants.AppBarWallpaper,"WALLPAPER")),
            NavratriCard("assets/images/ganpati_10.gif", Constants.GreenColor, "RINGTONE", RingtoneFiles(Constants.RingtoneAPI, Constants.AppBarRingtone)),
          ],
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget NavratriCard(String image, Color backColor, String text, Widget NavratriWidget)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: GestureDetector(
        onTap: () async => await check() ? Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=> NavratriWidget)) : showToast("KINDLY CHECK YOUR INTERNET CONNECTION"),
        child: Stack(
          children:
          [
            Container(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.width*0.4,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25.0),
                    color: Colors.transparent
                )
            ),
            Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: MediaQuery.of(context).size.height*0.17,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                          image: DecorationImage(
                              image: AssetImage('assets/images/navratri_08.gif'),
                              fit: BoxFit.fill
                          )
                      )
                  ),
                )
            ),
            Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      height: MediaQuery.of(context).size.height*0.17,
                      width: MediaQuery.of(context).size.width*0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25.0),
                        color: backColor.withOpacity(0.9),
                      )
                  ),
                )
            ),
            Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                      height: MediaQuery.of(context).size.height*0.13,
                      width: MediaQuery.of(context).size.width*0.25,
                      child: Image(image: AssetImage(image), fit:BoxFit.fill
                      )
                  ),
                )
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height*0.17,
              child: Align(
                alignment: Alignment.topCenter,
                child: Text(text,textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white, fontSize: MediaQuery.of(context).size.width*0.06, fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}