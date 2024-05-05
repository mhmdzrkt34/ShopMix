import 'dart:ffi';

class user {
  late String? id;
  final String name;
  final String? Email;
  final String? ProfileURL;
  final bool? Active;

  user({
    required this.name,
    this.id,
    this.Email,
    this.ProfileURL,
    this.Active,
  });

  factory user.fromJson(Map<String, dynamic> json, String idd) {
    user a = user(
      id: idd,
      name: json['Name'],
      Email: json['Email'],
      ProfileURL: json['ProfileURL'],
      Active: json['Active'],
    );
    return a;
  }

  Map<String, dynamic> toJson() {
    return {
      'Name': name,
      'Email': Email,
      'ProfileURL': ProfileURL,
      'Active': Active,
    };
  }
}
