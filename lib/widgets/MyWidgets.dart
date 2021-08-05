//Flutter
import 'package:chat_app_with_firebase/pages/FavoritePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/pages/JoinAsSellerV2.dart';
import 'package:chat_app_with_firebase/pages/SpiderWebViewV2.dart';
import 'package:chat_app_with_firebase/pages/ThingWebView.dart';
import 'package:chat_app_with_firebase/pages/CustomNavigator.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share/share.dart';
import '../constants.dart';
import 'DecorationWidgets.dart';
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
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'DecorationWidgets.dart';
import 'MyWidgets.dart';//Packages
import 'package:animate_do/animate_do.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
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
import 'package:hexcolor/hexcolor.dart';


// import 'package:url_launcher/url_launcher.dart';
launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(
        url,
        forceWebView: false,
    );
  } else {
    throw 'Could not launch $url';
  }
}


Widget myAppBar(){
  return AppBar(
    title: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "Flutter",
          style:
          TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        Text(
          "News",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600),
        )
      ],
    ),
    backgroundColor: Colors.transparent,
    elevation: 0.0,
  );
}


class NewsTile extends StatefulWidget {
  final String imgUrl, title, /*desc,*/ postURL;
  final VoidCallback orderButton;
  final VoidCallback  bottomSheetButton;
  bool isThingSaved;

  NewsTile({@required this.imgUrl,/*@required this.desc,*/
    @required this.title, @required this.postURL, this.orderButton,
    this.bottomSheetButton, this.isThingSaved,});

  @override
  _NewsTileState createState() => _NewsTileState();
}

class _NewsTileState extends State<NewsTile> {

