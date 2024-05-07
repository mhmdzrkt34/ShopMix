class user {
  late String? id;
  final String name;
  final String? Email;
  final String? ProfileURL;
  final String? PhoneNumber;
  final bool? Active;

  user({
    required this.name,
    this.id,
    this.Email,
    this.ProfileURL,
    this.Active,
    this.PhoneNumber,
  });

  factory user.fromJson(Map<String, dynamic> json, String idd) {
    user a = user(
      id: idd,
      name: json['Name'],
      Email: json['Email'],
      ProfileURL: json['ProfileURL'],
      Active: json['Active'],
      PhoneNumber: json['PhoneNumber'],
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

  String? extractCountryCode() {
    if (PhoneNumber != null && PhoneNumber!.contains("IsoCode.")) {
      int startIndex = PhoneNumber!.indexOf("IsoCode.") + "IsoCode.".length;

      if (startIndex != -1 && startIndex + 2 <= PhoneNumber!.length) {
        return PhoneNumber!.substring(startIndex, startIndex + 2);
      }
    }
    return null;
  }
}
