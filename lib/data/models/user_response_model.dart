class UserResponseModel {
  List<DataUser>? data;
  int? total;
  int? page;
  int? limit;

  UserResponseModel({
    this.data,
    this.total,
    this.page,
    this.limit,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) => UserResponseModel(
    data: json["data"] == null ? [] : List<DataUser>.from(json["data"]!.map((x) => DataUser.fromJson(x))),
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

class DataUser {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;

  DataUser({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
  });

  factory DataUser.fromJson(Map<String, dynamic> json) => DataUser(
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
