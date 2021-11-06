import 'dart:convert';
import 'package:dart_random_choice/dart_random_choice.dart';
import 'package:http/http.dart' as http;

/// 1 חיבור לAPI ///

var defaultList = ['featured','popular' ,'verified','newest'];
var randomHome = randomChoice(defaultList);

class Constants {
  static String imagesById =  "https://api.thingiverse.com/things/1945168/images/?access_token=5ddb8eeeb534d2e001918930d35b90a9";
}

class ImagesByIdService {

  Future<List<X2GetImages>> setFeedByPopular() async {
    /// קטע זה מציג את המסך הראשי (קישור סטטי)
    final response = await http.get(Uri.parse(Constants.imagesById));

    if (response.statusCode == 200) {
      final result = jsonDecode(response.body);
      print(response.body);
      Iterable postList = result; // result["hits"];
      return postList.map((article) => X2GetImages.fromJSON(article)).toList();
    } else {
      throw Exception("Failed to get top news");
    }
  }
}

/// 2 קישור ערכי האפליקציה לערכי הAPI ///

List<X2GetImages> categoryArrayFromJson(String str) =>
    List<X2GetImages>.from(json.decode(str).map((x) => X2GetImages.fromJSON(x)));

class X2GetImages {

  final String id;
  final String name;
  final String url;

  X2GetImages({this.id, this.name, this.url,});

  factory X2GetImages.fromJSON(Map<String, dynamic> jsonMap) { //הכוונה היא ל postList
    return X2GetImages(
        id: jsonMap["id"],
        name: jsonMap["name"],
        url: jsonMap["url"],
    );
  }
}