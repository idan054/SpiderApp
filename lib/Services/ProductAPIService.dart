/// ProductThingAPI ///
import 'dart:convert';
import 'package:http/http.dart' as http;

/// 1 חיבור לAPI ///

class Constants {
  static String productHeadlLine(/*String Id*/) {
    return  "https://api.thingiverse.com/things/4038181?access_token=5ddb8eeeb534d2e001918930d35b90a9"; //אפשר לשים כאן כל דבר, לייתר ביטחון...
  }
}

class WebProductService {

  Future <List<ProductPageBy>> setFeedByProductID(/*String keyword*/) async {
    /// קטע זה מאפשר את יכולת החיפוש
      final response = await http.get(Constants.productHeadlLine(/*Id*/));
//    try {
      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        Iterable list = result["object"].catchError(
            " לפחות עד response.body הכל בסדר${response.body}");
        return list.map((json) =>
            ProductPageBy.fromJson /*productThingApiFromJson*/(json)).toList();
      } else {
        return List<ProductPageBy>();
      }
//    }catch(e){
//      return List<ProductPageBy>();
  }
  }




/// 2 קישור ערכי האפליקציה לערכי הAPI של המוצר ע"י https://app.quicktype.io ///


// To parse this JSON data, do
//
//     final productThingApi = productThingApiFromJson(jsonString);

ProductPageBy productThingApiFromJson(String str) => ProductPageBy.fromJson(json.decode(str));

String productThingApiToJson(ProductPageBy data) => json.encode(data.toJson());

class ProductPageBy {
  ProductPageBy({
    this.id,
    this.name,
    this.thumbnail,
    this.url,
    this.publicUrl,
    this.creator,
    this.added,
    this.modified,
    this.isPublished,
    this.isWip,
    this.isFeatured,
    this.isNsfw,
    this.likeCount,
    this.isLiked,
    this.collectCount,
    this.isCollected,
    this.commentCount,
    this.isWatched,
    this.defaultImage,
    this.description,
    this.instructions,
    this.descriptionHtml,
    this.instructionsHtml,
    this.details,
    this.detailsParts,
    this.eduDetails,
    this.eduDetailsParts,
    this.license,
    this.filesUrl,
    this.imagesUrl,
    this.likesUrl,
    this.ancestorsUrl,
    this.derivativesUrl,
    this.tagsUrl,
    this.tags,
    this.categoriesUrl,
    this.fileCount,
    this.layoutCount,
    this.layoutsUrl,
    this.isPrivate,
    this.isPurchased,
    this.inLibrary,
    this.printHistoryCount,
    this.appId,
    this.downloadCount,
    this.viewCount,
    this.education,
    this.remixCount,
    this.makeCount,
    this.appCount,
    this.rootCommentCount,
    this.moderation,
    this.isDerivative,
    this.ancestors,
  });

  int id;
  String name;
  String thumbnail;
  String url;
  String publicUrl;
  Creator creator;
  DateTime added;
  DateTime modified;
  int isPublished;
  int isWip;
  dynamic isFeatured;
  bool isNsfw;
  int likeCount;
  bool isLiked;
  int collectCount;
  bool isCollected;
  int commentCount;
  bool isWatched;
  DefaultImage defaultImage;
  String description;
  String instructions;
  String descriptionHtml;
  String instructionsHtml;
  String details;
  List<DetailsPart> detailsParts;
  String eduDetails;
  List<EduDetailsPart> eduDetailsParts;
  String license;
  String filesUrl;
  String imagesUrl;
  String likesUrl;
  String ancestorsUrl;
  String derivativesUrl;
  String tagsUrl;
  List<Tag> tags;
  String categoriesUrl;
  int fileCount;
  int layoutCount;
  String layoutsUrl;
  int isPrivate;
  int isPurchased;
  bool inLibrary;
  int printHistoryCount;
  dynamic appId;
  int downloadCount;
  int viewCount;
  Education education;
  int remixCount;
  int makeCount;
  int appCount;
  int rootCommentCount;
  String moderation;
  bool isDerivative;
  List<dynamic> ancestors;

