//Flutter
// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/Services/ApiService.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'AppBarWidgetV2.dart';
import 'DecorationWidgets.dart';
import 'MyWidgets.dart';
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
import 'package:flutter/gestures.dart';

class FeedWidget extends StatefulWidget {

  final List<X3ModelString> modelApiValues; /// listStringArticles
  final List<T3ModelString> newTranslatedList; /// יש ליצור כפתור תרגום המתרגם את הכותרות (מבוסס index)
  FeedWidget({this.modelApiValues, this.newTranslatedList});
  @override
  _FeedWidgetState createState() => _FeedWidgetState();
}

class T3ModelString {

  X3ModelString _tModel3;
  T3ModelString({X3ModelString tValue}): _tModel3 = tValue;

  String get tNameModel3 {
    return _tModel3.nameModel3;
  }
}

// SolidController _controller = SolidController();
ScrollController scrollController = ScrollController();
String labelSize = "";
bool showOrderResult = false;
String orderResult = ""; // טקסט שמתאר את המצב
String orderedURL = ""; // טקסט שמתאר את המצב
String orderedNameModel = "";
String selectedColor = "NotSelected";
bool fastShipping = true;
bool showPrice = false;
//  bool haveDeliveryData = true;
bool showMyBottomSheet = false;
double sizePrice = 69;
double shippingPrice = 0;
double totalPrice = 69;
//bool showFormStatus = false;
final GlobalKey checkBox = GlobalKey();
GoogleTranslator translator = new GoogleTranslator();
bool isSwitched = false;
bool isShowReferredField = false;
// String finalColor;
String finalSize;

List<bool> checked = [false, true, false, false, true];
//  double totalPrice = sizePrice + shippingPrice;
//  List<CategoryModel> myCategories2 = List<CategoryModel>(); //ייתכן שיש צורך כדי לערוך רשימה
//  CategoryModel DataCategoryMode2; //ייתכן שיש צורך כדי לערוך רשימה

/// 0.1 הגדרת משתנים
String _name;
TextEditingController fullNameTextEditingController;
String _city;
TextEditingController cityTextEditingController;
String _street;
TextEditingController streetTextEditingController;
String _phone;
TextEditingController phoneTextEditingController;
String _mail;
TextEditingController mailTextEditingController;
String _referred;
TextEditingController referredTextEditingController;

//  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
bool showFormStatus = false;
// String formStatus = "המידע נשמר בהצלחה!";

/// ניקוי המידע שנשמר
removeValues() async {
  SharedPreferences removePref = await SharedPreferences.getInstance();
  //Remove String
  removePref.remove("nameController");
  removePref.remove("cityController");
  removePref.remove("streetController");
  removePref.remove("phoneController");
  removePref.remove("mailController");
  removePref.remove("referredController");
}


class _FeedWidgetState extends State<FeedWidget> {



