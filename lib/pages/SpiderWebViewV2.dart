import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:chat_app_with_firebase/widgets/DecorationWidgets.dart';
import 'package:chat_app_with_firebase/widgets/MyWidgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../constants.dart';


class SpiderWebViewV2 extends StatefulWidget {
  String spiderLink;
  final bool isbackVisible0;
  final bool canExit;
  bool showSavePageSuggestion = false;

  SpiderWebViewV2({Key key, this.spiderLink, this.isbackVisible0, this.canExit,
    this.showSavePageSuggestion}) : super(key: key);
  // SpiderWebViewV2({@required this.spiderLink, this.isbackVisible0});

  @override
  _SpiderWebViewV2State createState() => _SpiderWebViewV2State();
}
String currentURL = "https://www.spider3d.co.il/"; //ברירת מחדל = ספיידר ראשי,currentURL מתעדכן בכל מעבר עמוד!


class _SpiderWebViewV2State extends State<SpiderWebViewV2> {
  final Completer<WebViewController> _controller = Completer<WebViewController>();
  ScaffoldState scaffold;
  String appBarTitle = "בטעינה...";
  bool isWebLoading = true;


  ///הגדרת כפתור חזור פנימי לדפדפן בלחיצה על "חזרה"
  Future<bool> _disableBackButton() {
    return null;
  //Navigator.of(context).pop(true)
  }

  Future<bool> _allowBackButton() {
    // return null;
  Navigator.of(context).pop(true);
  }

/*  @override
  void dispose() {
    super.dispose();
    setState(() {
      widget.spiderLink == "https://www.spider3d.co.il/מדפסות-תלת-מימד" ? currentURL = "https://www.spider3d.co.il/" : null;
      widget.spiderLink == "https://www.spider3d.co.il/צבעים-מותאמים-למוכרים" ? currentURL = "https://www.spider3d.co.il/" : null;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: widget.isbackVisible0 ? _allowBackButton : _disableBackButton,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading:  widget.isbackVisible0 ?
                      BackButton(color: spiderRed,)
                    : MyBackButton(/*_webViewControllerFuture: */_controller.future, /*isbackVisible:*/ widget.isbackVisible0,),
          title:  Row(
            children: [
              Transform.translate(
                offset: Offset(-25, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child:
                  IconButton(
                    icon: Icon (Icons.share,color: spiderRed,),
                    onPressed: (){
                      print("${"Share Button Works!"}");
                      Share.share("אני מזמין אותך לרכוש בחנות המעולה של ספיידר https://www.spider3d.co.il/");
/*                 Clipboard.setData(ClipboardData(text: widget.link));
                    final snackBar = SnackBar(
                    content: Text('הטקסט הועתק ללוח'),);
                     Scaffold.of(context).showSnackBar(snackBar);*/
//const url = 'https://play.google.com/store/apps/details?id=org.biton.cell-tec&hl=iw';
                      //launchURL('https://play.google.com/store/apps/details?id=com.waze&hl=iw');
//                 {Navigator.push (null, MaterialPageRoute( //במקור null הןא context
//                builder: (context) => screenView //יש להוסיף () כדי שיעבוד, לדוגמא ()main
//            )
//            );
//            },
                    },
                  ),
                ),
              ),
              Spacer(),
              Align(
                alignment: Alignment.centerRight,
                child: Text(appBarTitle,
                    //textAlign: TextAlign.right,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.rtl,
                    style: simpleTextBold(fontSize: 22, color: Colors.black)
                ),
              ),
            ],
          ),
          /*flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Container(color: Colors.grey, height: 30,)),*/

          // This drop down menu demonstrates that Flutter widgets can be shown over the web view.
        ),
        // We're using a Builder here so we have a context that is below the Scaffold
        // to allow calling Scaffold.of(context) so we can show a snackbar.
        body: Stack(
          children: [
            Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl:  widget.spiderLink,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                // TODO(iskakaushik): Remove this when collection literals makes it to stable.
                // ignore: prefer_collection_literals
                navigationDelegate: (NavigationRequest request) {
                  if (request.url.startsWith('https://www.youtube.com/')) {
                    print('blocking navigation to $request}');
                    return NavigationDecision.prevent;
                  }
                  print('allowing navigation to $request');
                  return NavigationDecision.navigate;
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                  setState(() {
                    isWebLoading = true;
                    appBarTitle = "בטעינה...";
                    currentURL = url;
                  });
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    isWebLoading = false;
                    appBarTitle = "החנות של ספיידר 3D";
                    currentURL = url;
                    // appBarTitle = currentTitle;
                  });
                },
                gestureNavigationEnabled: true,
              );
            }),
            isWebLoading ?
            Center( child: CircularProgressIndicator(
              strokeWidth: 2, backgroundColor: Colors.white60,), )
          : Container(),
            Visibility(
              visible: widget.showSavePageSuggestion,
              child: Container(
                color: Colors.grey[100],
                height: 30,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Builder(
                      builder: (context) =>
                      GestureDetector(
                        onTap: () {
                         print("Tapped!");
                         Clipboard.setData(ClipboardData(text: widget.spiderLink ));
                         Scaffold.of(context).showSnackBar(
                            SnackBar(
                              duration: Duration(seconds: 4), //ברירת מחדל = 4
                              backgroundColor: Colors.grey[100],
                              content:
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: false,
                                      child: squareOutlineButton(
                                        containerSize: 30,
                                        fontSize: 13.5,
                                        title: "חזור",
                                        color: Colors.blue,
                                        onPressed: () {
                                          Navigator.pop(context, 'העלמות התראה');
                                        },
                                      ),
                                    ),
                                    Spacer(),
                                    Text("הקישור הועתק ללוח",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: simpleText(fontSize: 16, color: Colors.grey[dark])
                                    ),
                                    SizedBox(width: 7,),
                                    Icon(Icons.content_copy, color: Colors.grey[dark], size: 23,)
                                  ],
                                ),
                              ),
                            ),
                          );

                        },
                        child: Text("שמור",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: simpleTextBold(fontSize: 13.5, color: Colors.blue)
                        ),
                      ),
                    ),
                    SizedBox(width: 32,),
                    Text("מומלץ לשמור דף זה לרכישות עתידיות של פילמנטים",
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.rtl,
                        style: simpleText(fontSize: 13.5, color: Colors.grey[dark])
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(Icons.launch, color: spiderRed,),
          onPressed: () {
            launchURL(currentURL);
          },
        ),
      ),
    );
  }
}

