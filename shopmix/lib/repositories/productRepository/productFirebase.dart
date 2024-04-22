import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/repositories/productRepository/IProductRepository.dart';

class ProductFirebase extends IProductRepository {
  @override
  Future<List<ProductModel>?> getProducts() async{

    return await GetIt.instance<Seeding>().products;





  }

  
}