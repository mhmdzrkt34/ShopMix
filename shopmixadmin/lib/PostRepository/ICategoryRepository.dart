import 'package:flutter/foundation.dart';
import 'package:shopmixadmin/models/category.dart';

abstract class ICategoryRepository {
  List<category> getCategories();
}
