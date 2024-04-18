class DataSavedPostModel {
  String? id;
  String? image;
  int? likes;
  List<String>? tags;
  String? text;
  String? publishDate;
  OwnerDataSavedPost? owner;

  DataSavedPostModel({
    this.id,
    this.image,
    this.likes,
    this.tags,
    this.text,
    this.publishDate,
    this.owner,
  });

  factory DataSavedPostModel.fromJson(Map<String, dynamic> json) => DataSavedPostModel(
    id: json["id"],
    image: json["image"],
    likes: json["likes"],
    tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
    text: json["text"],
    publishDate: json["publishDate"],
    owner: json["owner"] == null ? null : OwnerDataSavedPost.fromJson(json["owner"]),
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

class OwnerDataSavedPost {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  OwnerDataSavedPost({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  factory OwnerDataSavedPost.fromJson(Map<String, dynamic> json) => OwnerDataSavedPost(
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
