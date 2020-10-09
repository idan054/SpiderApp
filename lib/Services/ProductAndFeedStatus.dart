/// ProductAndFeedStatus ///
import 'package:flutter/material.dart';
import 'ApiService.dart';
import 'ProductAPIService.dart';

enum LoadingStatus {
  completed,
  searching,
  empty
}

/// 4 יוצר תקשורת עם הBuild שבשימוש בעמוד המוצר ונחוץ לStatfull ///
///  * הBuild נחוץ כדי לקרוא ל Stateless שמשתמש בAPI ///

class ProductPageStatus extends ChangeNotifier {

  var loadingStatus = LoadingStatus.searching;

  List<X4ProductModel> listOfStatus = List<X4ProductModel>();

  Future<void> dynamicByID(String keyword) async { // יוצר את אפשרות החיפוש
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    List<ProductPageBy> webViewPage = await WebProductService().setFeedByProductID(/*keyword*/);
    this.listOfStatus = webViewPage.map((product) => X4ProductModel(ProductArticle: product)).toList();
    this.loadingStatus = this.listOfStatus.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }

  Future<void> staticBabyYoda() async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    print("Datails coming1!");
    print("כמות הערכים:");     print(listOfStatus.length);
    print("כל הערכים:");       print(listOfStatus);
    List<ProductPageBy> theProductID = await WebProductService().setFeedByProductID(); //Baby Yoda
    print("Datails coming2!");
    print("כמות הערכים:");     print(listOfStatus.length);
    print("כל הערכים:");       print(listOfStatus);
    this.listOfStatus = theProductID.map(
            (product) => X4ProductModel(ProductArticle: product)).toList();
    print("Datails coming3!");
    print("כמות הערכים:");     print(listOfStatus.length);
    print("כל הערכים:");       print(listOfStatus);
    this.loadingStatus = this.listOfStatus.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
    print("Datails coming4!");
    print("כמות הערכים:");     print(listOfStatus.length);
    print("כל הערכים:");       print(listOfStatus);
  }

}


class FeedStatus extends ChangeNotifier {

  var loadingStatus = LoadingStatus.searching;

  List<X3ModelString> listOfFeedStatus = List<X3ModelString>();

  Future<void> feedStatusPopular() async {
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    List<X2SetFeedBy> webViewPage = await Webservice().setFeedByPopular();
    this.listOfFeedStatus = webViewPage.map(
            (article) => X3ModelString(Xarticle: article)).toList();
    this.loadingStatus = this.listOfFeedStatus.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }

  Future<void> feedStatusSearch(String keyword) async { /// יוצר את אפשרות החיפוש ///
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    List<X2SetFeedBy> theKeyword = await Webservice().setFeedByKeyword(keyword);
    this.listOfFeedStatus = theKeyword.map((article) => X3ModelString(Xarticle: article)).toList();
    this.loadingStatus = this.listOfFeedStatus.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }

  Future<void> feedStatusCategory(String category) async { /// יוצר את אפשרות החיפוש ///
    this.loadingStatus = LoadingStatus.searching;
    notifyListeners();
    List<X2SetFeedBy> theKeyword = await Webservice().setFeedByCategory(category);
    this.listOfFeedStatus = theKeyword.map((article) => X3ModelString(Xarticle: article)).toList();
    this.loadingStatus = this.listOfFeedStatus.isEmpty ? LoadingStatus.empty : LoadingStatus.completed;
    notifyListeners();
  }

}



