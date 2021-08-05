import 'package:animate_do/animate_do.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/constants.dart';
import 'package:chat_app_with_firebase/pages/FavoritePage.dart';
import 'package:chat_app_with_firebase/pages/JoinAsSellerV2.dart';
import 'package:chat_app_with_firebase/widgets/MyWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/pages/FavoritePage.dart';
import 'package:chat_app_with_firebase/pages/JoinAsSellerV2.dart';
import 'package:chat_app_with_firebase/widgets/DecorationWidgets.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:chat_app_with_firebase/constants.dart';
import 'DecorationWidgets.dart';

class AppBarWidgetV2 extends StatefulWidget {
  @override
  _AppBarWidgetV2State createState() => _AppBarWidgetV2State();
}

class _AppBarWidgetV2State extends State<AppBarWidgetV2> {
  bool mainAppBar = true;
  final _searchController = TextEditingController();
  String searchValue = ""; //ברירת המחדל לפני פעולת חיפוש אקטיבית

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);
  bool isLoggedIn = false;
  _login() async {
    try{

      await _googleSignIn.signIn(); //ל
      setState(() {
        isLoggedIn = true;
      });

    }catch(err){
      print(err);
    }
  }
  _logout(){
    _googleSignIn.signOut();
    setState(() {
      isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    //מגשר עבור החיפוש
    final finalFeedStatus = Provider.of<FeedStatus>(context);

    Widget spiderAppBar =
    AppBar(
      backgroundColor: Colors.white.withOpacity(00),
      elevation: 0,
      leading:  Transform.translate(
        offset: Offset(-15, -2),
        child: IconButton(
          icon: FaIcon(FontAwesomeIcons.search), color: spiderRed, iconSize: 20,
          onPressed: () {
            setState(() {
              mainAppBar = false;
            });
          },
        ),
      ),
      titleSpacing: 1,
      title:  Align(
        alignment: Alignment.centerLeft,
        child: Image(
          image: AssetImage("assets/images/SpiderLogo.png"), height: 25,),
      ),
      actions: [
        /// כפתור הצטרף כיצרן
        IconButton(
            iconSize: 26,
            icon: Icon(Icons.monetization_on, color: spiderRed),
            onPressed: () {

              Navigator.push(context, MaterialPageRoute(
                builder: (context) => JoinAsSellerV2(),
              ));

/*              showDialog(
                  //barrierDismissible: true, //כדי לצאת
                  barrierColor: backgroundColor,
                  context: context,
                  builder: (context) =>
                      FadeIn(
                       duration: Duration(milliseconds: 300),
                       child: seller3PointsDialog())
              );*/

            }
        ),

        /// כפתור שיתוף
        IconButton(
            iconSize: 24,
            icon: FaIcon(FontAwesomeIcons.grinStars, color: spiderRed),
            onPressed: () {

              // showDialog(
              //     barrierDismissible: true, //כדי לצאת
              //     barrierColor: backgroundColor,
              //     context: context,
              //     builder: (context) =>
              //         FadeIn(
              //             duration: Duration(milliseconds: 300),
              //             child: advertiser3dPrinterDialog(
              //                 showOnlyShareButton: true ) ));

/*              showDialog(
                  //barrierDismissible: true, //כדי לצאת
                  barrierColor: backgroundColor,
                  context: context,
                  builder: (context) =>
                      FadeIn(
                       duration: Duration(milliseconds: 300),
                       child: seller3PointsDialog())
              );*/

            }
        ),
        /// כפתור שמור למועדפים (לא פעיל ולא תקין)
        Visibility(
          visible: false,
          child: IconButton(
              iconSize: 26,
              icon: Icon(Icons.bookmark_border, color: spiderRed),
              onPressed: () {

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => FavoritePage(),
                ));

/*              showDialog(
                    //barrierDismissible: true, //כדי לצאת
                    barrierColor: backgroundColor,
                    context: context,
                    builder: (context) =>
                        FadeIn(
                         duration: Duration(milliseconds: 300),
                         child: seller3PointsDialog())
                );*/

              }
          ),
        ),
        /// כפתור התחברות דרך גוגל (לא פעיל ותקין)
          Visibility(
            visible: false,
            child: isLoggedIn ?
            GestureDetector(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 11.0), //11 xyz
              child: Container(
                width: 35,
                decoration: BoxDecoration(
                    color: HexColor("#f6f8fa"),
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                        //onError: ImageErrorListener(),
                        image:  NetworkImage(_googleSignIn.currentUser.photoUrl),
                        fit: BoxFit.fill
                    )
                ),
              ),
            ),

            onTap:   () {
              showDialog(
                //barrierDismissible: true, //כדי לצאת
                context: context,
                builder: (context) =>
                    Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            15),),
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 20, //20
                          vertical: 10, //10
                        ),
                        child: IntrinsicWidth(
                          child: IntrinsicHeight(
                            child: Column(
                              children: <Widget>[
                                SizedBox(height: 10),
                                Text(
                                  "?מעוניין להתנתק",
                                  style:
                                  TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "Assistant",
                                    fontSize: 20,
                                  ),
                                ),
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .center,
                                  children: <Widget>[
                                    Spacer(),
                                    FlatButton(
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(99),),

                                      child: Text(
                                        "ביטול", style: TextStyle(
                                          color: Colors.white
                                      ),),
                                      onPressed: () {
                                        Navigator.pop(context, 'העלמות התראה');
                                      },
                                    ),
                                    Spacer(),
                                    FlatButton(
                                      color: Colors.blue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius
                                            .circular(99),),

                                      child: Text(
                                        "התנתק",
                                        style: TextStyle(
                                            color: Colors.white
                                        ),),
                                      onPressed: () {
                                        _logout();
                                        Navigator.pop(context, 'העלמות התראה');
                                      },
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              );
            },

        )
            : IconButton(
            iconSize: 26,
            icon: Icon(Icons.perm_identity, color: Colors.red[900]),
            onPressed: () { _login(); },
        ),
          ),
        //endregion כפתור התחברות לגוגל
      ],
    );

    Widget searchAppBar =
    AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading:  Transform.translate(
        offset: Offset(-15, 0),
        child: IconButton(
          icon: FaIcon(FontAwesomeIcons.times), color: Colors.grey[400], iconSize: 20,
          onPressed: () {
            setState(() {
              mainAppBar = true;
            });
          },
        ),
      ),
      titleSpacing: 0,
      title: Padding(
        padding: const EdgeInsets.only(top: 2),
        child: TextField( //Expand יש לנסות לעטוף ב!
          style: simpleText(fontSize: 18, color: Colors.grey[500]),
          cursorColor: HexColor("#c81c19"),
          textAlign: TextAlign.end,
          textDirection: TextDirection.ltr,
          autofocus: true,
          controller: _searchController,
          onSubmitted: (value) {
            // fetch all the news related to the keyword
            if(value.isNotEmpty) /*Then...*/ {/*finalFeedStatus.feedStatusSearch(value);*/
              translator.translate(value, from: 'iw', to: 'en').then((tValue) {
                setState(() {
                  value = tValue.text;
                });
                print(value);
                finalFeedStatus.feedStatusSearch(value);
              });
            }
            setState(() {
              searchValue = _searchController.text;
            });
            print("Looking For $searchValue");
            //Statest(relocateSearchValue: searchValue);
          },
          decoration: greySearchDecorationThingiLogo("...חפש מודלים בעברית"),
        ),
      ),
    );

    return mainAppBar ? spiderAppBar : searchAppBar;
  }
}