  @override
  Widget build(BuildContext context) {
    var finalFeedStatus = Provider.of<FeedStatus>(context);

    final _searchController = TextEditingController();
    String searchValue = ""; //ברירת המחדל לפני פעולת חיפוש אקטיבית
    //final finalX3ModelString = Provider.of<X3ModelString>(context);
    //List<X3ModelString> finalListX3Model = new List<X3ModelString>();
//    final ApiValue = StatelessApiValues[index];


    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            //controller: scrollController,
            slivers: <Widget>[
              //              region SliverAppBar
              SliverAppBar(
                elevation: 5,
                backgroundColor: Colors.white,
                pinned: true,
                floating: true,
                expandedHeight: 135, //140.0,
                stretch: true,
                title: Transform.translate(
                  offset: Offset(0, -8),
                    child: AppBarWidgetV2()),
                flexibleSpace: FlexibleSpaceBar(
                  background: new Container(
                    // padding: new EdgeInsets.only(top: 40),
                    height: 120,
                    decoration: new BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
//                    ListView.builder(      -----------------------------------------------Laser
//                      itemCount: 20,
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                      itemBuilder: (context, index) {
//                        return Card(
//                          child:
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                reverse: true,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 10),
                                  child: Row(
                                    children: [

                                      CategoryButton("מערכות", "assets/images/Categories/JetEngineSystem.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Learning");} ),

                                      CategoryButton("דגמים",  "assets/images/Recommendation/ShinyToys.jpg", //"assets/images/Categories/EiffelModel.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Models"); } ),

                                      CategoryButton("לבית ולגינה", "assets/images/Recommendation/garden.jpg",//"assets/images/Categories/Homet.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Household"); } ),

                                      CategoryButton("כלי עבודה", "assets/images/Recommendation/Tools.jpg", //"assets/images/Categories/Tools.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Tools"); } ),

                                      CategoryButton("מגניבים", "assets/images/Recommendation/Toys.jpg", //"assets/images/Categories/HobbyRocket.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Hobby"); } ),

                                      CategoryButton("גאדג'טים", "assets/images/Recommendation/XboxGaming.jpg", //"assets/images/Categories/NintendoGadgets.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Gadgets"); } ),

                                      CategoryButton("אופנה", "assets/images/Recommendation/braceletFashionTsaMid.jpg", //"assets/images/Categories/Shoes.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Fashion"); } ),

                                      CategoryButton("אמנות", "assets/images/Categories/ArtGreekLamp.png",
                                          /*onPressed:*/ () { finalFeedStatus.feedStatusCategory("Art");

                                            //אם בתום הזמן עדיין מחפש, הצג "נסה שוב"
/*                                          Future showTryAgain() async {
                                            await Future.delayed(Duration(seconds: 3))
                                                .then((value) =>
                                                showDialog(
                                                barrierDismissible: true, //כדי לצאת
                                                barrierColor: backgroundColor,
                                                context: context,
                                                builder: (context) =>
                                                    FadeIn(
                                                        duration: Duration(milliseconds: 300),
                                                        child: advertiser3dPrinterDialog(
                                                            showOnlyShareButton: true ) )),
                                            );
                                          }
                                          showTryAgain();*/
                                          } ),

                                    ],
                                  ),
                                ),
                              ),
//                        );
//                      },
//                    ),                  ---------------------------------------------------Laser
                        //Text("AnyThing Here"),
                        //SizedBox(height: 5,)
                      ],
                    ),
                  ),
                ),
              ),
//              endregion SliverAppBar

              /// Sliver DeBug Edition
              /*          SliverList(
                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                  // To convert this infinite list to a list with three items,
                  // uncomment the following line:
                  // if (index > 3) return null;
                  return Column(
                    children: [
                      Container(color: Colors.white70, height: 5.0),
                      Container(color: Colors.white, height: 150.0),
                      Container(color: Colors.purple, height: 150.0),
                      Container(color: Colors.black, height: 5.0),
                    ],
                  );
                },
                  // Or, uncomment the following line:
                  childCount: 6,
                ),
              ),*/

              ///Sliver Release Edition
              SliverList(
                delegate:
                SliverChildBuilderDelegate(
                      (BuildContext context, int index) {

                    final ApiValue = widget.modelApiValues[index];

                    void translateTitle() { //מתרגם את השם
                      setState(() {
                        print(ApiValue.nameModel3);
                        translator.translate(ApiValue.nameModel3[index], from: 'en', to: 'iw').then((value) {
                          print(value);
                        });
                      });
                    }

                    //Todo (להחליף את כל הקטע שמתחת ב אייפיאי של פוסט ששואב מידע מהמקורות המתאימים (ומאפשר תצוגת גלרייה
                    return NewsTile(
                      imgUrl: ApiValue.thumbnailModel3, //favImageList[index],
                      title:  ApiValue.nameModel3,//favTitleList[index],
                      postURL: ApiValue.urlModel3, //favUrlList[index],
                      isThingSaved: false,
                          //() { print('${ApiValue.urlModel3}',); },
                    );
                  },
                  childCount: widget.modelApiValues.length,
                ),
              ),
            ],
          ),