  @override
  Widget build(BuildContext context) {
    GoogleTranslator translator = new GoogleTranslator();   //using google translator

    return GestureDetector(
      child: Stack(
        children: [
          Container(
              margin: EdgeInsets.only(bottom: 12), //רווח מתחת לכפתורים
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  alignment: Alignment.bottomCenter,
                  decoration:
                  BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(6),bottomLeft:  Radius.circular(6)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FadeIn(
                        duration: Duration(milliseconds: 300),
                        child:
                        Material(
                          borderRadius: BorderRadius.circular(8),
                          elevation: 5,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              widget.imgUrl,
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                              /*loadingBuilder: (context, child, loadingProgress) =>
                                      Center(child: CircularProgressIndicator(
                                        strokeWidth: 2, backgroundColor: Colors.black45,),),*/
                            ),
                          ),
                        )
                      ),
                      SizedBox(height: 12,),
                      Row(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.73,
                            color: Colors.green.withOpacity(0.00),
                            child: Text(  widget.title,
                              maxLines: 2,
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),//
                          Visibility(
                            visible: false, //עקב חוסר תקינות מתמשך, פיצ'ר זה לא ייצא בגרסא 1.0
                            child: widget.isThingSaved ?
                            IconButton(
                              icon: Icon(Icons.bookmark),
                              onPressed: () async {
                                setState(() {
                                  widget.isThingSaved = false;
                                });

                                favTitleList.remove(widget.title);
                                favUrlList.remove(widget.postURL);
                                favImageList.remove(widget.imgUrl);

                                /// ניקוי המידע שנשמר
                                removeValues() async {
                                  SharedPreferences removePref = await SharedPreferences.getInstance();
                                  removePref.setStringList('favoriteTitlePref', favTitleList); // בדיקה עם בול "watchedIntro" על לא (נצפה)
                                  //שלב ה' בונוס בדיקה בסיסית
                                  setState(() {
                                    List justList = removePref.getStringList("favoriteTitlePref" ?? '');
                                    print(justList);
                                  });

                                  removePref.setStringList('favoriteUrlPref', favUrlList); // בדיקה עם בול "watchedIntro" על לא (נצפה)
                                  //שלב ה' בונוס בדיקה בסיסית
                                  setState(() {
                                    List justList = removePref.getStringList("favoriteUrlPref" ?? '');
                                    print(justList);
                                  });

                                  removePref.setStringList('favoriteImagesPref', favImageList); // בדיקה עם בול "watchedIntro" על לא (נצפה)
                                  //שלב ה' בונוס בדיקה בסיסית
                                  setState(() {
                                    List justList = removePref.getStringList("favoriteImagesPref" ?? '');
                                    print(justList);
                                  });
                                }
                                removeValues();
                              },
                            )
                            :
                            IconButton(
                              icon: Icon(Icons.bookmark_border),
                              onPressed: () async {
                                setState(() {
                                  widget.isThingSaved = true;
                                });
                                favTitleList.add(widget.title);
                                favUrlList.add(widget.imgUrl);
                                favImageList.add(widget.imgUrl);
/*
                                ///רשימת כותרות
                                // שלב א' קריאה לSharedPreferences
                                SharedPreferences favoriteTitlePref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
                                // שלב ב' שחזור (הרשימה) של SharedPreferencesי
                                favoriteTitlePref.getKeys().forEach((key) {
                                  print('משחזרd $key with value of ${favoriteTitlePref.get(key)}');
                                });
                                // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית
*/
/*                          setState(() {
                                  favTitleList = (favoriteTitlePref.getStringList('favoriteTitlePref') ?? '');
                                });*//*


                                favTitleList.add(widget.title);
                                print(favTitleList);
                                print(favTitleList.length);

                                // שלב ד' שמירת הרשימה מחדש (בזכות שלב ג', מקומית + מה שנוסף)
                                favoriteTitlePref.setStringList('favoriteTitlePref', favTitleList); // בדיקה עם בול "watchedIntro" על לא (נצפה)
                                //שלב ה' בונוס בדיקה בסיסית
                                setState(() {
                                  List justList = favoriteTitlePref.getStringList("favoriteTitlePref" ?? '');
                                  print(justList);
                                });
                                ///רשימת קישורים
                                // שלב א' קריאה לSharedPreferences
                                SharedPreferences favoriteUrlPref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
                                // שלב ב' שחזור (הרשימה) של SharedPreferencesי
                                favoriteUrlPref.getKeys().forEach((key) {
                                  print('משחזרd $key with value of ${favoriteUrlPref.get(key)}');
                                });
                                // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית
*/
/*                          setState(() {
                                  favUrlList = (favoriteUrlPref.getStringList('favoriteUrlPref') ?? '');
                                });*//*


                                favUrlList.add(widget.imgUrl);
                                print(favUrlList);
                                print(favUrlList.length);
                                // שלב ד' שמירת הרשימה מחדש (בזכות שלב ג', מקומית + מה שנוסף)
                                favoriteUrlPref.setStringList('favoriteUrlPref', favUrlList); // בדיקה עם בול "watchedIntro" על לא (נצפה)
                                //שלב ה' בונוס בדיקה בסיסית
                                setState(() {
                                  List justList = favoriteUrlPref.getStringList("favoriteUrlPref" ?? '');
                                  print(justList);
                                });
                                ///רשימת תמונות
                                // שלב א' קריאה לSharedPreferences
                                SharedPreferences favoriteImagesPref = await SharedPreferences.getInstance(); //SharedPreferencesקריאה ל
                                // שלב ב' שחזור (הרשימה) של SharedPreferencesי
                                favoriteImagesPref.getKeys().forEach((key) {
                                  print('משחזרd $key with value of ${favoriteImagesPref.get(key)}');
                                });
                                // שלב ג' סנכרון (הרשימה) של SharedPreferencesי עם הרשימה המקומית
*/
/*                          setState(() {
                                  favImageList = (favoriteImagesPref.getStringList('favoriteImagesPref') ?? '');
                                });*//*


                                favImageList.add(widget.imgUrl);
                                print(favImageList);
                                print(favImageList.length);
                                // שלב ד' שמירת הרשימה מחדש (בזכות שלב ג', מקומית + מה שנוסף)
                                favoriteImagesPref.setStringList('favoriteImagesPref', favImageList); // בדיקה עם בול "watchedIntro" על לא (נצפה)
                                //שלב ה' בונוס בדיקה בסיסית
                                setState(() {
                                  List justList = favoriteImagesPref.getStringList("favoriteImagesPref" ?? '');
                                  print(justList);
                                });
*/

                              },
                            ),
                          )
                        ],
                      ),
                /// תיאור התמונה
/*                  Text(
                        desc,
                        maxLines: 2,
                        style: TextStyle(color: Colors.black54, fontSize: 14),
                      ),
                      SizedBox( height: 10,
                      ), */
                      SizedBox(height: 6,),
                    /// שורת הכפתורים
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Spacer(),
                       redOutlineButton(
                         buttonTitle: "פרטים",
                         isBold: false,
                         onPressed: () {
                         setState(() {
                           onThingWebViewPage = true;
                         });
                         print("${widget.postURL}");
                         Navigator.push(context, MaterialPageRoute(
                         builder: (context) =>  ThingWebView(link: widget.postURL, name: widget.title,)
                         ));
//                          Navigator.push(context, MaterialPageRoute(
//                              builder: (context) => myWebView("https://www.thingiverse.com/thing:1972871") //'https://www.spider3d.co.il/' //עובד ע"י קישור ספיידר
//                          ));
                         //launchURL(postURLl);
                       },),

                          //region FlatButton צבע מלא
                          /* FlatButton(
                            color: Colors.blue,//Hexcolor("#c81c19"),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius
                                  .circular(99),),

                            child: Text(
                              "פרטים",
                              style: TextStyle(
                                fontSize:16, color: Colors.white,
                                fontFamily: "Assistant", fontWeight: FontWeight.w600,
                              ),),

                            onPressed: () {
                              print("$postURL");
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (context) =>  ThingWebView(link: postURL, name: title,)

                              ));
//                          Navigator.push(context, MaterialPageRoute(
//                              builder: (context) => myWebView("https://www.thingiverse.com/thing:1972871") //'https://www.spider3d.co.il/' //עובד ע"י קישור ספיידר
//                          ));
                          //launchURL(postURLl);
                            },
                          ),*/
                          //endregion FlatButton צבע מלא

                          Spacer(),
                          redOutlineButton(
                            buttonTitle: "הזמן",
                            isBold: true,
                            onPressed: widget.orderButton
                          ),
                          Spacer(),
                        ],
                      ),
                      SizedBox(height: 6,),
                    ],
                  ),
                ),
              )
          ),
          Visibility(
            visible: false, //מאפשר יציאה מהאפליקציה ביתר קלות...
            child: Container(
              alignment: Alignment.topRight,
              padding: EdgeInsets.all(15),
              child: Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  color: Colors.grey
                ),
                child: Center(
                  child: IconButton(
                    icon: Icon(Icons.share), color: Colors.white, iconSize: 17,
                    onPressed: () { },
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}


Card popUp3stepCard ({
  String cardTitle,
  String cardSubtitle,
  String assetImage,
  String assetSVG,
  // String svgIcon,
  // Color svgIconColor
}){
  return Card(
    color: Colors.white,
    // margin: EdgeInsets.symmetric(vertical: 50), //מרווח מחוץ לכרטיס
    elevation: 7,
    shadowColor: Colors.black26,
    child: ListTile(
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        title: Text(cardTitle,
          // maxLines: 1,
          overflow: TextOverflow.ellipsis, //3 נק' אם יותר משורה
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
              fontFamily: "Assistant",
              fontSize: 18
          ),),

        subtitle: Text(cardSubtitle,
          textDirection: TextDirection.rtl,
          style: TextStyle(
              color: Colors.grey[600],
              fontWeight: FontWeight.w600,
              fontFamily: "Assistant",
              fontSize: 15
          ),),

        trailing:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child:  SvgPicture.asset(assetSVG, /*color: svgIconColor,*/ height: 48,),
        ),

          // Image(image: AssetImage(assetImage),)

/*        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child:  SvgPicture.asset(svgIcon, color: svgIconColor, height: 24,),
        ),*/

/*        Icon(
          Icons.check_circle_outline,
          color: Colors.green[500].withOpacity(0.75),
          size: 40, //44
        )*/
    ),
  );
}



