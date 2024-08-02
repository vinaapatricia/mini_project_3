class Address {
  GeoLocation geoLocation;
  String city;
  String street;
  int number;
  String zipCode;

  Address({
    required this.geoLocation,
    required this.city,
    required this.street,
    required this.number,
    required this.zipCode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? '',
      geoLocation: GeoLocation.fromJson(json['geolocation'] ?? {}),
      number: json['number'] ?? 0,
      street: json['street'] ?? '',
      zipCode: json['zipcode'] ?? '',
    );
  }
}

class GeoLocation {
  String lat;
  String long;

  GeoLocation({
    required this.lat,
    required this.long,
  });

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      lat: json['lat'] ?? '',
      long: json['long'] ?? '',
    );
  }
}

class Name {
  String firstname;
  String lastname;

  Name({
    required this.firstname,
    required this.lastname,
  });

  factory Name.fromJson(Map<String, dynamic> json) {
    return Name(
      firstname: json['firstname'] ?? '',
      lastname: json['lastname'] ?? '',
    );
  }
}

class Profile {
  Address address;
  int id;
  String email;
  String username;
  String password;
  Name name;
  String phone;
  int v;

  Profile({
    required this.address,
    required this.id,
    required this.email,
    required this.username,
    required this.password,
    required this.name,
    required this.phone,
    required this.v,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      address: Address.fromJson(json['address'] ?? {}),
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      password: json['password'] ?? '',
      name: Name.fromJson(json['name'] ?? {}),
      phone: json['phone'] ?? '',
      v: json['__v'] ?? 0,
    );
  }
}