/// הגדרת כפתור חזור פנימי לדפדפן
class MyBackButton extends StatefulWidget {
  final bool isbackVisible;
  const MyBackButton(this._webViewControllerFuture, this.isbackVisible)
      : assert(_webViewControllerFuture != null);

  final Future<WebViewController> _webViewControllerFuture;

  @override
  _MyBackButtonState createState() => _MyBackButtonState();
}

class _MyBackButtonState extends State<MyBackButton> {

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: widget._webViewControllerFuture,
      builder:
          (BuildContext context, AsyncSnapshot<WebViewController> snapshot) {
        final bool webViewReady =
            snapshot.connectionState == ConnectionState.done;
        final WebViewController controller = snapshot.data;
        return IconButton(
          icon: const Icon(Icons.arrow_back),
          color: spiderRed,
          onPressed: !webViewReady
              ? null
              : () async {
            if (await controller.canGoBack()
            // && currentURL != "https://www.spider3d.co.il/" //ניתן לחזור (לא מציג סנאקבר "אתה בעמוד הראשי" כל עוד לא עמוד ראשי
            ) {
              await controller.goBack();
            } else {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  duration: Duration(seconds: 4), //ברירת מחדל = 4
                  backgroundColor: Colors.grey[100],
                  content:
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      children: [
                        Visibility(
                          visible: widget.isbackVisible,
                          child: squareOutlineButton(
                            containerSize: 30,
                            fontSize: 13.5,
                            title: "חזור",
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pop(context, 'העלמות התראה');
                            },
                          ),
                        ),
                        Spacer(),
                        Text("אתה כבר בעמוד הראשי!",
                            textAlign: TextAlign.right,
                            textDirection: TextDirection.rtl,
                            style: simpleText(fontSize: 16, color: Colors.grey[dark])
                        ),
                      ],
                    ),
                  ),
                ),
              );
              return;
            }
          },
        );
      },
    );
  }
}
