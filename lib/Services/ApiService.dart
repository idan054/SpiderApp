import 'dart:convert';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:http/http.dart' as http;

/// 1 חיבור לAPI ///

var defaultList = ['featured','popular' ,'verified','newest'];
var randomHome = randomChoice(defaultList);
var thingiToken = '76a96e8a8905232b8f9d1645eeada242';

class Constants { //https://api.thingiverse.com/popular/?access_token=$thingiToken
  // static String defaultFeed =  "https://api.thingiverse.com/search/news?access_token=$thingiToken";
  static String defaultFeed =  "https://api.thingiverse.com/$randomHome/?access_token=$thingiToken";


  static String feedByKeyword(String keyword) {
    return  "https://api.thingiverse.com/search/$keyword?access_token=$thingiToken"; //אפשר לשים כאן כל דבר, לייתר ביטחון...
  }

  static String feedByCategory(String category) {
    return  "https://api.thingiverse.com/categories/$category/things?access_token=$thingiToken"; //אפשר לשים כאן כל דבר, לייתר ביטחון...
  }

}

class Webservice {

  Future<List<X2SetFeedBy>> setFeedByPopular() async {
    /// קטע זה מציג את המסך הראשי (קישור סטטי)
    print("A");
    final response = await http.get(Uri.parse(Constants.defaultFeed));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(response.body);
      Iterable postList = result; // result["hits"];
      return postList.map((article) => X2SetFeedBy.fromJSON(article)).toList();
    } else {
      print("Failed to get top news");
    }
  }

  Future<List<X2SetFeedBy>> setFeedByKeyword(String keyword) async {
    /// קטע זה מאפשר את יכולת החיפוש
    print("B");
    final response = await http.get(Uri.parse(Constants.feedByKeyword(keyword)));
        if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      Iterable list = result["hits"];
      return list.map((json) => X2SetFeedBy.fromJSON(json)).toList();
    } else {
    throw Exception("Failed to get news");
    }
  }

  Future<List<X2SetFeedBy>> setFeedByCategory(String category) async {
    /// קטע זה מאפשר את יכולת החיפוש
    print("C");
    final response = await http.get(Uri.parse(Constants.feedByCategory(category)));
    if (response.statusCode == 200) {
      final List<X2SetFeedBy> categories = categoryArrayFromJson(response.body);
      print(response.body);
      return categories;
    } else {
      throw Exception("Failed to get news");
    }
  }
}


/// 2 קישור ערכי האפליקציה לערכי הAPI ///

List<X2SetFeedBy> categoryArrayFromJson(String str) => List<X2SetFeedBy>.from(json.decode(str).map((x) => X2SetFeedBy.fromJSON(x)));

class X2SetFeedBy {

  final String postName;
  final String description;
  final String thumbnail;
  final String postURL;

  X2SetFeedBy({this.postName, this.description, this.thumbnail, this.postURL});

  factory X2SetFeedBy.fromJSON(Map<String, dynamic> json) { //הכוונה היא ל postList
    return X2SetFeedBy(
        postName: json["name"],
        description: json["url"],
        thumbnail: json["preview_image"],
        postURL: json["public_url"]
    );
  }
}

/// 3 יצירת מודל ערכים ///
class X3ModelString {

  X2SetFeedBy _x3Model;

  X3ModelString({X2SetFeedBy Xarticle}): _x3Model = Xarticle;

  String get nameModel3 {
    return _x3Model.postName;
  }

  String get descriptionModel3 {
    return _x3Model.description;
  }

  String get thumbnailModel3 {
    return _x3Model.thumbnail;
  }

  String get urlModel3 {
    return _x3Model.postURL;
  }

}


/*
TextFormField(
cursorColor: cursorColor,
decoration: InputDecoration(
filled: true,
icon: const Icon(Icons.email),
hintText: GalleryLocalizations.of(context)
.demoTextFieldYourEmailAddress,
labelText:
GalleryLocalizations.of(context).demoTextFieldEmail,
),
keyboardType: TextInputType.emailAddress,
onSaved: (value) {
person.email = value;
},
),*/
