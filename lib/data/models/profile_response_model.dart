class ProfileResponseModel {
  String? id;
  String? title;
  String? firstName;
  String? lastName;
  String? picture;
  String? gender;
  String? email;
  String? dateOfBirth;
  String? phone;
  Location? location;
  String? registerDate;
  String? updatedDate;

  ProfileResponseModel({
    this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.picture,
    this.gender,
    this.email,
    this.dateOfBirth,
    this.phone,
    this.location,
    this.registerDate,
    this.updatedDate,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    id: json["id"],
    title: json["title"],
    firstName: json["firstName"],
    lastName: json["lastName"],
    picture: json["picture"],
    gender: json["gender"],
    email: json["email"],
    dateOfBirth: json["dateOfBirth"],
    phone: json["phone"],
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    registerDate: json["registerDate"],
    updatedDate: json["updatedDate"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "firstName": firstName,
    "lastName": lastName,
    "picture": picture,
    "gender": gender,
    "email": email,
    "dateOfBirth": dateOfBirth,
    "phone": phone,
    "location": location?.toJson(),
    "registerDate": registerDate,
    "updatedDate": updatedDate,
  };
}

class Location {
  String? street;
  String? city;
  String? state;
  String? country;
  String? timezone;

  Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.timezone,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    street: json["street"],
    city: json["city"],
    state: json["state"],
    country: json["country"],
    timezone: json["timezone"],
  );

  Map<String, dynamic> toJson() => {
    "street": street,
    "city": city,
    "state": state,
    "country": country,
    "timezone": timezone,
  };
}
