import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_app_with_firebase/constants.dart';

///Input Decorations
InputDecoration greyDeliveryDecorationSvgPrefix ({hintText, /*icons,*/ svgIcon, helperText}){
  return
    InputDecoration(
      counter: Offstage(/*Counter Here*/), //וויג'ט שמסתיר ויזואלית את קיומו של הילד שלו
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), //.only(left: 10, right: 10, top: 10, bottom: 10),
      // helperText: helperText,
      // helperMaxLines: 2,
      alignLabelWithHint: true,
      labelText:  hintText,
      labelStyle: TextStyle (
        color: Colors.grey[500], //HexColor("#808c8e")
        fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),

/*      hintText: hintText,
      hintStyle:
      TextStyle (
          color: Colors.grey[500], //HexColor("#808c8e")
          fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),*/

      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 13),
        child:  SvgPicture.asset(svgIcon, color: spiderRed, height: 24,),
      // Icon(icons, color: spiderRed,)
      ),

      errorStyle: TextStyle(
        //fontSize:14, color: Colors.red,
        fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),

      border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

      focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

      enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

    );
}

InputDecoration greyDeliveryDecorationImagePrefix ({String hintText, String prefixImage}){
  return
    InputDecoration(
      counter: Offstage(/*Counter Here*/), //וויג'ט שמסתיר ויזואלית את קיומו של הילד שלו
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), //.only(left: 10, right: 10, top: 10, bottom: 10),
      // helperText: helperText,
      // helperMaxLines: 2,
      hintText: hintText,
      hintStyle:
      TextStyle (
        color: Colors.grey[500], //HexColor("#808c8e")
        fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),

      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
        child:
        Image.asset(prefixImage, height: 15,), //שליטה על הגודל דרך Padding Vertical
        // Icon(Icons.account_circle , color: spiderRed, size: 10,)
      ),

      errorStyle: TextStyle(
        //fontSize:14, color: Colors.red,
        fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),

      border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

      focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

      enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

    );
}

InputDecoration greyDeliveryDecorationNoPrefix ({hintText, /*icons, svgIcon,*/ helperText, labelText}){
  return
    InputDecoration(
      counter: Offstage(/*Counter Here*/), //וויג'ט שמסתיר ויזואלית את קיומו של הילד שלו
      filled: true,
      fillColor: Colors.black.withOpacity(0.05),
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10), //.only(left: 10, right: 10, top: 10, bottom: 10),
      // helperText: helperText,
      // helperMaxLines: 2,
      hintText: hintText,
      labelText: labelText,
      labelStyle:
      TextStyle (
        color: Colors.grey[500], //HexColor("#808c8e")
        fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),
      hintStyle:
      TextStyle (
          color: Colors.grey[500], //HexColor("#808c8e")
          fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),

      // prefixIcon: Padding(
      //   padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 13),
      //   child:  SvgPicture.asset(svgIcon, color: spiderRed, height: 24,),
      // // Icon(icons, color: spiderRed,)
      // ),

      errorStyle: TextStyle(
        //fontSize:14, color: Colors.red,
        fontFamily: "Assistant", fontWeight: FontWeight.w600,
      ),

      border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

      focusedBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

      enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

    );
}

InputDecoration greySearchDecorationThingiLogo (String hintText){
  return
    InputDecoration(

      filled: true,
      // fillColor: HexColor("#f6f8fa"),
      fillColor: Colors.lightGreenAccent,
      contentPadding: EdgeInsets.only(left: 0, right: 20, top: 10, bottom: 10), //EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 10.0),
      hintText: hintText,
      hintStyle:
      TextStyle (
          // color: HexColor("#808c8e")
          color: Colors.lightGreenAccent
      ),

      border: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),

      focusedBorder: OutlineInputBorder(
        borderRadius: new BorderRadius.circular(8.0),
        borderSide: new BorderSide(color: Colors.white ,width: 0)),

      enabledBorder: OutlineInputBorder(
          borderRadius: new BorderRadius.circular(8.0),
          borderSide: new BorderSide(color: Colors.white ,width: 0)),
      prefixIcon: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 5),
        child: Image.asset(
          'assets/images/ThingiVerseLogo.png',
          width: 5, height: 5, color: spiderRed,
          //fit: BoxFit.fill,
        ),
      ),


    );
}

///Text Styles
///מידות נפוצות קטן 16, בינוני 18, גדול 22
TextStyle shadowTextBold ({@required double fontSize,@required  Color color}) {
  return TextStyle(
    fontSize: fontSize, color: color,
    fontFamily: "Assistant", fontWeight: FontWeight.w700,
    shadows: [
      Shadow(
        blurRadius: 5.0,
        color: Colors.black54,
        offset: Offset(-1.5, 1.5),
      ),
    ],
  );
}

TextStyle shadowText ({@required double fontSize,@required  Color color}) {
  return TextStyle(
    fontSize: fontSize, color: color,
    fontFamily: "Assistant", fontWeight: FontWeight.w600,
    shadows: [
      Shadow(
        blurRadius: 5.0,
        color: Colors.black54,
        offset: Offset(-1.5, 1.5),
      ),
    ],
  );
}


TextStyle simpleTextBold ({@required double fontSize,@required  Color color}) {
  return
   /* GoogleFonts.heebo(
    fontSize: fontSize, color: color,
    fontWeight: FontWeight.w700,
  );*/
  TextStyle(
    fontSize: fontSize, color: color,
    fontFamily: "Assistant", fontWeight: FontWeight.w700,
  );
}

TextStyle simpleText ({@required double fontSize,@required  Color color}) {
  return
    /*GoogleFonts.heebo(
    fontSize: fontSize, color: color,
    fontWeight: FontWeight.w600,
  );*/
    TextStyle(
    fontSize: fontSize, color: color,
    fontFamily: "Assistant", fontWeight: FontWeight.w600,
  );
}


