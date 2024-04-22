import 'package:shopmixadmin/PostRepository/ICategoryRepository.dart';
import 'package:shopmixadmin/models/category.dart';

class categoryApi extends ICategoryRepository {
  @override
  List<category> getCategories() {
    return [
      category(id: "1", name: "Electronics", parentCategoryId: null),
      category(id: "2", name: "Clothing", parentCategoryId: null),
      category(id: "3", name: "Books", parentCategoryId: null),
      category(id: "4", name: "Furniture", parentCategoryId: null),
      category(id: "5", name: "Appliances", parentCategoryId: null),
      category(id: "6", name: "Appliances", parentCategoryId: null),
      category(id: "7", name: "Appliances", parentCategoryId: null),
      category(id: "8", name: "Appliances", parentCategoryId: null),
      category(id: "9", name: "Appliances", parentCategoryId: null),
      category(id: "10", name: "Appliances", parentCategoryId: null),
      category(id: "11", name: "Appliances", parentCategoryId: null),
    ];
  }
}
