//Flutter
import 'package:chat_app_with_firebase/pages/Intro.dart';
import 'package:flutter/material.dart';
//MyPages & Widgets
import 'package:chat_app_with_firebase/Services/ApiService.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/pages/PaymentWebView.dart';
import 'package:custom_radio_grouped_button/CustomButtons/ButtonTextStyle.dart';
import 'DecorationWidgets.dart';
import 'FeedWidget.dart';
import 'MyWidgets.dart';
//Packages
import 'package:animate_do/animate_do.dart';
import 'package:custom_radio_grouped_button/CustomButtons/CustomRadioButton.dart';
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
import 'package:hexcolor/hexcolor.dart';

final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();
final ValueChanged _onChanged = (val) => print(val);

void settingModalBottomSheet(context){
  /*totalPrice = shippingPrice + sizePrice;*/
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  showModalBottomSheet(
    enableDrag: true,
    backgroundColor: Colors.black.withOpacity(0.00),
    context: context,
    builder: (BuildContext bc, ){
      return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) =>
            SlideInUp(
              duration: Duration(milliseconds: 300),
              child: Container(
                // height: 800,
                width: 500,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(22), topRight: Radius.circular(22)),
                    boxShadow: [
                      new BoxShadow(
                        color: Colors.black12,
                        blurRadius: 7.0,
                        offset: Offset(0.0, -10.0,),
                      ),
                    ]
                ),
                child:
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 0),
                  child:
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        // region שורת הכותרת
                        Row(
                          //mainAxisAlignment: MainAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            IconButton(
                              iconSize: 30,
                              splashColor: Colors.grey,
                              icon: ImageIcon(
                                AssetImage(
                                    "assets/images/ImageIcon/ruler.png"),
                                color: Colors.grey,),
                              onPressed: () {
                                showDialog(
                                    barrierDismissible: true, //כדי לצאת
                                    barrierColor: Colors.black26,
                                    context: context,
                                    builder: (context) =>
                                        FadeIn(
                                            duration: Duration(milliseconds: 200),
                                            child: sizeProductExplainDialog( bottomPadding: 0 )
                                        ));
                              },
                            ),
                            Align(
                                alignment: Alignment.centerRight,
                                child: Text(
                                    "בחר גודל וצבע למודל",
                                    style: simpleTextBold(
                                        fontSize: 22, color: Colors.black
                                    )
                                )),
                            //SizedBox(width: 32,),
                            IconButton(
                                iconSize: 30,
                                splashColor: Colors.grey,
                                icon: Icon(Icons.clear, color: Colors.grey),
                                onPressed: () {
                                  Navigator.pop(context);
                                  setState(() {
                                    showPrice = false;
                                    showMyBottomSheet = false;
                                  });
                                }
                            ),
                            //SizedBox(width: 15,),
                          ],
                        ),
                        //endregion שורת הכותרת

                        // region טופס - בחירת מידה
                        Transform.translate(
                          offset: Offset(MediaQuery.of(context).size.width*0.24, 3),
                          child:
                          Container(
//                              width: MediaQuery.of(context).size.width*0.4,
                            alignment: Alignment.center,
                            // margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width*0.22),
                            // padding: const EdgeInsets.only(top: 10,),
                            child: CustomRadioButton(
                              // myAlignment: Alignment.center,
                              // autoWidth: false,
                              //                enableButtonWrap: false,
                              //                horizontal: false,
                              //absoluteZeroSpacing: true,
                              //wrapAlignment: WrapAlignment.start,
                              defaultSelected: 'M',
                              width: 56,
                              height: 62,
                              padding: 0,
                              spacing: 0,
                              elevation: 5,
                              //shadowColor: Colors.black26,
                              enableShape: true,
                              customShape:
                              OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(99),
                                  borderSide: new BorderSide(
                                      color: Colors.white.withOpacity(0.00), width: 0)),
                              selectedColor: Colors.black12,
                              //Hexcolor("#edf0f2"),
                              unSelectedColor: Colors.white70,
                              buttonTextStyle: ButtonTextStyle(
                                  selectedColor: Colors.black,
                                  unSelectedColor: Colors.black,
                                  textStyle: simpleTextBold(
                                      fontSize: 22, color: Colors.black
                                  )
                              ),
                              buttonLables: [ 'S', 'M', 'L'],
                              buttonValues: [ 'S', 'M', 'L'],
                              radioButtonValue: (label) {
                                print(label);
                                labelSize = (label);
                                initState() {
                                  setState(() { //איניט סטייט אינו חובה
                                    labelSize = (label);
                                    //showPrice = true;

                                    // ignore: unrelated_type_equality_checks
                                    if (labelSize == "S") /*Then...*/ {
                                      setState(() {
                                        sizePrice = 49;
                                        print (sizePrice);
                                        totalPrice = shippingPrice + sizePrice;
                                        print ("new $totalPrice");
                                      });
                                    }

                                    // ignore: unrelated_type_equality_checks
                                    if (labelSize == "M") /*Then...*/ {
                                      setState(() {
                                        sizePrice = 69;
                                        print (sizePrice);
                                        totalPrice = shippingPrice + sizePrice;
                                        print ("new $totalPrice");
                                      });
                                    }

                                    // ignore: unrelated_type_equality_checks
                                    if (labelSize == "L") /*Then...*/ {
                                      setState(() {
                                        sizePrice = 89;
                                        print (sizePrice);
                                        totalPrice = shippingPrice + sizePrice;
                                        print ("new $totalPrice");
                                      });
                                    }
                                  });
                                }
                                initState();
                                //Builder(builder: (context) => Container(height: 100, width: 100, color: Colors.green,) );
                              },
                            ),
                          ),
                        ),
                        // endregion טופס - בחירת מידה

                        // region טופס - בחירת צבע
                        FormBuilder(
                          key: _fbKey,
//                              initialValue: { 'בחר_צבע': "שחור",}, //ברירת מחדל
                          readOnly: false,
                          child: Container(
//                                color: Colors.red,
                            padding: const EdgeInsets.symmetric(horizontal: 30),
                            child: FormBuilderChoiceChip(
                              alignment: WrapAlignment.center,
                              attribute: 'בחר_צבע',
                              spacing: 7,
                              runSpacing: 10,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),),
                              backgroundColor: Colors.white.withOpacity(0.00),
                              selectedColor: Colors.black.withOpacity(0.15), //Colors.black12,
                              elevation: 5,
                              // shadowColor: Colors.black.withOpacity(0.85),
                              selectedShadowColor: Colors.black,
                              //pressElevation: 10,
                              labelPadding: EdgeInsets.symmetric(
                                  horizontal: 0),

                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(color: Colors.white.withOpacity(0.00) ,width: 0)),

                              ),
                              initialValue: selectedColor, // = ("NotSelected")
                              onChanged: (value) { //ברירת מחדל value = NotSelected
                                setState(() {
                                  print (value);
                                  selectedColor = value;
                                });
                              },
                              options: [
                                FormBuilderFieldOption(
                                  value: "שחור", child: selectColor(
                                    colorTitle: "שחור",
                                    imageAsset: "assets/images/FilamentsColors/80BlackFilament.png"
                                ),),
                                FormBuilderFieldOption(
                                  value: "לבן", child: selectColor(
                                    colorTitle: "לבן",
                                    imageAsset: "assets/images/FilamentsColors/80WhiteFilament.png"
                                ),),
                                FormBuilderFieldOption(
                                  value: "כחול", child: selectColor(
                                    colorTitle: "כחול",
                                    imageAsset: "assets/images/FilamentsColors/80BlueFilament.png"
                                ),),
                                FormBuilderFieldOption(
                                  value: "אדום", child: selectColor(
                                    colorTitle: "אדום",
                                    imageAsset: "assets/images/FilamentsColors/80RedFilament.png"
                                ),),
                                FormBuilderFieldOption(
                                  value: "ירוק", child: selectColor(
                                    colorTitle: "ירוק",
                                    imageAsset: "assets/images/FilamentsColors/80GreenFilament.png"
                                ),),
                                FormBuilderFieldOption(
                                  value: 'כתום', child: selectColor(
                                    colorTitle: "כתום",
                                    imageAsset: "assets/images/FilamentsColors/80OrangeFilament.png"
                                ),),
                                FormBuilderFieldOption(
                                  value: 'צהוב', child: selectColor(
                                    colorTitle: "צהוב",
                                    imageAsset: "assets/images/FilamentsColors/80YellowFilament.png"
                                ),),
                                FormBuilderFieldOption(
                                  value: "סגול", child: selectColor(
                                    colorTitle: "סגול",
                                    imageAsset: "assets/images/FilamentsColors/80PurpleFilament.png"
                                ),),
                              ],
                              onSaved: (newValue) {
                                selectedColor = newValue.toString();
                              },
                            ),
                          ),
                        ),
                        //endregion טופס - בחירת צבע

                        showOrderResult ?
                        Transform.translate(
                          offset: Offset(0, -11),
                          child: Text(orderResult,
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: simpleTextBold(fontSize: 15, color: Colors.grey,),
                          ),
                        )
                            : Transform.translate(
                          offset: Offset(0, -11),
                          child: Text("הצבעים להמחשה בלבד",
                            textAlign: TextAlign.right,
                            style: simpleText(fontSize: 14, color: Colors.grey,),
                          ),
                        ),

                        // region כפתור תשלום רווחית ומחיר
                        Container(
                          color: Colors.white,
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child:
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AnimatedDefaultTextStyle( // יש להוסיף Bool לסטייל כדי להפעיל את האנימציה
                                duration: Duration(milliseconds: 1000),
                                curve: Curves.elasticOut,
                                style: simpleTextBold(
                                    fontSize: 22, color: Colors.black
                                ),
                                child: Text("₪$totalPrice""0"),
                              ),

                              // region כפתור תשלום
                              redOutlineButton(
                                buttonTitle: "תשלום",
                                isBold: true,
                                onPressed: () {
                                  if (_fbKey.currentState.saveAndValidate() //הפרטים בטופס תקינים (וידוא שני)
                                      && fullNameTextEditingController.text != "" //הטופס לא ריק
                                      && selectedColor != "NotSelected" //לא נבחר צבע
                                      && selectedColor != "" //לא נבחר צבע
                                  /*&& price != "69₪"*/) { //שים לב! בזכות ברירות המחדל אין צורך לבחור
                                    print(_fbKey.currentState.value);
                                    print(sizePrice);
                                    print(orderedURL);
                                    print("Date Coming!!");
                                    print("${DateTime.now()}");

                                    GoogleSheetsOrdersForm googleSheetsOrdersForm =
                                    GoogleSheetsOrdersForm(
                                        fullName: fullNameTextEditingController.text,
                                        phone: phoneTextEditingController.text,
                                        mail: mailTextEditingController.text,
                                        city: cityTextEditingController.text,
                                        street: streetTextEditingController.text,

                                        link: orderedURL,
                                        size: labelSize,
                                        color: selectedColor,
                                        referred: referredTextEditingController.text,
                                        introReferred: introReferredValue,
                                        dateSubmit: DateTime.now()
                                    );

                                    FormController formController = FormController((String response){
                                      print("Response: $response");
                                    });
                                    formController.submitForm(googleSheetsOrdersForm);
                                    // print("googleSheetsConnection.city is ${googleSheetsConnection.city.toString()}");

                                    setState(() {

                                      showOrderResult = true;
                                      orderResult = " ההזמנה התקבלה! ";
                                      //כפתור תשלום רווחית

                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) =>  PaymentWebView(
                                            link: "https://icredit.rivhit.co.il/payment/PaymentFullPage.aspx?GroupId=9c55da9f-2860-43a4-ae32-9cb4a6f15255",
                                            // name: "$orderedNameModel בצבע $selectedColor",)
                                            name: "$orderedNameModel",
                                            color: "בצבע $selectedColor",
                                          )
                                      ));

                                    });
                                  } else {
                                    print('validation failed');
                                    setState(() {
                                      showOrderResult = true;
                                      orderResult = "אנא בחר צבע ומידה והכנס פרטי משלוח";
                                    });
                                  }
                                },)
                              // endregion כפתור תשלום
                            ],
                          ),
                        ),
                        //endregion  כפתור תשלום רווחית ומחיר

                        // region כפתור תשלום פייפאל ומחיר - לא פעיל
                        /*Container(
                               color: Colors.white,
                               padding: const EdgeInsets.symmetric(horizontal: 80),
                               child:
                               Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   AnimatedDefaultTextStyle( // יש להוסיף Bool לסטייל כדי להפעיל את האנימציה
                                     duration: Duration(milliseconds: 1000),
                                     curve: Curves.elasticOut,
                                     style: simpleTextBold(
                                         fontSize: 22, color: Colors.black
                                     ),
                                     child: Text("₪$totalPrice""0"),
                                   ),

                                   // region כפתור תשלום
                                  redOutlineButton(
                                    buttonTitle: "תשלום",
                                    isBold: true,
                                    onPressed: () {
                                    if (_fbKey.currentState.saveAndValidate() //הפרטים בטופס תקינים (וידוא שני)
                                        && fullNameTextEditingController.text != "" //הטופס לא ריק
                                        && selectedColor != "NotSelected" //לא נבחר צבע
                                    *//*&& price != "69₪"*//*) { //שים לב! בזכות ברירות המחדל אין צורך לבחור
                                      print(_fbKey.currentState.value);
                                      print(sizePrice);
                                      print(orderedURL);
                                      setState(() {
                                        showOrderResult = true;
                                        orderResult = " ההזמנה התקבלה! ";

                                        // ignore: unrelated_type_equality_checks
                                        if (totalPrice == 49) *//*Then...*//* { //קטן
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>  PayPalWebView(
                                                link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=2WCM7E8KUDLX2",
                                                name: orderedNameModel,)
                                          ));
                                        }
                                        // ignore: unrelated_type_equality_checks
                                        if (totalPrice == 69) *//*Then...*//* { //בינוני
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>  PayPalWebView(
                                                link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=AHWATUWKDBUC6",
                                                name: orderedNameModel,)
                                          ));
                                        }
                                        // ignore: unrelated_type_equality_checks
                                        if (totalPrice == 89) *//*Then...*//* { //גדול
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>  PayPalWebView(
                                                link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FTAKXFM7QY5AA",
                                                name: orderedNameModel,)
                                          ));
                                        }
                                        // ignore: unrelated_type_equality_checks
                                        if (totalPrice == 68) *//*Then...*//* { // קטן במשלוח מהיר
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>  PayPalWebView(
                                                link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=FHTFN7243X8RC",
                                                name: orderedNameModel,)
                                          ));
                                        }
                                        // ignore: unrelated_type_equality_checks
                                        if (totalPrice == 88) *//*Then...*//* { // בינוני במשלוח מהיר
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>  PayPalWebView(
                                                link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=UBJ7T3E4DPMNS",
                                                name: orderedNameModel,)
                                          ));
                                        }
                                        // ignore: unrelated_type_equality_checks
                                        if (totalPrice == 108) *//*Then...*//* { //גדול במשלוח מהיר
                                          Navigator.push(context, MaterialPageRoute(
                                              builder: (context) =>  PayPalWebView(
                                                link: "https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=H7MQXBEBDBD7Y",
                                                name: orderedNameModel,)
                                          ));
                                        }

                                      });
                                    } else {
                                      print('validation failed');
                                      setState(() {
                                        showOrderResult = true;
                                        orderResult = "אנא בחר צבע ומידה והכנס פרטי משלוח";
                                      });
                                    }
                                  },)
                                   // endregion כפתור תשלום
                                 ],
                               ),
                             ),*/

                        // טופס - טקסט סטטוס הזמנה

                        // region שורת משלוח מהיר
                        Visibility(
                          visible: false,
                          child: Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Switch(
                                  activeTrackColor: Colors.red[500].withOpacity(0.57),
                                  activeColor: Colors.red[500].withOpacity(0.75),
                                  value: isSwitched,
                                  onChanged: (value) {
                                    setState(() {
                                      isSwitched = value;
                                      print(isSwitched);
                                      if (isSwitched == true) {
                                        shippingPrice = 19;
                                        print(shippingPrice);
                                        totalPrice = shippingPrice + sizePrice;
                                        print ("new $totalPrice");
                                      }
                                      if (isSwitched == false) {
                                        shippingPrice = 0;
                                        print(shippingPrice);
                                        totalPrice = shippingPrice + sizePrice;
                                        print ("new $totalPrice");
                                      }
                                    });
                                  },
                                ),

                                Text('19.90₪',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "Assistant",
                                      fontSize: 14
                                  ),),

                                Spacer(),

                                AnimatedDefaultTextStyle( // יש להוסיף Bool לסטייל כדי להפעיל את האנימציה
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.elasticOut,
                                  style: simpleTextBold(
                                      fontSize: 22, color: Colors.black
                                  ),
                                  child: Text("?משלוח מהיר"),
                                ),
                              ],
                            ),
                          ),
                        ),
                        // endregion שורת משלוח מהיר

                        //                        region כרטיסיית משלוח
                        StatefulBuilder(
                          builder: (context, setState) =>
                              Container(
                                color: Colors.white,
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Card(
                                  elevation: 7,
                                  shadowColor: Colors.black26,
                                  child: ListTile(
                                    leading:
                                    squareOutlineButton(
                                      title: "עריכה",
                                      containerSize: 30,
                                      fontSize: 13.5,
                                      onPressed: () {
                                        showDialog(
                                            barrierColor: Colors.black26,
//                                        barrierDismissible: false, //כדי למנועי יציאה
                                            context: context,
                                            builder: (context) =>
                                                FadeIn(
                                                  duration: Duration(milliseconds: 300),
                                                  child:  Dialog(
                                                    insetPadding: EdgeInsets.symmetric(horizontal: 30,),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(
                                                          15),),
                                                    elevation: 5,
                                                    child:
                                                    IntrinsicWidth(
                                                      child: IntrinsicHeight(
                                                        child:
                                                        Padding(
                                                          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 0),
                                                          child: Container(/*height: 300, width: 400,*/
                                                              child:
                                                              FormBuilder(
                                                                key: _formKey,
                                                                child: SingleChildScrollView(
                                                                  child: Column(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      SizedBox(height: 18,),
                                                                      Row(
                                                                        children: [

                                                                          /// טלפון
                                                                          Flexible(
                                                                            child: Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: FormBuilderTextField(
                                                                                controller: phoneTextEditingController,
                                                                                attribute: 'phone_number',
//                                  initialValue: '',
                                                                                maxLength: 10,
                                                                                cursorColor: Colors.grey[800], //spiderRed,
                                                                                // textAlign: TextAlign.end,
                                                                                textDirection: TextDirection.ltr,
                                                                                decoration: greyDeliveryDecorationSvgPrefix(
                                                                                  hintText: "טלפון",
                                                                                  // icons: Icons.phone
                                                                                  svgIcon: "assets/SVG/Material/phone-24px.svg",
                                                                                ),
                                                                                onChanged: _onChanged,
                                                                                validators: [
                                                                                  FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                                                                                  FormBuilderValidators.numeric(errorText: "אנא הכנס מס' טלפון תקין"), // מספרים בלבד
                                                                                  FormBuilderValidators.maxLength(10, errorText: "הכנס בדיוק 10 ספרות"),
                                                                                  FormBuilderValidators.minLength(10, errorText: "הכנס בדיוק 10 ספרות"),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          SizedBox(width: 10,),

                                                                          /// שם מלא
                                                                          Flexible(
                                                                            child: Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: FormBuilderTextField(
                                                                                controller: fullNameTextEditingController,
                                                                                attribute: 'Full_Name',
//                                  initialValue: '',
                                                                                cursorColor: Colors.grey[800], //spiderRed,
                                                                                textAlign: TextAlign.end,
                                                                                //textDirection: TextDirection.ltr,
                                                                                decoration: greyDeliveryDecorationSvgPrefix(
                                                                                  hintText: "שם מלא",
                                                                                  // icons: Icons.perm_identity
                                                                                  svgIcon: "assets/SVG/Material/perm_identity_profile-24px.svg",
                                                                                ),
                                                                                onChanged: _onChanged,
                                                                                validators: [
                                                                                  FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                      /// אימייל
                                                                      Directionality(
                                                                        textDirection: TextDirection.rtl,
                                                                        child: FormBuilderTextField(
                                                                          controller: mailTextEditingController,
                                                                          attribute: 'Email',
//                            initialValue: /*isLoggedIn ? _googleSignIn.currentUser.email :*/ "",
                                                                          cursorColor: Colors.grey[800], //spiderRed,
                                                                          textAlign: TextAlign.end,
                                                                          //textDirection: TextDirection.ltr,
                                                                          decoration: greyDeliveryDecorationSvgPrefix(
                                                                            hintText: "מייל",
                                                                            // icons: Icons.alternate_email
                                                                            svgIcon: "assets/SVG/Material/alternate_email-24px.svg",
                                                                          ),
                                                                          onChanged: _onChanged,
                                                                          validators: [
                                                                            FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                                                                            FormBuilderValidators.email(errorText: "אנא הכנס מייל תקין"),
                                                                          ],
                                                                        ),
                                                                      ),

                                                                      Row(
                                                                        children: [

                                                                          /// רחוב ומס'
                                                                          Flexible(
                                                                            flex: 3,
                                                                            child: Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: FormBuilderTextField(
                                                                                controller: streetTextEditingController,
                                                                                attribute: 'Street_And_Number',
//                                  initialValue: '',
                                                                                cursorColor: Colors.grey[800], //spiderRed,
                                                                                textAlign: TextAlign.end,
                                                                                textDirection: TextDirection.ltr,
                                                                                decoration: greyDeliveryDecorationSvgPrefix(
                                                                                  hintText: "'רחוב ומס",
                                                                                  // icons: Icons.home
                                                                                  svgIcon: "assets/SVG/Material/home-24px-round.svg",
                                                                                ),
                                                                                onChanged: _onChanged,
                                                                                validators: [
                                                                                  FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),

                                                                          SizedBox(width: 10,),

                                                                          /// עיר
                                                                          Flexible(
                                                                            flex: 2,
                                                                            child: Directionality(
                                                                              textDirection: TextDirection.rtl,
                                                                              child: FormBuilderTextField(
                                                                                controller: cityTextEditingController,
                                                                                attribute: 'City',
                                                                                //                                  initialValue: '',
                                                                                cursorColor: Colors.grey[800], //spiderRed,
                                                                                textAlign: TextAlign.end,
                                                                                //textDirection: TextDirection.ltr,
                                                                                decoration: greyDeliveryDecorationSvgPrefix(
                                                                                  hintText: "עיר",
                                                                                  // icons: Icons.location_on
                                                                                  svgIcon: "assets/SVG/Material/location_on-24px.svg",
                                                                                ),
                                                                                onChanged: _onChanged,
                                                                                validators: [
                                                                                  FormBuilderValidators.required(errorText: "שדה זה הוא חובה"), //שדה זה הוא חובה
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),

                                                                      StatefulBuilder(
                                                                          builder: (context, setState) =>
                                                                              Column(
                                                                                children: [
                                                                                  for (var i = 0; i < 1; i += 1)
                                                                                    Transform.translate(
                                                                                      offset: Offset(0, -10),
                                                                                      child: Row(
                                                                                        children: [
                                                                                          Text(
                                                                                            "הוזמנת לאפליקציה?",
                                                                                            textDirection: TextDirection.rtl,
                                                                                            style: simpleText(fontSize: 16, color: Colors.black26), ),
                                                                                          Checkbox(
                                                                                            value: checked[i],
                                                                                            key: checkBox,
                                                                                            checkColor: Colors.grey[500],
                                                                                            // activeColor: Hexcolor("#f6f8fa"),//Hexcolor("#fafafa"),
                                                                                            activeColor: Colors.black.withOpacity(0.05),
                                                                                            onChanged: i == 4
                                                                                                ? null
                                                                                                : (bool value) {
                                                                                              setState(() {
                                                                                                checked[i] = value;
                                                                                                isShowReferredField = value;
                                                                                              });
                                                                                            },
                                                                                            tristate: i == 1,
                                                                                          ),
                                                                                        ],
                                                                                        mainAxisAlignment: MainAxisAlignment.end,
                                                                                      ),
                                                                                    ),

                                                                                  Transform.translate(
                                                                                    offset: Offset(0, -10),
                                                                                    child:
                                                                                    AnimatedCrossFade(
                                                                                      duration: const Duration(milliseconds: 400),
                                                                                      crossFadeState: isShowReferredField ? CrossFadeState
                                                                                          .showFirst : CrossFadeState.showSecond,
                                                                                      firstChild:
                                                                                      /// משווק
                                                                                      Directionality(
                                                                                        textDirection: TextDirection.rtl,
                                                                                        child: FormBuilderTextField(
                                                                                          controller: referredTextEditingController,
                                                                                          attribute: 'referred',
//                            initialValue: /*isLoggedIn ? _googleSignIn.currentUser.email :*/ "",
                                                                                          cursorColor: Colors.grey[800], //spiderRed,
                                                                                          textAlign: TextAlign.start,
                                                                                          textDirection: TextDirection.rtl,
                                                                                          decoration: greyDeliveryDecorationSvgPrefix(
                                                                                            hintText: "שם או כינוי המזמין",
                                                                                            // icons: Icons.alternate_email
                                                                                            svgIcon: "assets/SVG/Material/drafts-24px.svg",
                                                                                          ),
                                                                                          onChanged: _onChanged,
                                                                                        ),
                                                                                      ),
                                                                                      secondChild: Container(),
                                                                                    ),
                                                                                  ),

                                                                                  Transform.translate(
                                                                                    offset: Offset(0, -10),
                                                                                    child: Text(
                                                                                        showFormStatus ?  "המידע נשמר בהצלחה!"
                                                                                            : "מידע זה ישמר גם להזמנות עתידיות",
                                                                                        textDirection: TextDirection.rtl,
                                                                                        style: simpleTextBold(fontSize: 16, color: Colors.black26)
                                                                                      //basicTextStyle(colors: Colors.grey[700]),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              )
                                                                      ),

                                                                      Transform.translate(
                                                                        offset: Offset(0, -10),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                                                          children: [

                                                                            // כפתור ניקוי נתונים כללי
                                                                            Visibility(/*Button V Down V Here*/
                                                                              visible: true,
                                                                              child: Padding(
                                                                                padding: const EdgeInsets.only(top: 10),
                                                                                child: Container( // קונטיינר כפתור
                                                                                  height: 35, width: 75,
                                                                                  child:
                                                                                  squareOutlineButton(
                                                                                    title: "נקה",
                                                                                    color: spiderRed.withOpacity(0.7), //Colors.black26,
                                                                                    onPressed: () {
                                                                                      removeValues(); //מוחק מהקאש' במכשיר
                                                                                      fullNameTextEditingController.clear();
                                                                                      phoneTextEditingController.clear();
                                                                                      mailTextEditingController.clear();
                                                                                      cityTextEditingController.clear();
                                                                                      streetTextEditingController.clear();
                                                                                      setState(() {
                                                                                        showFormStatus = false;
//                                                                                    haveDeliveryData = false;
                                                                                      });
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),



                                                                            /// כפתור שמור פרטי משלוח
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(top: 10),
                                                                              child:
                                                                              Container( // קונטיינר כפתור
                                                                                height: 35, width: 75,
                                                                                // padding: EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                                                                                child: OutlineButton(
                                                                                  shape: RoundedRectangleBorder(
                                                                                    borderRadius: BorderRadius.circular(8),),
                                                                                  borderSide: BorderSide(color: Colors.black26, width: 1.2,),
                                                                                  highlightedBorderColor: Colors.black26,
                                                                                  child: Text('שמור',
                                                                                      style: simpleTextBold(fontSize: 16, color: Colors.black26),
                                                                                      semanticsLabel: 'שמור'),
                                                                                  onPressed: () {
                                                                                    if (_formKey.currentState.saveAndValidate()) {
                                                                                      print(_formKey.currentState.value);
                                                                                      Navigator.pop(context);
                                                                                      setState(() {
                                                                                        showFormStatus = true;
//                                                                                  haveDeliveryData = true;
                                                                                      });

                                                                                    } else {
                                                                                      setState(() {
                                                                                        //formStatus = "תקן את השדות";
                                                                                        showFormStatus = false;
                                                                                      });
                                                                                      print('האימות נכשל! אך אלו התוצאות:');
                                                                                      print(_formKey.currentState.value);
                                                                                    }
                                                                                  },
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      //כפתורי שליחה  ואיפוס
                                                                      SizedBox(height: 18,),
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),)
                                        );
                                      },
                                    ),
                                    title: Text('משלוח חינם אל:',
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w600,
                                          fontFamily: "Assistant",
                                          fontSize: 14
                                      ),),
                                    subtitle: Text( cityTextEditingController.text != "" ? //לא ריק, במידה ויש מידע על העיר
                                    "${cityTextEditingController.text}, ${streetTextEditingController.text}"
                                        : "הכנס פרטי משלוח",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis, //3 נק' אם יותר משורה
                                      textDirection: TextDirection.rtl,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "Assistant",
                                          fontSize: 18
                                      ),),
                                    trailing: cityTextEditingController.text != "" ? //לא ריק, במידה ויש מידע על העיר
                                    Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green[500].withOpacity(0.75),
                                      size: 44,
                                    )
                                        : Icon(
                                      Icons.highlight_off,
                                      color: Colors.red[500].withOpacity(0.75),
                                      size: 44,
                                    ),
                                  ),
                                ),
                              ),
                        ),
//                        endregion כרטיסיית משלוח
                        SizedBox(height: 5,),


                      ],
                    ),
                  ),
                ),
              ),
            ),
      );
    },
  );

}