class CategoryButton extends StatelessWidget {
  final String title;
  final String background;
  final VoidCallback  button;

  CategoryButton (this.title, this.background , this.button,);

  @override
  Widget build(BuildContext context) {
    return
      Padding(
      padding: EdgeInsets.symmetric(horizontal: 5),
         child: Container(
         // foregroundDecoration: BoxDecoration(
         //     color: Colors.black.withOpacity(0.10),
         //     borderRadius: BorderRadius.circular(5),
         // ),
          height: 65, //שליטה בגובה של הקטגוריות
           width: 100,
          padding: EdgeInsets.symmetric(horizontal: 0),
             decoration: BoxDecoration(
               color: Colors.white60,
               borderRadius: BorderRadius.circular(5),
               image: DecorationImage(
                 image: //PrecacheImage()
                 AssetImage (background),
                 fit: BoxFit.fill,
                 colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.10), BlendMode.darken)
               ),
               boxShadow: [
                  new BoxShadow(
                    color: Color(0x33000000),
                    blurRadius: 4.0,
                    offset: Offset (-2.0, 2.0,),
                  ),]
             ),
          child: FlatButton(
            child: Text(title,
              textAlign: TextAlign.center,
              style: shadowTextBold(
                fontSize: 18,
                color: Colors.white
              ),
            ),
            onPressed: button,
          ),
      ),
    );

  }
}

