import 'package:flutter/material.dart';
import 'package:chat_app_with_firebase/widgets/FeedWidget.dart';
import 'package:chat_app_with_firebase/Services/ApiService.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:hexcolor/hexcolor.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/Services/ApiService.dart';
import 'package:chat_app_with_firebase/widgets/MyWidgets.dart';
//Flutter
//MyPages & Widgets
//Packages
import 'package:animate_do/animate_do.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart'; //_controllerמשוייך לקונטרולר שכולו לא פעיל
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../constants.dart';

List<String> favImageList = List(); // var myList = [];
List<String> favTitleList = List(); // var myList = [];
List<String> favUrlList = List(); // var myList = [];

/// עמוד ראשי ///
class FavoritePage extends StatefulWidget {

  final List<X3ModelString> homePageValues;
  FavoritePage({this.homePageValues});

  @override
  _FavoritePageState createState() => _FavoritePageState();
}
GoogleTranslator translator = new GoogleTranslator();   //using google translator

class _FavoritePageState extends State<FavoritePage> {
  String searchValue = ""; //ברירת המחדל לפני פעולת חיפוש אקטיבית
  FaIcon dependIcon = FaIcon(FontAwesomeIcons.search, color: HexColor("#c81c19")); //הגדרת ברירת המחדל
  Widget dependSearchBar = Image(
    image: AssetImage("assets/images/SpiderLogo.png"), height: 25,);
  Widget spiderAppBar = Image(
    image: AssetImage("assets/images/SpiderLogo.png"), height: 25,);


    @override
    Widget build(BuildContext context) {
      List reversedTitleList = favTitleList.reversed.toList(); //כדי שהחדש ביותר יופיע למעלה
      List reversedUrlList = favUrlList.reversed.toList(); //כדי שהחדש ביותר יופיע למעלה
      List reversedImageList = favImageList.reversed.toList(); //כדי שהחדש ביותר יופיע למעלה
      
      return
      Scaffold(
        appBar: AppBar(
          backgroundColor:  Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(left: 14,top: 3), // left: 8
            child: Image( image: AssetImage("assets/images/SpiderLogo.png"),height: 25,),
          ),
          leading: BackButton(
              color: spiderRed),
        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: favTitleList.length,
            // reverse: true,
            itemBuilder: (BuildContext context, int index) {
              return
                NewsTile(
                // title:  favTitleList[index],
                title:  reversedTitleList[index],
                // imgUrl: favImageList[index],
                imgUrl: reversedImageList[index],
                // postURL: favUrlList[index],
                postURL: reversedUrlList[index],
                isThingSaved: true,
                orderButton: () async {
                  //_controller.isOpened ? _controller.hide() : _controller.show();
                  //translateTitle(); //מדפיס את השם מתורגם
                  setState(() {
                    sizePrice = 69;
                    selectedColor = "";   //ניקוי בחירת הצבע לאחר ייצוא לאקסל
                    showOrderResult = false;
                    //על מנת להכריח לבחור צבע כל פעם מחדש (פעולה אקטיבית אחת)
//                          timer.cancel();
//                          showMyBottomSheet = true;
//                          myBottomSheetV2(context: context, /*scrollController: scrollController*/);
//                     settingModalBottomSheet(context);
//                          showMyBottomSheet = true;
//                   orderedURL = favUrlList[index]; //favUrlList[index];
                    orderedURL = reversedUrlList[index]; //favUrlList[index];
                    // orderedNameModel = favTitleList[index]; //favTitleList[index];
                    orderedNameModel = reversedTitleList[index]; //favTitleList[index];
                    print(orderedURL);
                  });
                  // הצגת דיאלוג בפעם הראשונה בלבד, יש לשנות את שם הBool SharedPreferences
                  // כדי להציג "בפעם הראשונה" פעם נוספת
                  SharedPreferences syncBool = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
                  bool sizeExplainDialog1=syncBool.getBool('sizeExplainDialog1') ?? false; // בדיקה עם בול "watchedIntro" על לא (נצפה)
                  if(!sizeExplainDialog1 /*כלומר אם sizeExplainSnackBar לא קיים בכלל בזיכרון!*/) {

                    Timer(Duration(seconds: 1), () {

                      showDialog(
                          barrierDismissible: true, //כדי לצאת
                          barrierColor: Colors.black26,
                          context: context,
                          builder: (context) =>
                              FadeIn(
                                  duration: Duration(milliseconds: 200),
                                  child: sizeProductExplainDialog( bottomPadding: MediaQuery.of(context).size.height*0.6 )
                              ));

                    });

                    await syncBool.setBool('sizeExplainDialog1', true); //בסיום הפעולה יש לשנות את לא נצפה לנצפה


                  }
                  //and when the tutorial ended set watchedIntro to true:
                }, //orderButton
                //() { print('${ApiValue.urlModel3}',); },
              );
            }
        ),
      );
    }
  }
