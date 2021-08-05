import 'package:animate_do/animate_do.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_with_firebase/widgets/DecorationWidgets.dart';
import 'package:chat_app_with_firebase/widgets/MyWidgets.dart';
import 'package:chat_app_with_firebase/widgets/QuestionAnswer.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:share/share.dart';
import 'package:chat_app_with_firebase/constants.dart';
import 'package:animate_icons/animate_icons.dart';


class JoinAsSellerV2 extends StatefulWidget {


  @override
  _JoinAsSellerV2State createState() => _JoinAsSellerV2State();
}


class _JoinAsSellerV2State extends State<JoinAsSellerV2> {
  int galleyIndex = 0;
  double containerHeight;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:  Colors.white,
        title: Padding(
          padding: const EdgeInsets.only(left: 14,top: 3), // left: 8
          child: Image( image: AssetImage("assets/images/SpiderLogo.png"),height: 25,),
        ),
        leading: BackButton(
            color: spiderRed),
      ),

      body: ListView(
        // padding: EdgeInsets.only(top: 200),
        children: [
          //region באנר ראשי
          Visibility(
            visible: true,
            child: Container(
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 1/1,
                    child: Container(
                      height: containerHeight,
                      decoration: new BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Colors.grey[700], Colors.black]
                          ),
                          image: DecorationImage(
                            //onError: ImageErrorListener(),
                            //שים לב! תמונת Asset נטענת בפתיחת האפליקציה.
                              image:  AssetImage("assets/images/FilamnetBG.jpg"),
                              fit: BoxFit.fitHeight,
                              colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.10), BlendMode.darken)
                          )
                      ),
                      padding: new EdgeInsets.only(top: 100,/* bottom: 90*/),
                      child: Column(
                            mainAxisAlignment: MainAxisAlignment.center, //Start = הכי גבוה
                            crossAxisAlignment: CrossAxisAlignment.center, //Start = הכי שמאלי
                            children: <Widget>[
//
//                    ListView.builder(      -----------------------------------------------Laser
//                      itemCount: 20,
//                      shrinkWrap: true,
//                      scrollDirection: Axis.horizontal,
//                      itemBuilder: (context, index) {
//                        return Card(
//                          child:

                              // SizedBox(height: 20,),

/*                              Text( "לעשות כסף מלהדפיס",
                                textDirection: TextDirection.rtl,
                                style: shadowTextBold(
                                    fontSize: 28,
                                    color: Colors.white ),
                              ),*/

                              Text( 'להפוך את המדפסת שלך',
                                textDirection: TextDirection.rtl,
                                style: shadowTextBold(
                                    fontSize: 24,
                                    color: Colors.white ),
                              ),
                              Text( 'למכונת כסף',
                                textDirection: TextDirection.rtl,
                                style: shadowTextBold(
                                    fontSize: 24,
                                    color: Colors.white ),
                              ),
                              SizedBox(height: 8,),

                              redFlatButton(
                                isShadow: true,
                                isBold: true,
                                buttonTitle: "הצטרף כיצרן",
                                horizontalPadding: 80,
                                verticalPadding: 8,
                                onPressed: () {

                                  showDialog(
                                      barrierDismissible: true, //כדי לצאת
                                      barrierColor: backgroundColor,
                                      context: context,
                                      builder: (context) =>
                                          FadeIn(
                                              duration: Duration(milliseconds: 300),
                                              child: filament3dPrinterDialog() ));
                                },
                              ),

//                        );
//                      },
//                    ),                  ---------------------------------------------------Laser
                            Spacer(),
                              GestureDetector(
                                onTap: () {
                                  // showDialog(
                                  //     barrierDismissible: true, //כדי לצאת
                                  //     barrierColor: backgroundColor,
                                  //     context: context,
                                  //     builder: (context) =>
                                  //         FadeIn(
                                  //             duration: Duration(milliseconds: 300),
                                  //             child: advertiser3dPrinterDialog(showOnlyShareButton: false) ));

                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                                  color: Colors.green.withOpacity(0.00), //למימוש הלחיצה גם בפאדינג
                                  child: Text( 'אין לך מדפסת 3D?',
                                    textAlign: TextAlign.center,
                                    textDirection: TextDirection.rtl,
                                    style: shadowText(
                                        fontSize: 14,
                                        color: Colors.white //.withOpacity(0.95)
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 5,)
                            ],
                          ),
                    ),
                  ),
                  Visibility(
                    visible: false,
                    child: Transform.translate(
                      offset: Offset(0, -40),
                      child: GestureDetector(
                        onTap: () {
                        },
                        child: Text( 'אין לך מדפסת 3D?',
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: shadowText(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.75) ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //endregion באנר ראשי

          //region טקסט 3 יתרונות
          Visibility(
            visible: true,
            child: Column(
              children: [
                SizedBox(height: 10,),
                Transform.translate(
                  offset: Offset(0, 10),
                  child: Text("אתה מדפיס",
                  textAlign: TextAlign.center,
                  style: simpleText(fontSize: 18, color: Colors.grey[600]) ),
                ),
                Text("כל השאר עלינו",
                textAlign: TextAlign.center,
                style: simpleText(fontSize: 32, color: Colors.grey[600]) ),

                SizedBox(height: 10,),
                Transform.translate(
                  offset: Offset(0, 10),
                  child: Text("מבחר המודלים",
                  textAlign: TextAlign.center,
                  style: simpleText(fontSize: 18, color: Colors.grey[600]) ),
                ),
                Text("הגדול בעולם",
                textAlign: TextAlign.center,
                style: simpleText(fontSize: 32, color: Colors.grey[600]) ),

                SizedBox(height: 10,),
                Transform.translate(
                  offset: Offset(0, 10),
                  child: Text("חיפוש כל מודל",
                  textAlign: TextAlign.center,
                  style: simpleText(fontSize: 18, color: Colors.grey[600]) ),
                ),
                Text("בעברית",
                textAlign: TextAlign.center,
                style: simpleText(fontSize: 32, color: Colors.grey[600]) ),

                SizedBox(height: 15,),
              ],
            ),
          ),
          //endregion טקסט 3 יתרונות

/*          new SizedBox(
            height: 1.5,
            child: new Center(
              child: new Container(
                margin: new EdgeInsetsDirectional.only(start: 15, end: 15),
                height: 5.0,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),*/

          //region גלריית הצעות
          Visibility(
            visible: true,
            child: Column(
              children: [
/*                Padding(
                  padding: const EdgeInsets.only(right: 0),
                  child: Center(
                    child: Text("ההמלצות שלנו",
                      textAlign: TextAlign.right,
                      style: simpleTextBold(fontSize: 26, color: Colors.black.withOpacity(0.50) ),
                    ),
                  ),
                ),*/
                CarouselSlider(
                  items: imageSliders,
                  options: CarouselOptions(
                      autoPlay: false,
                      reverse: true,
                      scrollDirection: Axis.horizontal,
                      enlargeCenterPage: true,
                      aspectRatio: 2.0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          galleyIndex = index;
                          print(galleyIndex);
                        });
                      }
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: imgList.map((url) {
                      int index = imgList.indexOf(url);
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: galleyIndex == index
                              ? Colors.black.withOpacity(0.50)
                              : Colors.black.withOpacity(0.30),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
          //endregion גלריית הצעות

          //region איך זה עובד?
          Visibility(
            visible: true,
            child: Column(
              children: [
                Text("איך זה עובד?",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: simpleTextBold(fontSize: 32, color: Colors.grey[dark]),
                ),
                SizedBox(height: 5,),

                svgTitleExplain(
                  svg: "assets/SVG/FlatIcon/SellerPaperAndPen100.svg",
                  title: "1. הצטרף כיצרן",
                  explain: "הצטרף חינם ושתף את שמך \n כהזמנה ללקוחות",
                ),
                svgTitleExplain(
                  svg: "assets/SVG/FlatIcon/3dCubePrint100.svg",
                  title: "2. הדפס מודלים",
                  explain: "הדפס מודלים ללקוחות שהזמינו",
                ),
                svgTitleExplain(
                  svg: "assets/SVG/FlatIcon/EarnBagSalary100.svg",
                  title: "3. קבל תשלום",
                  explain: "שלח בדואר את המודלים ללקוחות \n וקבל מאיתנו תשלום",
                ),
              ],
            )
          ),
          //endregion איך זה עובד?

          Container(
            padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.27),
            child: redFlatButton(
              isShadow: true,
              isBold: true,
              buttonTitle: "הצטרף כמוכר",
              horizontalPadding: 5,
              verticalPadding: 8,
              onPressed: () {

                showDialog(
                    barrierDismissible: true, //כדי לצאת
                    barrierColor: backgroundColor,
                    context: context,
                    builder: (context) =>
                        FadeIn(
                            duration: Duration(milliseconds: 300),
                            child: filament3dPrinterDialog() ));
              },

            ),
          ),

          SizedBox(height: 15,),

          //region שאלות ותשובות
          Text("שאלות ותשובות",
            textAlign: TextAlign.center,
            textDirection: TextDirection.rtl,
            style: simpleTextBold(fontSize: 32, color: Colors.grey[dark]),
          ),

          QuestionAnswer(
            question: "אין לי מדפסת 3D, עדיין אוכל להרוויח?",
            answerIsRichText: true,
            richText: RichText(
              // key: shimmerKey,
              textAlign: TextAlign.right,
              textDirection: TextDirection.rtl,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "כן, תוכל לשתף את האפליקציה ולקבל 10₪ על",
                    style: simpleText(fontSize: 18, color: Colors.grey[dark].withOpacity(0.65) ),
                  ),
                  TextSpan(
                    text: ' כל ההזמנות',
                    style: simpleTextBold(fontSize: 18, color: Colors.grey[dark].withOpacity(0.85) ),
                  ),
                  TextSpan(
                    // text: ' של לקוח שהוריד את האפליקציה דרכך. לא תצטרך להדפיס מודלים ותקבל 30% מכל עסקה',
                    text: ' של כלל הלקוחות שהגיעו דרכך!',
                    style: simpleText(fontSize: 18, color: Colors.grey[dark].withOpacity(0.65) ),
                  ),
                  TextSpan(
                    text: ' התחל לשתף',
                    style: simpleTextBold(fontSize: 18, color: Colors.blue[600]),
                    recognizer: TapGestureRecognizer()..
                    onTap = () {
                      // showDialog(
                      //     barrierDismissible: true, //כדי לצאת
                      //     barrierColor: backgroundColor,
                      //     context: context,
                      //     builder: (context) =>
                      //         FadeIn(
                      //             duration: Duration(milliseconds: 300),
                      //             child: advertiser3dPrinterDialog(showOnlyShareButton: false) ));
                    },
                  ),
                ],
              ),
            ),
          ),

          QuestionAnswer(
            question: "כמה ארוויח על כל מודל?",
            answerIsRichText: true,
            // answer: 'תקבל 30₪ עבור מודל קטן (עד 8 ס"מ), 40₪ עבור מודל בינוני (עד 14 ס"מ) \n ו 60₪ עבור מודל גדול (עד 19 ס"מ) ',
            richText: RichText(
              // key: shimmerKey,
                textAlign: TextAlign.right,
                textDirection: TextDirection.rtl,
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'תקבל 30₪ עבור מודל קטן (עד 8 ס"מ), 40₪ עבור מודל בינוני (עד 14 ס"מ) \n ו 60₪ עבור מודל גדול (עד 19 ס"מ).\n ',
                      style: simpleText(fontSize: 18, color: Colors.grey[dark].withOpacity(0.65) ),
                    ),
                    TextSpan(
                      text: 'בנוסף ',
                      style: simpleTextBold(fontSize: 18, color: Colors.grey[dark].withOpacity(0.85) ),
                    ),
                    TextSpan(
                      // text: ' של לקוח שהוריד את האפליקציה דרכך. לא תצטרך להדפיס מודלים ותקבל 30% מכל עסקה',
                      text: "תקבל 10₪ אם הלקוח הגיע דרך ההזמנה שלך ",
                      style: simpleText(fontSize: 18, color: Colors.grey[dark].withOpacity(0.65) ),
                    ),
                  ],
                ),
            ),
          ),

          QuestionAnswer(
            question: "איך לפרסם את שירותי?",
            answerIsRichText: false,
            answer: "תוכל לפרסם את שירותיך בדרכים מגוונות. מומלץ להשקיע בעמוד אינסטגרם או פייסבוק. נצל את זה שמדובר בתחום מיוחד!", ),

          QuestionAnswer(
            question: "יש הטבות למוכר מקצועי?",
            answerIsRichText: false,
            answer: "כן, תקבל הנחות לקניית פילמנטים, חלקים ומדפסות בSpider3D. ותקבל גם הזמנות של משווקים אחרים.", ),

          QuestionAnswer(
            question: "אוכל לוותר על ייצור הזמנה?",
            answerIsRichText: false,
            answer: "תמיד תוכל לוותר על ייצור המודל ולהרוויח 10₪ בעבור עסקה שהושלמה בזכותך. ", ),

          //endregion שאלות ותשובות
          SizedBox(height: 5,),
          GestureDetector( //בשימוש כדי שגם הטקסט יהיה לחיץ
            onTap: () {
              // היי הגעתי אליך דרך האפליקצייה המעולה שלכם, אני מעוניין להצטרף כמוכר/משווק אך יש לי עוד כמה שאלות. בכל מקרה, כדי לפרגן על ההשקעה עד שתענה לי אדרג אותכם ב5 כוכבים בגוגל פליי 😊 https://play.google.com/store/apps/details?id=com.biton.newspider3d
              launchURL("https://api.whatsapp.com/send?phone=972557207781&text=%D7%94%D7%99%D7%99%20%D7%94%D7%92%D7%A2%D7%AA%D7%99%20%D7%90%D7%9C%D7%99%D7%9A%20%D7%93%D7%A8%D7%9A%20%D7%94%D7%90%D7%A4%D7%9C%D7%99%D7%A7%D7%A6%D7%99%D7%99%D7%94%20%D7%94%D7%9E%D7%A2%D7%95%D7%9C%D7%94%20%D7%A9%D7%9C%D7%9B%D7%9D,%20%D7%90%D7%A0%D7%99%20%D7%9E%D7%A2%D7%95%D7%A0%D7%99%D7%99%D7%9F%20%D7%9C%D7%94%D7%A6%D7%98%D7%A8%D7%A3%20%D7%9B%D7%9E%D7%95%D7%9B%D7%A8/%D7%9E%D7%A9%D7%95%D7%95%D7%A7%20%D7%90%D7%9A%20%D7%99%D7%A9%20%D7%9C%D7%99%20%D7%A2%D7%95%D7%93%20%D7%9B%D7%9E%D7%94%20%D7%A9%D7%90%D7%9C%D7%95%D7%AA.%20%D7%91%D7%9B%D7%9C%20%D7%9E%D7%A7%D7%A8%D7%94,%20%D7%9B%D7%93%D7%99%20%D7%9C%D7%A4%D7%A8%D7%92%D7%9F%20%D7%A2%D7%9C%20%D7%94%D7%94%D7%A9%D7%A7%D7%A2%D7%94%20%D7%A2%D7%93%20%D7%A9%D7%AA%D7%A2%D7%A0%D7%94%20%D7%9C%D7%99%20%D7%90%D7%93%D7%A8%D7%92%20%D7%90%D7%95%D7%AA%D7%9B%D7%9D%20%D7%915%20%D7%9B%D7%95%D7%9B%D7%91%D7%99%D7%9D%20%D7%91%D7%92%D7%95%D7%92%D7%9C%20%D7%A4%D7%9C%D7%99%D7%99%20%F0%9F%98%8A%20https://play.google.com/store/apps/details?id=com.biton.newspider3d");
            },
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.27),
                  child: redOutlineButton(
                    buttonTitle: "שאלות נוספות?",
                    isBold: true,
                    onPressed: () {
                      // היי הגעתי אליך דרך האפליקצייה המעולה שלכם, אני מעוניין להצטרף כמוכר/משווק אך יש לי עוד כמה שאלות. בכל מקרה, כדי לפרגן על ההשקעה עד שתענה לי אדרג אותכם ב5 כוכבים בגוגל פליי 😊 https://play.google.com/store/apps/details?id=com.biton.newspider3d
                      launchURL("https://api.whatsapp.com/send?phone=972557207781&text=%D7%94%D7%99%D7%99%20%D7%94%D7%92%D7%A2%D7%AA%D7%99%20%D7%90%D7%9C%D7%99%D7%9A%20%D7%93%D7%A8%D7%9A%20%D7%94%D7%90%D7%A4%D7%9C%D7%99%D7%A7%D7%A6%D7%99%D7%99%D7%94%20%D7%94%D7%9E%D7%A2%D7%95%D7%9C%D7%94%20%D7%A9%D7%9C%D7%9B%D7%9D,%20%D7%90%D7%A0%D7%99%20%D7%9E%D7%A2%D7%95%D7%A0%D7%99%D7%99%D7%9F%20%D7%9C%D7%94%D7%A6%D7%98%D7%A8%D7%A3%20%D7%9B%D7%9E%D7%95%D7%9B%D7%A8/%D7%9E%D7%A9%D7%95%D7%95%D7%A7%20%D7%90%D7%9A%20%D7%99%D7%A9%20%D7%9C%D7%99%20%D7%A2%D7%95%D7%93%20%D7%9B%D7%9E%D7%94%20%D7%A9%D7%90%D7%9C%D7%95%D7%AA.%20%D7%91%D7%9B%D7%9C%20%D7%9E%D7%A7%D7%A8%D7%94,%20%D7%9B%D7%93%D7%99%20%D7%9C%D7%A4%D7%A8%D7%92%D7%9F%20%D7%A2%D7%9C%20%D7%94%D7%94%D7%A9%D7%A7%D7%A2%D7%94%20%D7%A2%D7%93%20%D7%A9%D7%AA%D7%A2%D7%A0%D7%94%20%D7%9C%D7%99%20%D7%90%D7%93%D7%A8%D7%92%20%D7%90%D7%95%D7%AA%D7%9B%D7%9D%20%D7%915%20%D7%9B%D7%95%D7%9B%D7%91%D7%99%D7%9D%20%D7%91%D7%92%D7%95%D7%92%D7%9C%20%D7%A4%D7%9C%D7%99%D7%99%20%F0%9F%98%8A%20https://play.google.com/store/apps/details?id=com.biton.newspider3d");
                    },
                  ),
                ),
                Text("לחץ למעבר לשיחה בווטסאפ",
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.rtl,
                  style: simpleText(fontSize: 14, color: Colors.grey[dark].withOpacity(0.45) ),
                ),
                SizedBox(height: 25,)
              ],
            ),
          ),
        ],
      ),
    );
  }
}

