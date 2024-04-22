class CategoryModel {


  late String Id;
  late String name;
  late List<CategoryModel> categories;
  bool visible;
  bool downward;
  
CategoryModel({required this.Id,required this.name,required this.categories,this.visible=false, this.downward=true});

void toggleVisibility(){
  visible = !visible;
}

}