Container selectColor ({String colorTitle, String imageAsset}){
  return Container(
      height: 50, width: 50,
      decoration: BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black26,
              blurRadius: 5.0,
              offset: Offset (0.0, 1.0,),
            ),
          ],
          borderRadius: BorderRadius.circular(12),
          image: DecorationImage(
              image:  AssetImage(imageAsset),
              fit: BoxFit.fill
          ) ),
           child: Center(child: Text(colorTitle,
               style: shadowTextBold(
                 fontSize: 18,
                 color: Colors.white
               )
           )
      ) );
}

Container selectPaymentOption ( {String title} ){
  return Container(
      /*height: 50,*/
      width: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),),
      child: Center(
          child: Text(title,
          // softWrap: true,
          style: TextStyle(
            fontSize:16, color: Colors.grey[500], //Colors.black,
            fontFamily: "Assistant", fontWeight: FontWeight.w600,
          ),
      )
      ) );
}

/*

Widget deliveryForm({
  VoidCallback saveButton,
//  ValueChanged onChanged,
  TextEditingController fullNameController,
  TextEditingController cityController,
  TextEditingController streetController,
  TextEditingController phoneController,
  TextEditingController mailController,
  bool showFormStatus
}){

  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final ValueChanged _onChanged = (val) => print(val);
  showFormStatus = false;


  return
    AspectRatio(
      aspectRatio: 4/3.4,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Container(height: 700, width: 400,
            child:
            FormBuilder(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Row(
                    children: [
                      /// טלפון
                      Flexible(
                        child: FormBuilderTextField(
                          controller: phoneController,
                          attribute: 'phone_number',
//                                  initialValue: '',
                          maxLength: 10,
                          cursorColor: Colors.grey[800], //spiderRed,
                          textAlign: TextAlign.end,
                          //textDirection: TextDirection.ltr,
                          decoration: greyDeliveryDecorationSvgPrefix(
                              hintText: "טלפון",
                              // icons: Icons.phone
                              svgIcon: "assets/SVG/Material/phone-24px.svg"
                          ),
                          onChanged: _onChanged,
                          validators: [
                            FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                            FormBuilderValidators.numeric(errorText: "אנא הכנס מספרים בלבד"), // מספרים בלבד
                            FormBuilderValidators.maxLength(10, errorText: "הכנס בדיוק 10 ספרות"),
                            FormBuilderValidators.minLength(10, errorText: "הכנס בדיוק 10 ספרות"),
                          ],
                        ),
                      ),

                      SizedBox(width: 10,),

                      /// שם מלא
                      Flexible(
                        child: FormBuilderTextField(
                          controller: fullNameController,
                          attribute: 'Full_Name',
//                                  initialValue: '',
                          cursorColor: Colors.grey[800], //spiderRed,
                          textAlign: TextAlign.end,
                          //textDirection: TextDirection.ltr,
                          decoration: greyDeliveryDecorationSvgPrefix(
                              hintText: "שם מלא",
                              // icons: Icons.perm_identity
                              svgIcon: "assets/SVG/Material/perm_identity_profile-24px.svg"
                          ),
                          onChanged: _onChanged,
                          validators: [
                            FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                          ],
                        ),
                      ),
                    ],
                  ),

                  /// אימייל
                  FormBuilderTextField(
                    controller: mailController,
                    attribute: 'Email',
//                            initialValue: /*isLoggedIn ? _googleSignIn.currentUser.email :*/ "",
                    cursorColor: Colors.grey[800], //spiderRed,
                    textAlign: TextAlign.end,
                    //textDirection: TextDirection.ltr,
                    decoration: greyDeliveryDecorationSvgPrefix(
                        hintText: "מייל",
                        // icons: Icons.alternate_email
                        svgIcon: "assets/SVG/Material/alternate_email-24px.svg"
                    ),
                    onChanged: _onChanged,
                    validators: [
                      FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                      FormBuilderValidators.email(errorText: "אנא הכנס מייל תקין"),
                    ],
                  ),

                  Row(
                    children: [

                      /// רחוב ומס'
                      Flexible(
                        flex: 3,
                        child: FormBuilderTextField(
                          controller: streetController,
                          attribute: 'Street_And_Number',
//                                  initialValue: '',
                          cursorColor: Colors.grey[800], //spiderRed,
                          textAlign: TextAlign.end,
                          textDirection: TextDirection.ltr,
                          decoration: greyDeliveryDecorationSvgPrefix(
                              hintText: "'רחוב ומס",
                              // icons: Icons.home
                              svgIcon: "assets/SVG/Material/home-24px-round.svg"
                          ),
                          onChanged: _onChanged,
                          validators: [
                            FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                          ],
                        ),
                      ),

                      SizedBox(width: 10,),

                      /// עיר
                      Flexible(
                        flex: 2,
                        child: FormBuilderTextField(
                          controller: cityController,
                          attribute: 'City',
//                                  initialValue: '',
                          cursorColor: Colors.grey[800], //spiderRed,
                          textAlign: TextAlign.end,
                          //textDirection: TextDirection.ltr,
                          decoration: greyDeliveryDecorationSvgPrefix(
                              hintText: "עיר",
                              // icons: Icons.location_on
                              svgIcon: "assets/SVG/Material/location_on-24px.svg"
                          ),
                          onChanged: _onChanged,
                          validators: [
                            FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                          ],
                        ),
                      ),
                    ],
                  ),



                  /// כפתור שמור
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Container( // קונטיינר כפתור
                      height: 35, width: 75,
                      child: OutlineButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),),
                        borderSide: BorderSide(color: Colors.black26, width: 1.2, ),
                        highlightedBorderColor: Colors.black26,
                        child: Text('שמור',
                            style: simpleText(fontSize: 16, color: Colors.black26),
                            semanticsLabel: 'שמור'),
                        onPressed: saveButton
                      ),
                    ),
                  ),
                  //כפתורי שליחה  ואיפוס

                  Text(
                    showFormStatus ?  "המידע נשמר בהצלחה!" : "",
                    textDirection: TextDirection.rtl,
                    style: simpleText(fontSize: 16, color: Colors.green)
                    //basicTextStyle(colors: Colors.green),
                  )
                ],
              ),
            )
        ),
      ),
    );
}

 */

