import 'package:chat_app_with_firebase/Services/ProductAPIService.dart';
import 'package:chat_app_with_firebase/Services/ProductAndFeedStatus.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductPage extends StatefulWidget {

  final List<X4ProductModel> ProductPageValues;
  ProductPage({this.ProductPageValues});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  @override
  void initState() {
    super.initState();
    Provider.of<ProductPageStatus>(context,listen: false).staticBabyYoda();
  }

  @override
  Widget build(BuildContext context) {
    final apiValues = Provider.of<ProductPageStatus>(context);
    //List<CategoryModel> categoryListOfData = new List<CategoryModel>();

    return Scaffold(
      body: Center( child:
      RaisedButton.icon(
        icon: const Icon(Icons.add, size: 18.0),
        label: const Text('RAISED BUTTON', semanticsLabel: 'RAISED BUTTON 2'),
        onPressed: () {
          // Perform some action
          print(apiValues.staticBabyYoda());
        },
      ),

      ),
    );
  }
}
