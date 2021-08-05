import 'package:animate_do/animate_do.dart';
import 'package:chat_app_with_firebase/constants.dart';
import 'package:chat_app_with_firebase/pages/CustomNavigator.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';
import 'package:animate_do/animate_do.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'Services/ProductAndFeedStatus.dart';
import 'Tests/introductionToolTip.dart';


void main() => runApp( App() );

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  bool isShowIntro = false; //Change Me to False!
  bool isSplash = true;

  void checkIfFirstTime () async {
    // הצגת דיאלוג בפעם הראשונה בלבד, יש לשנות את שם הBool SharedPreferences
    // כדי להציג "בפעם הראשונה" פעם נוספת
    SharedPreferences syncBool = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
    bool introduction12=syncBool.getBool('introduction12') ?? false; // בדיקה עם בול "watchedIntro" על לא (נצפה)
    if(!introduction12 /*כלומר אם sizeExplainSnackBar לא קיים בכלל בזיכרון!*/) {
      setState(() {
        isShowIntro = true;
      });
      await syncBool.setBool('introduction12', true); //בסיום הפעולה יש לשנות את לא נצפה לנצפה
    }
  }

  Future disableSplash() async {
    await Future.delayed(
        Duration(seconds: 5)
      // finalFeedStatus.feedStatusPopular()
    );
    setState(() {
      isSplash = false;
    });
  }

  @override
  void initState() {
    super.initState();
    checkIfFirstTime();
    disableSplash();
  }

  @override
  Widget build(BuildContext context) {
    // final finalFeedStatus = Provider.of<FeedStatus>(context);

    // initState();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Spider3d",
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.green[800],
        accentColor: Colors.red[200],
      ),
      home:
      // advertiser3dPrinterDialog(showOnlyShareButton: true)
      // isShowIntro ?
      //   Intro()
      // :
      Stack(
        children: [
          CustomNavigator(),
          isSplash ? FadeIn(
              duration: Duration(milliseconds: 350),
              child: Scaffold(
                backgroundColor: Colors.black,
                body: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // FaIcon(FontAwesomeIcons.spider, color: spiderRed, size: 50,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 7),
                              child: SvgPicture.asset("assets/SVG/SpiderLogoWhiteBody.svg", /*color: svgIconColor,*/ height: 48,),
                            ),
                            Column(
                              children: [
                                Text("Spider",
                                  style: TextStyle(
                                    fontSize: 32, color: Colors.white,
                                    fontFamily: "AirStrike", fontWeight: FontWeight.w100,),
                                ),
                                Text("Models",
                                  style: TextStyle(
                                    fontSize: 32, color: spiderRed,
                                    fontFamily: "AirStrike", fontWeight: FontWeight.w100,),
                                ),
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                ),
                ),
              ) : Container()
        ],
      ),


      // SpiderWebViewV2(spiderLink: "https://www.spider3d.co.il/", isbackVisible0: false,)

      // PaymentWebView(link: "https://Google.com", name: "this is a very very long name but its normal",)
      // Shimmer()

//      ChangeNotifierProvider(
//        builder: (_) => FeedStatus(), /// שיב לב! חשוב לוודא שגם הclass של ProductAndFeedStatus תקין!
//        child: HomePage(), )
    );
  }
}

