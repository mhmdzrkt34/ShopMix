import 'dart:io';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopmixadmin/Controllers/UpdateProductFormController.dart';

import 'package:shopmixadmin/components/App_Bar.dart';
import 'package:shopmixadmin/components/FormFielComonent.dart';
import 'package:shopmixadmin/components/FormFieldnumberComonent.dart';
import 'package:shopmixadmin/components/Side_Bar.dart';
import 'package:shopmixadmin/components/Text_Area.dart';
import 'package:shopmixadmin/components/buttonComponent/button_component.dart';
import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:provider/provider.dart';

import 'package:shopmixadmin/image_provider/product_update_image_provider.dart';
import 'package:shopmixadmin/model_views/category_model_view.dart';
import 'package:shopmixadmin/models/category.dart';
import 'package:shopmixadmin/models/product.dart';

class EditProduct extends StatelessWidget {
  ProductModel _updateproduct;

  EditProduct(this._updateproduct);
  late double _deviceHight;
  late double _deviceWidth;

  final ImagePicker picker = ImagePicker();
  late BuildContext _context;

  Future<void> _selectImages() async {
    try {
      final String? selectedOption = await showDialog<String>(
        context: _context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text('Select Image'),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 'Gallery'),
                child: const Text('Gallery'),
              ),
              SimpleDialogOption(
                onPressed: () => Navigator.pop(context, 'Camera'),
                child: const Text('Camera'),
              ),
            ],
          );
        },
      );

      if (selectedOption != null) {
        List<XFile> selectedImages = [];

        // Handle gallery or camera choice
        if (selectedOption == 'Gallery') {
          selectedImages = await picker.pickMultiImage();
        } else if (selectedOption == 'Camera') {
          final XFile? image =
              await picker.pickImage(source: ImageSource.camera);
          if (image != null) {
            selectedImages.add(image);
          }
        }

        if (selectedImages.isNotEmpty) {
          GetIt.instance
              .get<ProductupdateImageProvider>()
              .addimages(selectedImages);
          print("Images added");
        }
      }
    } catch (e) {
      print("Exception error: " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    GetIt.instance<UpdateProductFormController>().updatedproduct =
        _updateproduct;

    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<CategoryModelView>(),
        ),
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<ProductupdateImageProvider>(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBar(_deviceHight, _deviceWidth, "Edit Product"),
        drawer: SideBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _maincolumn(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _selectImages();
            },
            child: const Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top: 0,
                  bottom: 0,
                  child: Icon(Icons.image),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(Icons.add),
                ),
              ],
            )),
      ),
    );
  }

  Widget _maincolumn() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _logofather(),
        _form(),
      ],
    );
  }

  Widget _logofather() {
    return Container(
      width: _deviceWidth,
      height: _deviceHight * 0.1,
      margin: EdgeInsets.only(top: _deviceHight * 0.005),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          logo(_deviceHight * 0.05, _deviceWidth * 0.3, const Color(0xFF1A1A1A),
              20),
        ],
      ),
    );
  }

  Widget _form() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHight * 0.025),
      child: Form(
          key: GetIt.instance<UpdateProductFormController>().productFormKey,
          child: Column(
            children: _FormFields(),
          )),
    );
  }

  List<Widget> _FormFields() {
    return [
      _producttitle(),
      _Description(),
      _price(),
      _sale(),
      _quantity(),
      _category(),
      _productImage(),
      _submitbuttom(),
    ];
  }

  Widget _price() {
    GetIt.instance<UpdateProductFormController>()
        .changePrice(_updateproduct.price.toString());
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: Formfeildnumber(
        _priceValidate,
        GetIt.instance<UpdateProductFormController>().changePrice,
        "Price",
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Icon(Icons.price_change_outlined),
        _updateproduct.price.toString(),
      ),
    );
  }

  String? _priceValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price is required';
    }

    return null;
  }

  Widget _sale() {
    GetIt.instance<UpdateProductFormController>()
        .changesale(_updateproduct.salePercentage.toString());
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: Formfeildnumber(
        _saleeValidate,
        GetIt.instance<UpdateProductFormController>().changesale,
        "Sale",
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Icon(Icons.percent_outlined),
        _updateproduct.salePercentage.toString(),
      ),
    );
  }

  String? _saleeValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'sale is required';
    } else if (double.parse(value) > 100 || double.parse(value) < 0) {
      return " sale must be persentage bettween 0 and 100";
    }

    return null;
  }

  Widget _quantity() {
    GetIt.instance<UpdateProductFormController>()
        .changequantity(_updateproduct.quantiy.toString());
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: Formfeildnumber(
        _quantityValidate,
        GetIt.instance<UpdateProductFormController>().changequantity,
        "Quantity",
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        const Icon(Icons.add_chart),
        _updateproduct.quantiy.toString(),
      ),
    );
  }

  String? _quantityValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Quantity is required';
    }
    return null;
  }

  Widget _producttitle() {
    GetIt.instance<UpdateProductFormController>()
        .changeTitle(_updateproduct.title);
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: FormFieldComponent(
        _titleValidate,
        GetIt.instance<UpdateProductFormController>().changeTitle,
        "Product Title",
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        false,
        const Icon(Icons.paste_rounded),
        _updateproduct.title,
      ),
    );
  }

  String? _titleValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
    }
    return null;
  }

  Widget _Description() {
    GetIt.instance<UpdateProductFormController>()
        .changeDescription(_updateproduct.description);
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: TextAreaComponent(
        _discriptionValidate,
        GetIt.instance<UpdateProductFormController>().changeDescription,
        "Description",
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        false,
        1,
        const Icon(Icons.description_outlined),
        _updateproduct.description,
      ),
    );
  }

  String? _discriptionValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'discription is required';
    }
    return null;
  }

  Selector<CategoryModelView, List<category>?> _category() {
    return Selector<CategoryModelView, List<category>?>(
      selector: (context, provider) => provider.categories,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        print("category selector is rendered");

        return _categories(value);
      },
    );
  }

  Widget _categories(List<category>? value) {
    if (value == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    GetIt.instance<UpdateProductFormController>()
        .changecategory(_updateproduct.category_id);
    return Container(
      width: _deviceWidth * 0.85,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: DropdownSearch<category>(
        selectedItem: value.firstWhere(
            (category) => category.id == _updateproduct.category_id),
        popupProps: const PopupProps.modalBottomSheet(
          showSearchBox: true,
          title: Center(
              child: Text(
            "Select Category",
            style: TextStyle(fontSize: 20, color: Colors.grey),
          )),
        ),
        items: value,
        itemAsString: (category u) => u.name,
        dropdownDecoratorProps: const DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            focusColor: Color.fromARGB(255, 33, 10, 135),
            labelText: "Category",
            hintText: "Enter the product category",
          ),
          baseStyle: TextStyle(color: Colors.black),
        ),
        onChanged: (value) {
          print(value!.id);
          GetIt.instance<UpdateProductFormController>()
              .changecategory(value!.id);
        },
        validator: (value) {
          if (value == null) {
            return " category must be selected";
          }
          return null;
        },
      ),
    );
  }

  Selector<ProductupdateImageProvider, List<XFile>?> _productImage() {
    return Selector<ProductupdateImageProvider, List<XFile>?>(
      selector: (context, provider) => provider.imagefileList,
      shouldRebuild: (previous, next) => !identical(previous, next),
      builder: (context, value, child) {
        print("image selector is rendered");

        return _imageshow(value);
      },
    );
  }

  Widget _imageshow(List<XFile>? value) {
    print(value!.isEmpty);
    if (value.isEmpty) {
      return Center(
        child: Container(
          alignment: Alignment.center,
          width: _deviceWidth * 0.8,
          height: _deviceHight * 0.2,
          padding: EdgeInsets.all(_deviceWidth * 0.1),
          child: Text("No Images Selected yet"),
        ),
      );
    } else {
      return Container(
        margin: EdgeInsets.only(top: _deviceHight * 0.05),
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(
              color: Colors.black87,
              width: 4,
              style: BorderStyle.solid,
            ),
          ),
        ),
        height: _deviceHight * 0.3,
        child: ListView.builder(
          itemCount: value.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: _deviceWidth * 0.8,
              padding: EdgeInsets.all(_deviceWidth * 0.05),
              child: Container(
                width: _deviceWidth * 0.8,
                padding: EdgeInsets.all(_deviceWidth * 0.05),
                decoration: BoxDecoration(
                  border: Border.all(
                    style: BorderStyle.solid,
                    color: Colors.grey,
                    width: 6.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Stack(
                  clipBehavior: Clip.hardEdge,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.file(
                        File(value[index].path),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.delete_forever_sharp,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          GetIt.instance
                              .get<ProductupdateImageProvider>()
                              .deleteimage(value[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      );
    }
  }

  Widget _submitbuttom() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHight * 0.005),
      child: buttonComponent(
        [_deviceWidth * 0.6, _deviceHight * 0.05],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        "Update",
        GetIt.instance<UpdateProductFormController>().onTap,
        const Color(0xFFDB3022),
        20,
        Colors.white,
        _context,
      ),
    );
  }
}
