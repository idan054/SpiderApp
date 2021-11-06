import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:introduction_screen/introduction_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
//Flutter
import 'package:flutter/material.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/Services/ApiService.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/pages/PaymentWebView.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart'; //_controllerמשוייך לקונטרולר שכולו לא פעיל
import 'package:translator/translator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app_with_firebase/constants.dart';
import 'dart:async';
import 'package:chat_app_with_firebase/widgets/DecorationWidgets.dart';
import 'package:chat_app_with_firebase/widgets/MyWidgets.dart';
import 'package:chat_app_with_firebase/Services/GoogleSheetsConnection.dart';
import 'package:flutter/gestures.dart';
//Flutter
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/pages/JoinAsSellerV2.dart';
import 'package:chat_app_with_firebase/pages/SpiderWebViewV2.dart';
import 'package:chat_app_with_firebase/pages/ThingWebView.dart';
import 'package:chat_app_with_firebase/pages/CustomNavigator.dart';
import '../constants.dart';
//Packages
import 'package:translator/translator.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';
//Flutter
import 'package:flutter/material.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/Services/ApiService.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/pages/PaymentWebView.dart';
//Packages
import 'package:animate_do/animate_do.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:solid_bottom_sheet/solid_bottom_sheet.dart'; //_controllerמשוייך לקונטרולר שכולו לא פעיל
import 'package:translator/translator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:chat_app_with_firebase/constants.dart';
import 'dart:async';
import 'package:chat_app_with_firebase/widgets/DecorationWidgets.dart';
import 'package:chat_app_with_firebase/widgets/MyWidgets.dart';
import 'package:chat_app_with_firebase/Services/GoogleSheetsConnection.dart';
import 'package:flutter/gestures.dart';

import 'FavoritePage.dart';


