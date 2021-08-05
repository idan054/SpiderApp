import 'package:chat_app_with_firebase/Services/ApiService.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/widgets/FeedWidget.dart';
import 'package:custom_navigator/custom_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:translator/translator.dart';
import 'package:hexcolor/hexcolor.dart';

/// עמוד ראשי ///
class HomePage extends StatefulWidget {

  final List<X3ModelString> homePageValues;
  HomePage({this.homePageValues});

  @override 
  _HomePageState createState() => _HomePageState();
}
GoogleTranslator translator = new GoogleTranslator();   //using google translator

class _HomePageState extends State<HomePage> {
  String searchValue = ""; //ברירת המחדל לפני פעולת חיפוש אקטיבית
  FaIcon dependIcon = FaIcon(FontAwesomeIcons.search,color: HexColor("#c81c19")); //הגדרת ברירת המחדל
  Widget dependSearchBar = Image( image: AssetImage("assets/images/SpiderLogo.png"),height: 25,);
  Widget spiderAppBar =    Image( image: AssetImage("assets/images/SpiderLogo.png"),height: 25,);

  @override
  void initState() {
    super.initState();
    Provider.of<FeedStatus>(context,listen: false).feedStatusPopular();
  }


  Widget _buildMainFeed(BuildContext context,FeedStatus dynamic) {

    switch(dynamic.loadingStatus) {
      case LoadingStatus.searching: 
        return Center(child: Padding(
          padding: const EdgeInsets.only(top: 270),
          child: CircularProgressIndicator(strokeWidth: 2),
        ));

      case LoadingStatus.empty: 
        return Align(child: Text("No results found!"));

      case LoadingStatus.completed: 
        return Expanded(child:

           FeedWidget(
          modelApiValues: dynamic.listOfFeedStatus,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final finalFeedStatus = Provider.of<FeedStatus>(context);

    return
      Scaffold(
        body:  Column(
          children: [
            _buildMainFeed(context,finalFeedStatus),
          ],
        ),
    );
  }
}