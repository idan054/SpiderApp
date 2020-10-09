import 'dart:async';
import 'package:chat_app_with_firebase/widgets/DecorationWidgets.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:chat_app_with_firebase/constants.dart';

class PaymentWebView extends StatefulWidget {
  final String link;
  final String name;
  final String color;
  PaymentWebView({this.link, this.name, this.color}); //קונסטקטור ל postURLl

  @override
  _PaymentWebViewState createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  bool isWebLoading = true;

  @override
  Widget build(BuildContext context) {
    final Completer<WebViewController> _controller = Completer<
        WebViewController>();

    return
      Scaffold(
        body:
        Stack(
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
              child: Container(height: 65, child:
                AppBar(
                  backgroundColor: Colors.white,
                  leading: BackButton(
                      color: spiderRed),
                      actions: <Widget>[
                        Container(
                          // color: Colors.green,
                          width: 100,
                          alignment: Alignment.centerRight,
                          child: Text(isWebLoading ? "": widget.color,
                            //textAlign: TextAlign.right,
                            textAlign: TextAlign.start,
                            textDirection: TextDirection.rtl,
                            style: simpleTextBold(fontSize: 17, color: Colors.black),
                          ),
                        ),
                        SizedBox(width: 5,),
                        Container(
                          // color: Colors.redAccent,
                          padding: EdgeInsets.only(right: 20),
                          width: 180,
                          alignment: isWebLoading ? Alignment.centerRight : Alignment.centerLeft,
                          child: Text(isWebLoading ? "בטעינה...": widget.name,
                            //textAlign: TextAlign.right,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                            textDirection: TextDirection.rtl,
                            style: simpleTextBold(fontSize: 17, color: Colors.black),
                          ),
                        ),
                          ],
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
      );
  }

  void JustContainer() {
    OverlayEntry(
        builder: (context) => Container(height: 500, color: Colors.purple)
    );
  }
}