class Intro extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark.copyWith(statusBarColor: Colors.transparent),
    );

    return MaterialApp(
      title: 'Introduction screen',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: OnBoardingPage(),
    );
  }
}

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

  /*Global*/ String introReferredValue;

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  final GlobalKey<FormBuilderState> introReferredForm = GlobalKey<FormBuilderState>();

  TextEditingController introReferredTextEditingController;

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.jpg', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  /*Future */restoreIntroReferredValue() async {
    print('restoring IntroReferredValue the String...');
    // שלב א' קריאה לSharedPreferences
    SharedPreferences introReferredPref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
    // שלב ב' שחזור (הרשימה) של SharedPreferencesי
    introReferredPref.getKeys().forEach((key) {
      print('משחזרd $key with value of ${introReferredPref.get(key)}');
    });
    // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית
    setState(() {
      introReferredValue = (introReferredPref.getStringList('introReferredPref') ?? '');
      introReferredTextEditingController = new TextEditingController(text: introReferredValue);
    });
    print ("introReferredPref is $introReferredValueערך הוא ");
    print ("introReferredPref is $introReferredValueערך הוא ");
  }

  @override
  void initState()  {
    super.initState();
    restoreIntroReferredValue();
    // introReferredTextEditingController = new TextEditingController(text: _introReferred);
    // introReferredTextEditingController.addListener(_introReferredChanged);
  }
  // initState();

  @override
  Widget build(BuildContext context) {
    bool isIos = Theme.of(context).platform == TargetPlatform.iOS;
    bool isAndroid = Theme.of(context).platform == TargetPlatform.android;

     var bodyStyle = simpleText(fontSize: 19, color: Colors.black);
     var pageDecoration =  PageDecoration(
      titleTextStyle: simpleTextBold(fontSize: 28, color: Colors.black),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

/*     // region 0.1-0.4 הגדרת משתנים


     String _introReferred;


     /// 0.2 פעולת השמירה
     save({String key, dynamic value}) async {
       print('saving ${key} with value of ${value}');

       final SharedPreferences sSharedPrefs = await SharedPreferences.getInstance();

       if (value is String) {
         sSharedPrefs.setString(key, value);

       } else if (value is List<String>) {
         sSharedPrefs.setStringList(key, value);
       }
     }

     /// 0.3 הגדרת פעולת השמירה בהתאם לשדה
     void _introReferredChanged() {
       save(key: 'introReferred',
           value: introReferredTextEditingController.text
       );
     }

     /// 0.4 יצירה והגדרת פעולת השחזור
     restoreIntroReferred() async {
       print('restoring introReferred...');
       final SharedPreferences mainSharedPrefs = await SharedPreferences.getInstance();
       mainSharedPrefs.getKeys().forEach((key) {
         print('restored $key with value of ${mainSharedPrefs.get(key)}');
       });
       setState(() {
         _introReferred = (mainSharedPrefs.getString('introReferred') ?? '');
         introReferredTextEditingController.text = _introReferred;
       });
     }


     /// 1 קריאה מקדימה לפני תצוגה
     @override
     void initState() {
       super.initState();
       restoreIntroReferred();
       introReferredTextEditingController = new TextEditingController(text: _introReferred);
       introReferredTextEditingController.addListener(_introReferredChanged);
     }
     // initState();

     // endregion 0.1 - 0.4 הגדרת משתנים*/

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "ברוכים הבאים",
/*          body:
          "הזמינו וחפשו בעברית כל מודל 3D מהמאגר הגדול בעולם",*/
          bodyWidget: Text( "הזמינו וחפשו בעברית כל מודל 3D מהמאגר הגדול בעולם",
            textDirection: TextDirection.rtl, textAlign: TextAlign.center,
            style: bodyStyle,
          ),
          image: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width*0.13, right: MediaQuery.of(context).size.width*0.13,
                top: 30, bottom: 10),
            child:  SvgPicture.asset("assets/SVG/undraw_social_influencer_spiderRed.svg", /*color: svgIconColor,*/ height: 40,),
          ),
          decoration: pageDecoration,
        ),

        PageViewModel(
          title: "פרגנו לנו",
/*          body:
          "הזמינו וחפשו בעברית כל מודל 3D מהמאגר הגדול בעולם",*/
          bodyWidget: Text( "השקענו מאות שעות במיוחד בשבילכם, זו ההזדמנות שלכם להעריך (:",
            textDirection: TextDirection.rtl, textAlign: TextAlign.center,
            style: bodyStyle,
          ),
          image:                         Image(
              height: 180, width: 180,
              image: AssetImage("assets/images/undraw_Appreciation_heart_love.jpg",)
          ),
          decoration: pageDecoration,
          footer: RaisedButton(
            onPressed: () {

              // introKey.currentState?.animateScroll(0);
              if (isAndroid == true) {
                // Android-specific code
                launchURL("https://rebrand.ly/SpiderModelsAndroid");
              } else if (isIos == true) {
                // iOS-specific code
                launchURL("https://rebrand.ly/SpiderModelsIos");
              }

            },
            child:  Text(
              'דרג אותנו',
              style: simpleTextBold(fontSize: 14, color: Colors.white),
            ),
            color: spiderRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
        ),

        PageViewModel(
          title: "דבר אחרון",
/*          body:
          "הזמינו וחפשו בעברית כל מודל 3D מהמאגר הגדול בעולם",*/
          bodyWidget: Text( "חשוב לנו לדעת מי הזמין אותך לנסות את האפליקציה",
            textDirection: TextDirection.rtl, textAlign: TextAlign.center,
            style: bodyStyle,
          ),
          image: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width*0.15, right: MediaQuery.of(context).size.width*0.15,
                top: 10, bottom: 10),
            child:  SvgPicture.asset("assets/SVG/undraw_arrived_mail.svg", /*color: svgIconColor,*/ height: 40,),
          ),
          decoration: pageDecoration,
          footer:
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.1),
            child: Column(
              children: [
                FormBuilder(
                  key: introReferredForm,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: FormBuilderTextField(
                      controller: introReferredTextEditingController,
                      name: 'introReferred',
//                            initialValue: /*isLoggedIn ? _googleSignIn.currentUser.email :*/ "",
                      cursorColor: Colors.grey[800], //spiderRed,
                      textAlign: TextAlign.end,
                      textDirection: TextDirection.rtl,
                      decoration: greyDeliveryDecorationSvgPrefix(
                        hintText: "שם או כינוי המזמין",
                        // icons: Icons.alternate_email
                        svgIcon: "assets/SVG/Material/drafts-24px.svg",
                      ),
                      onChanged: (val) {
                        introReferredValue = val;
                        print(introReferredValue);
                      },
                      onSaved:  (val) {
                        // introReferredValue = val;
                        print("introReferred is $val");
                      },
                      // validator: [
                        // FormBuilderValidators.required(errorText: "ענה על שדא זה"), //שדה זה הוא חובה
                      // ],
                    ),
                  ),
                ),
                Transform.translate(
                    offset: Offset(0, -5),
                    child: RichText(
                      text: TextSpan(
                        text: 'אף אחד לא הזמין אותי',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[500],
                            fontFamily: "Assistant", fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline, decorationThickness: 1.5 ),
                        recognizer: TapGestureRecognizer()..
                        onTap = () {
                        print("אף אחד לא הזמין אותי");
                          Navigator.pushReplacement(context, MaterialPageRoute(
                            builder: (context) => CustomNavigator(),
                          ));
                        },
                      ),
                    )
                )
              ],
            ),
          ),
        ),
        
        



      ],
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: false,
      showNextButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip:  Text('דלג'),
      next:  Icon(Icons.arrow_forward),
      //next:  isAndroid ? Icon(Icons.arrow_forward) : Icon(Icons.arrow_forward_ios),
      done:  Text('סיום', style: TextStyle(fontWeight: FontWeight.w600)),
      onDone: () async {


        if (introReferredForm.currentState.saveAndValidate()) {
          print(introReferredForm.currentState.value);

          ///שמירת introReferredPref
          // שלב א' קריאה לSharedPreferences
          SharedPreferences introReferredPref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
          // שלב ב' שחזור (הרשימה) של SharedPreferencesי
          introReferredPref.getKeys().forEach((key) {
            print('משחזרd $key with value of ${introReferredPref.get(key)}');
          });
          // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית
/*                          setState(() {
                            favTitleList = (introReferredPref.getStringList('introReferredPref') ?? '');
                          });*/

          print(introReferredTextEditingController);
          print(introReferredValue);

          // שלב ד' שמירת הרשימה מחדש (בזכות שלב ג', מקומית + מה שנוסף)
          introReferredPref.setString('introReferredPref', introReferredValue); // בדיקה עם בול "watchedIntro" על לא (נצפה)
          //שלב ה' בונוס בדיקה בסיסית
          setState(() {
            String justString = introReferredPref.getString("introReferredPref");
            print(justString);
          });

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => CustomNavigator() ),
          );

        } else {

          print('האימות נכשל! אך אלו התוצאות:');
          print(introReferredForm.currentState.value);

          ///שמירת introReferredPref
          // שלב א' קריאה לSharedPreferences
          SharedPreferences introReferredPref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
          // שלב ב' שחזור (הרשימה) של SharedPreferencesי
          introReferredPref.getKeys().forEach((key) {
            print('משחזרd $key with value of ${introReferredPref.get(key)}');
          });
          // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית
          setState(() {
            favTitleList = (introReferredPref.getStringList('introReferredPref') ?? '');
          });

          print(introReferredTextEditingController);
          print(introReferredValue);

          // שלב ד' שמירת הרשימה מחדש (בזכות שלב ג', מקומית + מה שנוסף)
          introReferredPref.setString('introReferredPref', introReferredValue); // בדיקה עם בול "watchedIntro" על לא (נצפה)
          //שלב ה' בונוס בדיקה בסיסית
          setState(() {
            String justString = introReferredPref.getString("introReferredPref");
            print(justString);
          });

          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => CustomNavigator() ),
          );
        }


      },
      dotsDecorator:  DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeColor: spiderRed,
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}