          // isLoading ?             Center(
          //   child: CircularProgressIndicator(strokeWidth: 2),
          // ) : Container() ,

/*          AnimatedOpacity(
            opacity: showMyBottomSheet ? 1.0 : 0.2,
            duration: Duration(milliseconds: 600),
            child: showMyBottomSheet ? GestureDetector(
                onTap: () {
                  setState(() {
                    showMyBottomSheet = false;
                  });
                },
                child: _settingModalBottomSheet(context)) : Container(),
          ),*/

 /*         AnimatedPositioned(
            top: showMyBottomSheet ? 200:500,
//                padding: EdgeInsets.only(bottom: 0),//showMyBottomSheet ? 15 : 0),
//                height: showMyBottomSheet ? 500 : 0,
//            opacity: showMyBottomSheet ? 1.0 : 0.0,
              //alignment: isShowPrice ? Alignment.centerRight : Alignment.centerLeft,
              //bottom: showMyBottomSheet ? -300 : 10, //, left: showMyBottomSheet ? 100 : -100,
              //curve: Curves.easeIn,
              duration: Duration(milliseconds: 600),
              child: Container(
                height: 200, width: 300,
                child: _settingModalBottomSheet(context)
              ) //MyBottomSheet()
          ) // : Container(),*/
        ],
      ),

    );
  }

  // region 0.1-0.4 הגדרת משתנים


