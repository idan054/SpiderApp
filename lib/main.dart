import 'package:animate_do/animate_do.dart';
import 'package:chat_app_with_firebase/constants.dart';
import 'package:chat_app_with_firebase/pages/HomePage.dart';
import 'package:chat_app_with_firebase/widgets/DecorationWidgets.dart';
import 'package:chat_app_with_firebase/widgets/MyWidgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'Services/ProductAndFeedStatus.dart';


void main() => runApp( App() );

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  @override
  Widget build(BuildContext context) {
    // final finalFeedStatus = Provider.of<FeedStatus>(context);

    // initState();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Spider3d",
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.light,
        primaryColor: Colors.green[800],
        accentColor: Colors.red[200],
      ),
      home:
      ChangeNotifierProvider(
        // ListenableProvider(
        // Provider(
        //   value: FeedStatus().feedStatusPopular(),
        create: (context) => FeedStatus(),
        // create: (context) => FeedStatus().feedStatusPopular(),
        builder: (context, child) => HomePage(),
        // child: NewHomePage(),
      ),
    );
  }
}

