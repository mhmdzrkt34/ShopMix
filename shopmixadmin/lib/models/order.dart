import 'package:cloud_firestore/cloud_firestore.dart';

class order {
  final Timestamp date;
  final int quantity;
  final double totalPrice;
  final String userEmail;
  final String id;
  final bool delivered;

  order({
    required this.date,
    required this.id,
    required this.quantity,
    required this.totalPrice,
    required this.userEmail,
    required this.delivered,
  });

  factory order.fromJson(Map<String, dynamic> data, String idd) {
    return order(
      id: idd,
      date: data['date'] ?? Timestamp.now(),
      quantity: data['quantity'] ?? 0,
      totalPrice: (data['totalPrice'] ?? 0).toDouble(),
      userEmail: data['user_email'] ?? '',
      delivered: data['delivered'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'quantity': quantity,
      'totalPrice': totalPrice,
      'user_email': userEmail,
    };
  }
}
