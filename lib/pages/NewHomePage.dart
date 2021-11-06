import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:chat_app_with_firebase/widgets/FeedWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewHomePage extends StatefulWidget {
  @override
  _NewHomePageState createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
      // create: Provider.of<FeedStatus>(context, listen: false).feedStatusPopular(),
      future: FeedStatus().feedStatusPopular(),
      builder:(context, snapshot) {
      print(snapshot.data);
      return Consumer<FeedStatus>(
        builder: (context, value, child) {
        // print('NewHomePage Value:');
        // print(value);
        if (value.loadingStatus == LoadingStatus.completed){
        return  Expanded(
            child: FeedWidget(
          modelApiValues: value.listOfFeedStatus,
        ));
        }
        if (value.loadingStatus == LoadingStatus.searching){
          return  Center(
              child: Text('Searching..'));
        }
        return Text('Default');
      },);}
    );
  }
}