/*  restoreTitleList() async {
    print('restoring Title the List...');
    // שלב א' קריאה לSharedPreferences
    SharedPreferences favoriteTitlePref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
    // שלב ב' שחזור (הרשימה) של SharedPreferencesי
    favoriteTitlePref.getKeys().forEach((key) {
      print('משחזרd $key with value of ${favoriteTitlePref.get(key)}');
    });
    // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית

    setState(() {
      favTitleList = (favoriteTitlePref.getStringList('favoriteTitlePref') ?? '');
    });
    print ("favTitleList is $favTitleListהרשימה היא ");
  }


  restoreUrlList() async {
    print('restoring Url the List...');
    // שלב א' קריאה לSharedPreferences
    SharedPreferences favoriteUrlPref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
    // שלב ב' שחזור (הרשימה) של SharedPreferencesי
    favoriteUrlPref.getKeys().forEach((key) {
      print('משחזרd $key with value of ${favoriteUrlPref.get(key)}');
    });
    // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית

    setState(() {
      favUrlList = (favoriteUrlPref.getStringList('favoriteUrlPref') ?? '');
    });
    print ("favUrlList is $favUrlListהרשימה היא ");
  }


  restoreImagesList() async {
    print('restoring Images the List...');
    // שלב א' קריאה לSharedPreferences
    SharedPreferences favoriteImagesPref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
    // שלב ב' שחזור (הרשימה) של SharedPreferencesי
    favoriteImagesPref.getKeys().forEach((key) {
      print('משחזרd $key with value of ${favoriteImagesPref.get(key)}');
    });
    // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית

    setState(() {
      favImageList = (favoriteImagesPref.getStringList('favoriteImagesPref') ?? '');
    });
    print ("favImageList is $favImageListהרשימה היא ");
  }*/


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
  void _nameChanged() {
    save(key: 'nameController',
        value: fullNameTextEditingController.text
    );
  }
  void _cityChanged() {
    save(key: 'cityController',
        value: cityTextEditingController.text
    );
  }
  void _streetChanged() {
    save(key: 'streetController',
        value: streetTextEditingController.text
    );
  }
  void _phoneChanged() {
    save(key: 'phoneController',
        value: phoneTextEditingController.text
    );
  }

  void _mailChanged() {
    save(key: 'mailController',
        value: mailTextEditingController.text
    );
  }

  void _referredChanged() {
    save(key: 'referredController',
        value: referredTextEditingController.text
    );
  }

  /// 0.4 יצירה והגדרת פעולת השחזור
  restoreName() async {
    print('restoring Name...');
    final SharedPreferences mainSharedPrefs = await SharedPreferences.getInstance();
    mainSharedPrefs.getKeys().forEach((key) {
      print('restored $key with value of ${mainSharedPrefs.get(key)}');
    });
    setState(() {
      _name = (mainSharedPrefs.getString('nameController') ?? '');
      fullNameTextEditingController.text = _name;
    });
  }

  restoreCity() async {
    print('restoring City...');
    final SharedPreferences mainSharedPrefs = await SharedPreferences.getInstance();
    mainSharedPrefs.getKeys().forEach((key) {
      print('restored City $key with value of ${mainSharedPrefs.get(key)}');
    });
    setState(() {
      _city = (mainSharedPrefs.getString('cityController') ?? '');
      cityTextEditingController.text = _city;
    });
  }

  restoreStreet() async {
    print('restoring Street...');
    final SharedPreferences mainSharedPrefs = await SharedPreferences.getInstance();
    mainSharedPrefs.getKeys().forEach((key) {
      print('restore Street $key with value of ${mainSharedPrefs.get(key)}');
    });
    setState(() {
      _street = (mainSharedPrefs.getString('streetController') ?? '');
      streetTextEditingController.text = _street;
    });
  }

  restorePhone() async {
    print('restoring Phone...');
    final SharedPreferences mainSharedPrefs = await SharedPreferences.getInstance();
    mainSharedPrefs.getKeys().forEach((key) {
      print('restored Phone $key with value of ${mainSharedPrefs.get(key)}');
    });
    setState(() {
      _phone = (mainSharedPrefs.getString('phoneController') ?? '');
      phoneTextEditingController.text = _phone;
    });
  }

  restoreMail() async {
    print('restoring Mail...');
    final SharedPreferences mainSharedPrefs = await SharedPreferences.getInstance();
    mainSharedPrefs.getKeys().forEach((key) {
      print('restored Mail $key with value of ${mainSharedPrefs.get(key)}');
    });
    setState(() {
      _mail = (mainSharedPrefs.getString('mailController') ?? '');
      mailTextEditingController.text = _mail;
    });
  }

  referredMail() async {
    print('restoring referred...');
    final SharedPreferences mainSharedPrefs = await SharedPreferences.getInstance();
    mainSharedPrefs.getKeys().forEach((key) {
      print('restored Mail $key with value of ${mainSharedPrefs.get(key)}');
    });
    setState(() {
      _referred = (mainSharedPrefs.getString('referredController') ?? '');
      referredTextEditingController.text = _referred;
    });
  }

  /// 1 קריאה מקדימה לפני תצוגה
  @override
  void initState() {
    super.initState();
    restoreName();
    fullNameTextEditingController = new TextEditingController(text: _name);
    fullNameTextEditingController.addListener(_nameChanged);

    restoreCity();
    cityTextEditingController = new TextEditingController(text: _city);
    cityTextEditingController.addListener(_cityChanged);

    restoreStreet();
    streetTextEditingController = new TextEditingController(text: _street);
    streetTextEditingController.addListener(_streetChanged);

    restorePhone();
    phoneTextEditingController = new TextEditingController(text: _phone);
    phoneTextEditingController.addListener(_phoneChanged);

    restoreMail();
    mailTextEditingController = new TextEditingController(text: _mail);
    mailTextEditingController.addListener(_mailChanged);

    referredMail();
    referredTextEditingController = new TextEditingController(text: _referred);
    referredTextEditingController.addListener(_referredChanged);

/*    restoreTitleList();
    restoreUrlList();
    restoreImagesList();*/


  }

  // endregion 0.1 - 0.4 הגדרת משתנים

}

/*
Widget globalButtomSheet () {
  FeedWidget feedWidget = FeedWidget();
  feedWidget.modelApiValues
}
*/




