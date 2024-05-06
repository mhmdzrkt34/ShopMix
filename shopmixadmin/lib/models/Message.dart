class Message {
  late String? id;
  final String email;
  final String message;
  final String type;
  final DateTime time;

  Message({
    required this.email,
    required this.message,
    required this.type,
    this.id,
    required this.time,
  });

  factory Message.fromJson(Map<String, dynamic>? json, String idd) {
    return Message(
      id: idd,
      email: json!['email'],
      message: json['message'],
      type: json['type'],
      time: json['date'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'message': message,
      'type': type,
    };
  }
}
