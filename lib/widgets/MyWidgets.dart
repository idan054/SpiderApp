//Flutter
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/pages/SpiderWebViewV2.dart';
import 'package:chat_app_with_firebase/pages/ThingWebView.dart';
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
  final VoidCallback  bottomSheetButton;
  bool isThingSaved;

  NewsTile({@required this.imgUrl,/*@required this.desc,*/
    @required this.title, @required this.postURL,
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
                            color: Colors.blue,//HexColor("#c81c19"),
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

