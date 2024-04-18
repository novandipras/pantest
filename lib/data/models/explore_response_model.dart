class ExploreResponseModel {
  List<DataExplore>? data;
  int? total;
  int? page;
  int? limit;

  ExploreResponseModel({
    this.data,
    this.total,
    this.page,
    this.limit,
  });

  factory ExploreResponseModel.fromJson(Map<String, dynamic> json) => ExploreResponseModel(
    data: json["data"] == null ? [] : List<DataExplore>.from(json["data"]!.map((x) => DataExplore.fromJson(x))),
    total: json["total"],
    page: json["page"],
    limit: json["limit"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "total": total,
    "page": page,
    "limit": limit,
  };
}

class DataExplore {
  String? id;
  String? image;
  int? likes;
  List<String>? tags;
  String? text;
  String? publishDate;
  OwnerExplore? owner;

  DataExplore({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  factory DataExplore.fromJson(Map<String, dynamic> json) => DataExplore(
    id: json["id"],
    image: json["image"],
    likes: json["likes"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    text: json["text"],
    publishDate: json["publishDate"],
    owner: json["owner"] == null ? null : OwnerExplore.fromJson(json["owner"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "likes": likes,
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
    "text": text,
    "publishDate": publishDate,
    "owner": owner?.toJson(),
  };
}

class OwnerExplore {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  OwnerExplore({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  factory OwnerExplore.fromJson(Map<String, dynamic> json) => OwnerExplore(
    id: json["id"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
  };
}