Widget seller3PointsDialog () { //דיאלוג 3 שלבים הצטרף כמוכר
  return StatefulBuilder(
    builder: (context, setState) =>
      Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),),
      insetPadding: EdgeInsets.symmetric(horizontal: 20),
      elevation: 5,
      child: Stack(
        children: [
          IntrinsicWidth(
            child: IntrinsicHeight(
              child: SingleChildScrollView(
                padding: EdgeInsets.only( left: 10, right: 10 ),
                child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 15,),
                    Text(
                      "מעוניין למכור מודלים?",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 22, color: Colors.black,
                        fontFamily: "Assistant", fontWeight: FontWeight.w700,
                      ),
                    ),

                    SizedBox(height: 5,),
                    Text(
                      "זו ההזדמנות שלך!",
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 20, color: Colors.black,
                        fontFamily: "Assistant", fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 10),

                    popUp3stepCard(
                        cardTitle: "1. הצטרף כמוכר",
                        cardSubtitle: 'הרשם חינם וקבל מאיתנו קופון הנחה הכולל את המזהה האישי שלך',
                        // assetImage: "assets/images/ImageIcon/SellerPaperAndPen100.png"
                        assetSVG: "assets/SVG/FlatIcon/SellerPaperAndPen100.svg"
                    ),
                    popUp3stepCard(
                        cardTitle: "2. הדפס מודלים",
                        cardSubtitle: 'שתף את הקופון שלך והדפס מודלים ללקוחות שהזמינו',
                        // assetImage: "assets/images/ImageIcon/3dCubePrint100.png"
                        assetSVG: "assets/SVG/FlatIcon/3dCubePrint100.svg"
                    ),
                    popUp3stepCard(
                        cardTitle: "3. קבל תשלום",
                        cardSubtitle: 'שלח בדואר את המודלים ללקוחות וקבל מאיתנו תשלום',
                        // assetImage: "assets/images/ImageIcon/EarnBagSalary100.png" //"assets/images/ImageIcon/EarnCoinSmartphone100.png"
                        assetSVG: "assets/SVG/FlatIcon/EarnBagSalary100.svg"


                    ),

                    SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Spacer(),
                        redOutlineButton(
                            buttonTitle: "רכוש מדפסת",
                            isBold: false,
                            onPressed: () {
                              // Navigator.pop(context, 'העלמות התראה');
                              Navigator.push(context, MaterialPageRoute( // https://www.spider3d.co.il/מדפסות-תלת-מימד
                                  builder: (context) =>  SpiderWebViewV2(spiderLink: "https://www.spider3d.co.il/%d7%9e%d7%93%d7%a4%d7%a1%d7%95%d7%aa-%d7%aa%d7%9c%d7%aa-%d7%9e%d7%99%d7%9e%d7%93/",
                                  isbackVisible0: true,)
                              ));
                              // CustomNavigator(currentIndex: 1,);
                            },),
                        // SizedBox(width: 10),
                        Spacer(),
                       redOutlineButton(
                           buttonTitle: "הצטרף עכשיו",
                           isBold: true,
                           onPressed: () {
                             Navigator.push(context, MaterialPageRoute(
                             builder: (context) =>  JoinAsSellerV2()
                         ));
                         // Navigator.pop(context, 'העלמות התראה');
                       }),
                        Spacer(),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            right: 0, top: 0, //הצמדה בלבד לימין למעלה
            child: IconButton(
                iconSize: 25,
                splashColor: Colors.grey.withOpacity(0.70),
                icon: Icon(Icons.clear, color: Colors.grey),
                onPressed: () {
                  Navigator.pop(context);
                }
            ),
          ),

        ],
      ),
    ),
  );
}

