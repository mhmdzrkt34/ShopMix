import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopmixadmin/models/Product_Image_Model.dart';

class ProductModel {
  late String id;

  late bool isNew;
  late double salePercentage;
  late String title;
  late double price;
  late List<ProductImageModel> images = [];

  late String description;
  late int quantiy;
  late String category_id;

  ProductModel(
      {required this.id,
      required this.isNew,
      required this.salePercentage,
      required this.title,
      required this.price,
      required this.images,
      required this.description,
      required this.category_id,
      required this.quantiy});

  static Future<ProductModel> FromJson(
      Map<String, dynamic> json, String idd) async {
    bool issNew;
    double salePercentagee = (json["salePercent"] as num).toDouble();

    Timestamp timestamp = json['created_time'];
    DateTime createdTime = timestamp.toDate();

    List<ProductImageModel> imagess = [];

    DateTime twoDaysAgo = DateTime.now().subtract(Duration(days: 2));
    if (createdTime!.isAfter(twoDaysAgo)) {
      issNew = true;
    } else {
      issNew = false;
    }

    String titlee = json['title'];
    double pricee = json['price'].toDouble();
    String descriptionn = json['description'];
    String category_idd = json['category_id'];
    int quantiyy = json['quantity'].toInt();

    Query productImages = FirebaseFirestore.instance
        .collection("productImages")
        .where("product_id", isEqualTo: idd);
    await productImages.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        imagess.add(ProductImageModel(
            Id: doc.id,
            product_id: data['product_id'],
            ImageUrl: data['ImageUrl']));
      }
    }).catchError((error) {
      print("Error fetching product images: $error");
    });

    return ProductModel(
        id: idd,
        isNew: issNew,
        salePercentage: salePercentagee,
        title: titlee,
        price: pricee,
        images: imagess,
        description: descriptionn,
        category_id: category_idd,
        quantiy: quantiyy);
  }
}
