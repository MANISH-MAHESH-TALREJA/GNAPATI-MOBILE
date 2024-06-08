import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ganpati/constants.dart';
import 'package:ganpati/ganesh_puja.dart';
import 'package:ganpati/mantra_list.dart';
import 'package:shimmer/shimmer.dart';
import 'package:toast/toast.dart';
import '../../first_tab_pages/parent_pages/image_files.dart';
import '../../general_utility_functions.dart';
import 'third_page.dart';

class FirstPage extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    ToastContext().init(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>
      [
        Padding(
          padding: const EdgeInsets.only(bottom : 5.0),
          child: SizedBox(
              height: MediaQuery.of(context).size.height/4.35,
              width: MediaQuery.of(context).size.width - 25,
              child: AnotherCarousel(
                images:
                [
                  CachedNetworkImageProvider(Constants.BannerNetworkImage_01),
                  CachedNetworkImageProvider(Constants.BannerNetworkImage_02),
                  CachedNetworkImageProvider(Constants.BannerNetworkImage_03),
                  CachedNetworkImageProvider(Constants.BannerNetworkImage_04),
                  CachedNetworkImageProvider(Constants.BannerNetworkImage_05),
                ],
                dotSize: 7.5,
                dotSpacing: 15.0,
                dotColor: Constants.OrangeColor,
                dotVerticalPadding: 5.0,
                dotIncreasedColor: Constants.GreenColor ,
                dotBgColor: Colors.transparent,
                borderRadius: true,
                indicatorBgPadding: 0.0,
                moveIndicatorFromBottom: 10.0,
                boxFit: BoxFit.fill,
                noRadiusForIndicator: true,
                overlayShadow: true,
                overlayShadowColors: Colors.transparent,
                overlayShadowSize: 0,
              )
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom:5.0),
          child: GestureDetector(
            onTap: () => Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ThirdPage())),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            child: Image.asset(
                                "assets/images/app_icon.png",
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.height/8.5,
                                width: MediaQuery.of(context).size.width / 2 - 25),
                          ),
                        ),
                        Shimmer.fromColors(
                            highlightColor: Constants.GreenColor,
                            baseColor: Constants.OrangeColor,
                            child: Text("SHREE GANESH GALLERY",
                                maxLines: 1,
                                style: TextStyle(
                                    fontSize: MediaQuery.of(context).size.width*0.05,
                                    color: Constants.BlueColor,
                                    fontWeight: FontWeight.bold)
                            ),
                        ),
                      ]
                  )
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () async => await check() ? Navigator.of(context).push(MaterialPageRoute(builder: (context) => NavratriPuja(Constants.NationalSymbolsAPI, Constants.AppBarShayari))) : showToast("INTERNET CONNECTION UNAVAILABLE"),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 2,
              child: Container(
                height: MediaQuery.of(context).size.height/4.35,
                width: MediaQuery.of(context).size.width - 25,
                child: GestureDetector(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>
                    [
                      Padding(
                        padding: const EdgeInsets.only(left:20.0, top:8, bottom:10),
                        child: Shimmer.fromColors(
                            highlightColor: Constants.GreenColor,
                            baseColor: Constants.OrangeColor,
                            child: Text(
                              'SHREE\nGANESH PUJA',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Constants.BlueColor,
                                //letterSpacing: 1.5,
                                fontWeight: FontWeight.bold,
                                fontSize: MediaQuery.of(context).size.width*0.05,
                              ),
                              maxLines: 4,
                            )
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right:15.0, top:8, bottom:10),
                        child: Image.asset(
                          'assets/images/ganpati_11.gif',
                          height: MediaQuery.of(context).size.height/4.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: <Widget>
        [
          FirstPortraitCard(context, "assets/images/ganpati_06.gif", "108 NAMES",MantraList(Constants.ShayariAPI, Constants.AppBar108Names)/*LiveVideo(Constants.liveVideoAPI) NationalSongs(Constants.NationalSongsAPI, Constants.AppBarSongs)*/ ),
          FirstPortraitCard(context, "assets/images/ganpati_05.gif", "LETTERS", ImageFiles(Constants.NameLettersAPI, Constants.AppBarNameLetters,"NAME LETTERS")),
        ]),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget FirstPortraitCard(BuildContext context, String image, String title, Widget nextPage)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:8.0),
      child: GestureDetector(
        onTap: () async => await check() ? Navigator.push(context, MaterialPageRoute(builder: (context) => nextPage)) : showToast("KINDLY CHECK YOUR INTERNET CONNECTION"),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          elevation: 2,
          child: Container(
            height: MediaQuery.of(context).size.height/5.5,
            width: MediaQuery.of(context).size.width / 2 - 25,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height/8.5,
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Shimmer.fromColors(
                    highlightColor: Constants.GreenColor,
                    baseColor: Constants.OrangeColor,
                    child: Text(title, style: TextStyle(fontSize: MediaQuery.of(context).size.width*0.05, fontWeight: FontWeight.bold)
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}