  factory ProductPageBy.fromJson(Map<String, dynamic> json) => ProductPageBy(
    id: json["id"],
    name: json["name"],
    thumbnail: json["thumbnail"],
    url: json["url"],
    publicUrl: json["public_url"],
    creator: Creator.fromJson(json["creator"]),
    added: DateTime.parse(json["added"]),
    modified: DateTime.parse(json["modified"]),
    isPublished: json["is_published"],
    isWip: json["is_wip"],
    isFeatured: json["is_featured"],
    isNsfw: json["is_nsfw"],
    likeCount: json["like_count"],
    isLiked: json["is_liked"],
    collectCount: json["collect_count"],
    isCollected: json["is_collected"],
    commentCount: json["comment_count"],
    isWatched: json["is_watched"],
    defaultImage: DefaultImage.fromJson(json["default_image"]),
    description: json["description"],
    instructions: json["instructions"],
    descriptionHtml: json["description_html"],
    instructionsHtml: json["instructions_html"],
    details: json["details"],
    detailsParts: List<DetailsPart>.from(json["details_parts"].map((x) => DetailsPart.fromJson(x))),
    eduDetails: json["edu_details"],
    eduDetailsParts: List<EduDetailsPart>.from(json["edu_details_parts"].map((x) => EduDetailsPart.fromJson(x))),
    license: json["license"],
    filesUrl: json["files_url"],
    imagesUrl: json["images_url"],
    likesUrl: json["likes_url"],
    ancestorsUrl: json["ancestors_url"],
    derivativesUrl: json["derivatives_url"],
    tagsUrl: json["tags_url"],
    tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
    categoriesUrl: json["categories_url"],
    fileCount: json["file_count"],
    layoutCount: json["layout_count"],
    layoutsUrl: json["layouts_url"],
    isPrivate: json["is_private"],
    isPurchased: json["is_purchased"],
    inLibrary: json["in_library"],
    printHistoryCount: json["print_history_count"],
    appId: json["app_id"],
    downloadCount: json["download_count"],
    viewCount: json["view_count"],
    education: Education.fromJson(json["education"]),
    remixCount: json["remix_count"],
    makeCount: json["make_count"],
    appCount: json["app_count"],
    rootCommentCount: json["root_comment_count"],
    moderation: json["moderation"],
    isDerivative: json["is_derivative"],
    ancestors: List<dynamic>.from(json["ancestors"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "thumbnail": thumbnail,
    "url": url,
    "public_url": publicUrl,
    "creator": creator.toJson(),
    "added": added.toIso8601String(),
    "modified": modified.toIso8601String(),
    "is_published": isPublished,
    "is_wip": isWip,
    "is_featured": isFeatured,
    "is_nsfw": isNsfw,
    "like_count": likeCount,
    "is_liked": isLiked,
    "collect_count": collectCount,
    "is_collected": isCollected,
    "comment_count": commentCount,
    "is_watched": isWatched,
    "default_image": defaultImage.toJson(),
    "description": description,
    "instructions": instructions,
    "description_html": descriptionHtml,
    "instructions_html": instructionsHtml,
    "details": details,
    "details_parts": List<dynamic>.from(detailsParts.map((x) => x.toJson())),
    "edu_details": eduDetails,
    "edu_details_parts": List<dynamic>.from(eduDetailsParts.map((x) => x.toJson())),
    "license": license,
    "files_url": filesUrl,
    "images_url": imagesUrl,
    "likes_url": likesUrl,
    "ancestors_url": ancestorsUrl,
    "derivatives_url": derivativesUrl,
    "tags_url": tagsUrl,
    "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
    "categories_url": categoriesUrl,
    "file_count": fileCount,
    "layout_count": layoutCount,
    "layouts_url": layoutsUrl,
    "is_private": isPrivate,
    "is_purchased": isPurchased,
    "in_library": inLibrary,
    "print_history_count": printHistoryCount,
    "app_id": appId,
    "download_count": downloadCount,
    "view_count": viewCount,
    "education": education.toJson(),
    "remix_count": remixCount,
    "make_count": makeCount,
    "app_count": appCount,
    "root_comment_count": rootCommentCount,
    "moderation": moderation,
    "is_derivative": isDerivative,
    "ancestors": List<dynamic>.from(ancestors.map((x) => x)),
  };
}

class Creator {
  Creator({
    this.id,
    this.name,
    this.firstName,
    this.lastName,
    this.url,
    this.publicUrl,
    this.thumbnail,
    this.countOfFollowers,
    this.countOfFollowing,
    this.countOfDesigns,
    this.acceptsTips,
    this.isFollowing,
    this.location,
    this.cover,
  });

  int id;
  String name;
  String firstName;
  String lastName;
  String url;
  String publicUrl;
  String thumbnail;
  int countOfFollowers;
  int countOfFollowing;
  int countOfDesigns;
  bool acceptsTips;
  bool isFollowing;
  String location;
  String cover;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
    id: json["id"],
    name: json["name"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    url: json["url"],
    publicUrl: json["public_url"],
    thumbnail: json["thumbnail"],
    countOfFollowers: json["count_of_followers"],
    countOfFollowing: json["count_of_following"],
    countOfDesigns: json["count_of_designs"],
    acceptsTips: json["accepts_tips"],
    isFollowing: json["is_following"],
    location: json["location"],
    cover: json["cover"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "first_name": firstName,
    "last_name": lastName,
    "url": url,
    "public_url": publicUrl,
    "thumbnail": thumbnail,
    "count_of_followers": countOfFollowers,
    "count_of_following": countOfFollowing,
    "count_of_designs": countOfDesigns,
    "accepts_tips": acceptsTips,
    "is_following": isFollowing,
    "location": location,
    "cover": cover,
  };
}

class DefaultImage {
  DefaultImage({
    this.id,
    this.url,
    this.name,
    this.sizes,
    this.added,
  });

  int id;
  String url;
  String name;
  List<Size> sizes;
  DateTime added;

  factory DefaultImage.fromJson(Map<String, dynamic> json) => DefaultImage(
    id: json["id"], ///ID של התמונה
    url: json["url"],
    name: json["name"],
    sizes: List<Size>.from(json["sizes"].map((x) => Size.fromJson(x))),
    added: DateTime.parse(json["added"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "url": url,
    "name": name,
    "sizes": List<dynamic>.from(sizes.map((x) => x.toJson())),
    "added": added.toIso8601String(),
  };
}

class Size {
  Size({
    this.type,
    this.size,
    this.url,
  });

  Type type;
  String size;
  String url;

  factory Size.fromJson(Map<String, dynamic> json) => Size(
    type: typeValues.map[json["type"]],
    size: json["size"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "type": typeValues.reverse[type],
    "size": size,
    "url": url,
  };
}

enum Type { THUMB, PREVIEW, DISPLAY }

final typeValues = EnumValues({
  "display": Type.DISPLAY,
  "preview": Type.PREVIEW,
  "thumb": Type.THUMB
});

class DetailsPart {
  DetailsPart({
    this.type,
    this.name,
    this.required,
    this.data,
  });

  String type;
  String name;
  String required;
  List<Datum> data;

  factory DetailsPart.fromJson(Map<String, dynamic> json) => DetailsPart(
    type: json["type"],
    name: json["name"],
    required: json["required"] == null ? null : json["required"],
    data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "required": required == null ? null : required,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
} // הסברים פר אובייקט

class Datum {
  Datum({
    this.content,
    this.printer,
    this.rafts,
    this.supports,
    this.resolution,
    this.infill,
    this.notes,
  });

  String content;
  String printer;
  String rafts;
  String supports;
  String resolution;
  String infill;
  String notes;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    content: json["content"] == null ? null : json["content"],
    printer: json["printer"] == null ? null : json["printer"],
    rafts: json["rafts"] == null ? null : json["rafts"],
    supports: json["supports"] == null ? null : json["supports"],
    resolution: json["resolution"] == null ? null : json["resolution"],
    infill: json["infill"] == null ? null : json["infill"],
    notes: json["notes"] == null ? null : json["notes"],
  );

  Map<String, dynamic> toJson() => {
    "content": content == null ? null : content,
    "printer": printer == null ? null : printer,
    "rafts": rafts == null ? null : rafts,
    "supports": supports == null ? null : supports,
    "resolution": resolution == null ? null : resolution,
    "infill": infill == null ? null : infill,
    "notes": notes == null ? null : notes,
  };
} // הצעות להגדרות הדפסה

class EduDetailsPart {
  EduDetailsPart({
    this.type,
    this.name,
    this.required,
    this.saveAsComponent,
    this.template,
    this.fieldname,
    this.eduDetailsPartDefault,
    this.opts,
    this.label,
  });

  String type;
  String name;
  dynamic required;
  bool saveAsComponent;
  String template;
  String fieldname;
  String eduDetailsPartDefault;
  dynamic opts;
  String label;

  factory EduDetailsPart.fromJson(Map<String, dynamic> json) => EduDetailsPart(
    type: json["type"],
    name: json["name"],
    required: json["required"],
    saveAsComponent: json["save_as_component"] == null ? null : json["save_as_component"],
    template: json["template"] == null ? null : json["template"],
    fieldname: json["fieldname"] == null ? null : json["fieldname"],
    eduDetailsPartDefault: json["default"] == null ? null : json["default"],
    opts: json["opts"],
    label: json["label"] == null ? null : json["label"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "name": name,
    "required": required,
    "save_as_component": saveAsComponent == null ? null : saveAsComponent,
    "template": template == null ? null : template,
    "fieldname": fieldname == null ? null : fieldname,
    "default": eduDetailsPartDefault == null ? null : eduDetailsPartDefault,
    "opts": opts,
    "label": label == null ? null : label,
  };
}

class Education {
  Education({
    this.grades,
    this.subjects,
  });

  List<dynamic> grades;
  List<dynamic> subjects;

  factory Education.fromJson(Map<String, dynamic> json) => Education(
    grades: List<dynamic>.from(json["grades"].map((x) => x)),
    subjects: List<dynamic>.from(json["subjects"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "grades": List<dynamic>.from(grades.map((x) => x)),
    "subjects": List<dynamic>.from(subjects.map((x) => x)),
  };
}

class Tag {
  Tag({
    this.name,
    this.url,
    this.count,
    this.thingsUrl,
    this.absoluteUrl,
  });

  String name;
  String url;
  int count;
  String thingsUrl;
  String absoluteUrl;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
    name: json["name"],
    url: json["url"],
    count: json["count"],
    thingsUrl: json["things_url"],
    absoluteUrl: json["absolute_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
    "count": count,
    "things_url": thingsUrl,
    "absolute_url": absoluteUrl,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}



/// 3 יצירת מודל ערכים ///
class X4ProductModel {

  ProductPageBy _productModel;

  X4ProductModel({ProductPageBy ProductArticle}): _productModel = ProductArticle;

  String get getProductName {
    return _productModel.name;

  }

  String get getProductFiles {
    return _productModel.filesUrl;
  }

  String get getProductThumbnail {
    return _productModel.thumbnail;
  }

  int get getProductImagesID {
    return _productModel.defaultImage.id;
  }

  String get getProductPublicUrl {
    return _productModel.publicUrl;
  }

  String get getProductDescription {
    return _productModel.description;
  }

}