final List<String> imgList = [
  "assets/images/Recommendation/XboxGaming.jpg",
  "assets/images/Recommendation/garden.jpg",
  "assets/images/Recommendation/Tools.jpg",
  "assets/images/Recommendation/CustomName.jpg",
  "assets/images/Recommendation/ShinyToys.jpg",
  "assets/images/Recommendation/braceletFashionTsaMid.jpg",
];

final List<String> galleryTitles = [
  "אביזרי גיימינג",
  "פריטי נוי לבית ולגינה",
  "כלי עבודה",
  "שלטים בהתאמה אישית",
  "צעצועים",
  "צמידים ושרשראות",
];

final List<Widget> imageSliders = imgList.map((item) => Container(
  child: Container(
    margin: EdgeInsets.all(3.0),
    child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: Stack(
          children: <Widget>[
            // Image.network(item, fit: BoxFit.cover, width: 1000.0),
            Image.asset(item, fit: BoxFit.cover, width: 1000.0),
            // טקסט וגרדיאנט שחור
            Positioned(
              // bottom: 0.0,
              top: 0.0,
              right: 0.0,
              left: 0.0,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(200, 0, 0, 0),
                      Color.fromARGB(0, 0, 0, 0)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Text(
                    "${galleryTitles[ imgList.indexOf(item) ]}", //'No. ${imgList.indexOf(item)} image',
                    textAlign: TextAlign.right,
                    style: shadowTextBold(fontSize: 20, color: Colors.white)  //simpleTextBold(fontSize: (20), color: Colors.white)
                ),
              ),
            ),
          ],
        )
    ),
  ),
)).toList();