Widget sizeProductExplainDialog({@required double bottomPadding}) { //דיאלוג 3 שלבים הצטרף כמוכר
  return StatefulBuilder(
    builder: (context, setState) =>
        Dialog(
          // backgroundColor: Colors.grey[300],

          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),),
          insetPadding: EdgeInsets.only(left: 20, right: 20,
              bottom: bottomPadding),//(default is 0)
          elevation: 5,
          child: Stack(
            children: [
              IntrinsicWidth(
                child: IntrinsicHeight(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only( left: 10, right: 10 ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container( //קונטיינר ליצירת מידה לדיאלוג
                            color: Colors.green,
                            width: MediaQuery.of(context).size.width),

                        SizedBox(height: 10,),

                        //SvgPicture.asset("assets/SVG/undraw_shopping_app_redsvg.svg",/*color: spiderRed,*/ height: 200,width: 200),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Column(
                            children: [
                              Text(
                                  //"לשמירה על איכות המודלים שנמכרים: ",
                                  'כל המודלים מודפסים מחומרים איכותיים ע"י מוכרים מקצועיים',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: simpleTextBold(fontSize: 18, color: Colors.grey[dark])
                              ),
                              SizedBox(height: 10),
                              Text(
                                  //"לשמירה על איכות המודלים שנמכרים: ",
                                  'מידות המודל מתייחסות לקצוות הקיצוניים של כל מודל',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: simpleTextBold(fontSize: 16, color: Colors.grey[dark].withOpacity(0.65) ),
                              ),
                              SizedBox(height: 5),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Text('8 ס"מ',
                                    textDirection: TextDirection.rtl,
                                    style: simpleText(fontSize: 16, color: Colors.grey[dark].withOpacity(0.65)),
                                  ),
                                  SizedBox(width: 4,),
                                  Text('S',
                                      style: simpleTextBold(fontSize: 20, color: Colors.grey[dark])
                                  ),

                                  // SizedBox(width: 4,),
                                  Spacer(),

                                  Text('14 ס"מ',
                                    textDirection: TextDirection.rtl,
                                    style: simpleText(fontSize: 16, color: Colors.grey[dark].withOpacity(0.65)),
                                  ),
                                  SizedBox(width: 4,),
                                  Text('M',
                                      style: simpleTextBold(fontSize: 20, color: Colors.grey[dark])
                                  ),

                                  // SizedBox(width: 4,),
                                  Spacer(),
                                  Text('19 ס"מ',
                                    textDirection: TextDirection.rtl,
                                    style: simpleText(fontSize: 16, color: Colors.grey[dark].withOpacity(0.65)),
                                  ),
                                  SizedBox(width: 4,),
                                  Text('L',
                                      style: simpleTextBold(fontSize: 20, color: Colors.grey[dark])
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        redOutlineButton(
                            buttonTitle: "הבנתי",
                            isBold: true,
                            onPressed: () { //טופס הצטרפות למוכרים ומשווקים
                              Navigator.pop(context, 'העלמות התראה');
                            }),
                        SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: false,
                child: Positioned(
                  right: 5, top: 5, //הצמדה בלבד לימין למעלה
                  child: IconButton(
                      iconSize: 25,
                      splashColor: Colors.grey.withOpacity(0.70),
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),
                ),
              ),

            ],
          ),
        ),
  );
}

Widget filament3dPrinterDialog () { //דיאלוג 3 שלבים הצטרף כמוכר
  return StatefulBuilder(
    builder: (context, setState) =>
        Dialog(
          // backgroundColor: Colors.grey[300],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),),
          insetPadding: EdgeInsets.symmetric(horizontal: 20),
          elevation: 5,
          child: Stack(
            children: [
              IntrinsicWidth(
                child: IntrinsicHeight(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only( left: 10, right: 10 ),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container( //קונטיינר ליצירת מידה לדיאלוג
                            color: Colors.green,
                            width: MediaQuery.of(context).size.width),

                        SizedBox(height: 5,),

                        //SvgPicture.asset("assets/SVG/undraw_shopping_app_redsvg.svg",/*color: spiderRed,*/ height: 200,width: 200),
                        Image(
                            height: 200, width: 200,
                            image: AssetImage("assets/images/undraw_shopping_app_red.jpg",)
                        ),

                        SizedBox(height: 5,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(
                            "לשמירה על איכות המודלים שנמכרים: ",
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: simpleTextBold(fontSize: 18, color: Colors.grey[dark])
                          ),
                        ),
                        SizedBox(height: 15),
                        RichText(
                          // key: shimmerKey,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "את כל ההזמנות תדפיסו מPLA, של Esun או Spider USA, (",
                                style: simpleText(fontSize: 16, color: Colors.grey[dark].withOpacity(0.65) ),
                              ),
                              TextSpan(
                                text: 'כדאי להצטייד מכאן',
                                style: TextStyle(
                                    fontSize: 16, color: Colors.blue[dark].withOpacity(0.75),
                                    fontFamily: "Assistant", fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline, decorationThickness: 1.5 ),
                                    recognizer: TapGestureRecognizer()..
                                    onTap = () {
                                      print('30% Tapped');

                                      // Navigator.pop(context, 'העלמות התראה');
                                      Navigator.push(context, MaterialPageRoute( /* https://www.spider3d.co.il/צבעים-מותאמים-למוכרים */
                                          builder: (context) =>  SpiderWebViewV2(spiderLink: "https://www.spider3d.co.il/צבעים-מותאמים-למוכרים",
                                            isbackVisible0: true, showSavePageSuggestion: true, canExit: true,),
                                      ));
                                      // CustomNavigator(currentIndex: 1,);
                                    },
                              ),
                              TextSpan(
                                // text: ' של לקוח שהוריד את האפליקציה דרכך. לא תצטרך להדפיס מודלים ותקבל 30% מכל עסקה',
                                text: '), ב15% מילוי לפחות ובגובה שכבה מינימאלי של 0.2 מ"מ.',
                                style: simpleText(fontSize: 16, color: Colors.grey[dark].withOpacity(0.65) ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        redOutlineButton(
                            buttonTitle: "עבור לטופס ההצטרפות",
                            isBold: true,
                            onPressed: () { //טופס הצטרפות למוכרים ומשווקים
                              launchURL("https://forms.gle/Gw6on17xU7nmh1e17");
                              // Navigator.pop(context, 'העלמות התראה');
                            }),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),

              Visibility(
                visible: true,
                child: Positioned(
                  right: 5, top: 5, //הצמדה בלבד לימין למעלה
                  child: IconButton(
                      iconSize: 25,
                      splashColor: Colors.grey.withOpacity(0.70),
                      icon: Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        Navigator.pop(context);
                      }
                  ),
                ),
              ),

            ],
          ),
        ),
  );
}

Container simpleContainer (Color stringColor){
  return Container(
    height: 40.0, width: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: stringColor,
    ),
  );
}

Widget redOutlineButton ({
  @required String buttonTitle,
  @required bool isBold,
  @required VoidCallback onPressed,
}) {
  bool localIsBold = isBold;
  return              
    OutlineButton(
    highlightColor: spiderRed.withOpacity(0.20),
    highlightedBorderColor: spiderRed,
    color: spiderRed,
    borderSide: BorderSide(color: spiderRed, width: 1),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(99),),

     child: Text( buttonTitle,
      textDirection: TextDirection.rtl,
      style: TextStyle(
        fontSize:16, color: spiderRed,
        fontFamily: "Assistant",
        fontWeight: localIsBold ? FontWeight.w700 : FontWeight.w600,
      ),),

     onPressed: onPressed
  );
}

Widget redFlatButton ({
  @required String buttonTitle,
  @required bool isBold,
  @required bool isShadow,
  @required VoidCallback onPressed,
  double horizontalPadding,
  double verticalPadding,
}) {
  double fontSize = 18;
  return
    FlatButton(
        highlightColor: spiderRed.withOpacity(0.20),
        // highlightedBorderColor: spiderRed,
        color: spiderRed,
        // borderSide: BorderSide(color: spiderRed, width: 1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(99),),
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
        child: Text( buttonTitle,
          textDirection: TextDirection.rtl,
          style:
          isShadow ?
            isBold ? shadowTextBold(fontSize: fontSize, color: Colors.white ) : shadowText(fontSize: fontSize, color: Colors.white)
          : isBold ? simpleTextBold(fontSize: fontSize, color: Colors.white) : simpleText(fontSize: fontSize, color: Colors.white)
/*          TextStyle(
            fontSize:16, color: Colors.white,
            fontFamily: "Assistant",
            fontWeight: localIsBold ? FontWeight.w700 : FontWeight.w600,
          ),*/
        ),

        onPressed: onPressed
    );
}

Widget squareOutlineButton({
 Color color = Colors.black26,
 @required String title,
  double containerSize = 35,
  double fontSize = 16,
  @required VoidCallback onPressed,
}) {
  return Container( // קונטיינר כפתור
    height: containerSize,
    width: containerSize*2.15,

    child: OutlineButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),),
      borderSide: BorderSide(color: color, width: 1.2,),
      highlightedBorderColor: color,
      child: Text('$title',
          style: simpleText(fontSize: fontSize, color: color),
          semanticsLabel: '$title'),
      onPressed: onPressed,
    ),
  );
}

Widget svgTitleExplain ({
  String svg,
  String title,
  String explain,
}) {
  return
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
          child:  SvgPicture.asset(svg, /*color: svgIconColor,*/ height: 62,),
        ),
        Text(title,
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
          style: simpleTextBold(fontSize: 22, color: Colors.grey[dark]),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Text(explain,
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: simpleText(fontSize: 18, color: Colors.grey[dark].withOpacity(0.65) ),
          ),
        ),
      ],
  ),
    );
}

