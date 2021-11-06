import 'package:chat_app_with_firebase/widgets/AppBarWidgetV2.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/pages/HomePage.dart';
import 'package:chat_app_with_firebase/pages/ThingWebView.dart';
import 'package:chat_app_with_firebase/pages/SpiderWebViewV2.dart';
import 'package:custom_navigator/custom_scaffold.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:chat_app_with_firebase/constants.dart';

import 'NewHomePage.dart';

/// סרגל תחתון V2 - מוצג בכל העמודים ללא אפשרות החלקה ///
class CustomNavigator extends StatefulWidget {

  @override
  _CustomNavigatorState createState() => _CustomNavigatorState();
}
class _CustomNavigatorState extends State<CustomNavigator> {
  // PageController _pageController = new PageController(
  //     initialPage: 0
  // );

  @override
  Widget build(BuildContext context) {
    return
        Stack(
          children: [
            CustomScaffold(
              onItemTap: (indexValue) {
                setState(() {
                  print("default myPageIndex is $myPageIndex");
                  print("indexValue is $indexValue");
                  myPageIndex = indexValue;
                  print("myPageIndex is $myPageIndex");
                  // indexValue = myPageIndex;
                  // print("indexValue is $indexValue");
                  // indexValue = 0;
                });
              },
              children: [
                // NewHomePage(),

                // FutureBuilder(
                //   initialData: FeedStatus(),
                //     builder:(context, snapshot) => NewHomePage(),),

                ChangeNotifierProvider(
                // ListenableProvider(
                // Provider(
                  // create: (_) => FeedStatus(), /// שיב לב! חשוב לוודא שגם הclass של ProductAndFeedStatus
                  create: (context) => FeedStatus(),
                  builder: (context, child) => NewHomePage(),
                  // child: NewHomePage(),
                ),


                    SpiderWebViewV2(
                      spiderLink: currentURL,
                      isbackVisible0: false,
                      showSavePageSuggestion: false,
                      canExit: false,),
              ],
              scaffold: Scaffold(
                bottomNavigationBar: BottomNavigationBar(
                  backgroundColor: Colors.white,
                  currentIndex: myPageIndex,
                  selectedFontSize: 12,
                  // selectedLabelStyle: TextStyle( color: spiderRed, fontSize: 12),
                  unselectedItemColor: Colors.grey,
                  //selectedItemColor: spiderRed,
                  // fixedColor: Colors.blue,
                  items: [

                    BottomNavigationBarItem(
                        icon:
                        SvgPicture.asset("assets/SVG/144thingiVerseLogo.svg", color: Colors.grey, height: 22 ),
                         // ImageIcon(
                         //  AssetImage("assets/images/ThingiVerseLogo.png"), color: Colors.grey, size: 22,),
                        activeIcon:
                        SvgPicture.asset("assets/SVG/144thingiVerseLogo.svg", color: spiderRed, height: 25,width: 25),
                        // ImageIcon(
                        //     AssetImage("assets/images/ThingiVerseLogo.png"), color: spiderRed, size: 22,),
                        title: Text("ThingiVerse", style: TextStyle( color: Colors.grey, fontSize: 12),)
                    ),

                    BottomNavigationBarItem(
                        icon:
                        // ImageIcon(
                        // AssetImage("assets/images/SpiderSpider.png"), color: Colors.grey, size: 24,),
                        SvgPicture.asset("assets/SVG/SpiderLogo.svg", color: Colors.grey, height: 23,width: 23),
                        // Icon( FontAwesomeIcons.spider, color: Colors.grey, size: 25,),
                        activeIcon:
                        // ImageIcon(
                          // AssetImage("assets/images/SpiderSpider.png"), color: spiderRed, size: 24,),
                        SvgPicture.asset("assets/SVG/SpiderLogo.svg", color: spiderRed, height: 26,width: 26),
                        // Icon( FontAwesomeIcons.spider, color: spiderRed, size: 25, ),
                        title: Text("Spider3D", style: TextStyle( color: Colors.grey, fontSize: 12),)
                    ),

                  ],
                  // onTap: (indexValue) {
                  //   setState(() {
                  //     // print("default myPageIndex is $myPageIndex"); //ברירת מחדל = 0
                  //     // print("indexValue is $indexValue");
                  //     myPageIndex = 2;
                  //     print("myPageIndex is $myPageIndex");
                  //     // indexValue = myPageIndex;
                  //     // print("indexValue is $indexValue");
                  //     // indexValue = 0;
                  //   });
                  // },

//        onTap: (index){
//          setState(() {
//            _currentIndex = index;
//          });
//        },
                ),
              ),
            ),
/*            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                color: Colors.green.withOpacity(0.50),
                height: 56 , width: 180,
                child:
                const Text(
                    'RAISED BUTTON', semanticsLabel: 'RAISED BUTTON 1')
                ,
              ),
            ),*/
          ]
        );
  }
}


/*class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Page _page = Page('Page 0');
  int _currentIndex = 0;

  // Custom navigator takes a global key if you want to access the
  // navigator from outside it's widget tree subtree
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        onTap: (index) {
          // here we used the navigator key to pop the stack to get back to our
          // main page
          navigatorKey.currentState.maybePop();
          setState(() => _page = Page('Page $index'));
          _currentIndex = index;
        },
        currentIndex: _currentIndex,
      ),
      body: CustomNavigator(
        navigatorKey: navigatorKey,
        home: _page,
        //Specify your page route [PageRoutes.materialPageRoute] or [PageRoutes.cupertinoPageRoute]
        pageRoute: PageRoutes.materialPageRoute,
      ),
    );
  }

  final _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('home')),
    BottomNavigationBarItem(icon: Icon(Icons.event), title: Text('events')),
    BottomNavigationBarItem(
        icon: Icon(Icons.save_alt), title: Text('downloads')),
  ];
}

class Page extends StatelessWidget {
  final String title;

  const Page(this.title) : assert(title != null);

  @override
  Widget build(BuildContext context) {
    return  Text(title);
  }


//  _openDetailsPage(BuildContext context) => mainNavigatorKey.currentState.push(MaterialPageRoute(builder: (context) => DetailsPage(title)));

}*/

