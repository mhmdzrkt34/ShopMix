class CartProductModel {

  late String id;
  
  late String productImageUrl;
  late bool isNew;
  late double salePercentage;
  late String title;
  late double price;
  late int quantiy;

  CartProductModel({required this.id, required this.productImageUrl,required this.isNew,required this.salePercentage,required this.title,required this.price,required this.quantiy});
}