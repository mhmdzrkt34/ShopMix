
import 'package:shopmixadmin/models/product.dart';

abstract class IProductRepository {
  List<ProductModel> getProducts();
}
