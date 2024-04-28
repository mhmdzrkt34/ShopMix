import 'package:shopmixadmin/PostRepository/product/IProductRepository.dart';
import 'package:shopmixadmin/models/Product_Image_Model.dart';
import 'package:shopmixadmin/models/product.dart';

class productApi extends IProductRepository {
  List<ProductModel> products = [];
  List<ProductImageModel> images = [];

  @override
  List<ProductModel> getProducts() {
    images.add(ProductImageModel(
        Id: "123",
        product_id: "1",
        ImageUrl:
            "https://www.pngall.com/wp-content/uploads/2016/04/Keyboard-Download-PNG.png"));
    images.add(ProductImageModel(
        Id: "1234",
        product_id: "1",
        ImageUrl:
            "https://pluspng.com/img-png/laptop-png-laptop-notebook-png-image-image-6746-1153.png"));

    products.add(ProductModel(
        id: "1",
        isNew: true,
        salePercentage: 10,
        title: "keyboard",
        price: 250,
        images: images,
        description:
            "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
        category_id: "7"));

    products.add(ProductModel(
        id: "2",
        isNew: false,
        salePercentage: 20,
        title: "laptop",
        price: 500,
        images: images,
        description:
            "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
        category_id: "8"));

    products.add(ProductModel(
        id: "3",
        isNew: true,
        salePercentage: 0,
        title: "ps5",
        price: 700,
        images: images,
        description:
            "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
        category_id: "22"));

    products.add(ProductModel(
        id: "4",
        isNew: true,
        salePercentage: 0,
        title: "rtx 3070",
        price: 1300,
        images: images,
        description:
            "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",
        category_id: "22"));

    return products;
  }
}
