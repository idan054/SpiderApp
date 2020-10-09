//Flutter
import 'package:flutter/material.dart';
import 'dart:async';
//MyPages & Widgets
import 'package:chat_app_with_firebase/pages/CustomNavigator.dart';
import 'package:chat_app_with_firebase/constants.dart';
//Packages
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ThingWebView extends StatefulWidget {
  final String link;
  final String name;
  ThingWebView({this.link, this.name}); //קונסטקטור ל postURLl

  @override
  _ThingWebViewState createState() => _ThingWebViewState();
}

class _ThingWebViewState extends State<ThingWebView> {
  bool isWebLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      onThingWebViewPage = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller = Completer<
        WebViewController>();

    return
      Scaffold(
        body: Stack(
          children: [
            Builder(builder: (BuildContext context) {
              return WebView(
                initialUrl: widget.link,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) {
                  _controller.complete(webViewController);
                },
                onPageStarted: (String url) {
                  print('Page started loading: $url');
                  Center (child: Text("Loading..."));
                  JustContainer;
                },
                onPageFinished: (String url) {
                  print('Page finished loading: $url');
                  setState(() {
                    isWebLoading = false;
                  });
                },
                gestureNavigationEnabled: true,
              );
            }),
            Align(
                alignment: Alignment.topCenter,
                child: Container(height: 85, child:
                AppBar(
                    backgroundColor: Colors.white,
                    leading: BackButton(
                        onPressed: () {
                          Navigator.maybePop(context);
                          setState(() {
                            onThingWebViewPage = false;
                          });
                        },
                        color: spiderRed),
                    title: Align(
                      alignment: Alignment.centerRight,
                      child: Text(isWebLoading? "בטעינה...": widget.name,
                        //textAlign: TextAlign.right,
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize:22, color: Colors.black,
                          fontFamily: "Assistant", fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                        /*
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Image(
                        image: AssetImage("assets/images/SpiderLogo.png"),
                        height: 25,),
                    )
                    */
                ),
                )
            ), //AppBar סרגל עליון
            isWebLoading ? Center(
              child: CircularProgressIndicator(
                strokeWidth: 2, backgroundColor: Colors.grey,),
            ) : Container(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          splashColor: Colors.red,
          onPressed: () {
            Share.share(widget.link);
//            Clipboard.setData(ClipboardData(text: widget.link));
//            final snackBar = SnackBar(
//              content: Text('הטקסט הועתק ללוח'),);
//            Scaffold.of(context).showSnackBar(snackBar);
          },
          child: Icon(Icons.share, color: spiderRed,),
        ),
      );
  }

  void JustContainer() {
    OverlayEntry(
        builder: (context) => Container(height: 500, color: Colors.purple)
    );
  }
}
