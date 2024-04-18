class PostProfileResponseModel {
  List<DataPostProfile>? data;
  int? total;
  int? page;
  int? limit;

  PostProfileResponseModel({
    this.data,
    this.total,
    this.page,
    this.limit,
  });

  factory PostProfileResponseModel.fromJson(Map<String, dynamic> json) => PostProfileResponseModel(
    data: json["data"] == null ? [] : List<DataPostProfile>.from(json["data"]!.map((x) => DataPostProfile.fromJson(x))),
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

class DataPostProfile {
  String? id;
  String? image;
  int? likes;
  List<String>? tags;
  String? text;
  String? publishDate;
  Owner? owner;

  DataPostProfile({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  factory DataPostProfile.fromJson(Map<String, dynamic> json) => DataPostProfile(
    id: json["id"],
    image: json["image"],
    likes: json["likes"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    text: json["text"],
    publishDate: json["publishDate"],
    owner: json["owner"] == null ? null : Owner.fromJson(json["owner"]),
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

class Owner {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  Owner({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  factory Owner.fromJson(Map<String, dynamic> json) => Owner(
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
