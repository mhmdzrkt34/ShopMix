import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shopmixadmin/Controllers/ADDCategoryFormController.dart';
import 'package:shopmixadmin/components/App_Bar.dart';
import 'package:shopmixadmin/components/FormFielComonent.dart';
import 'package:shopmixadmin/components/Side_Bar.dart';
import 'package:shopmixadmin/components/buttonComponent/button_component.dart';
import 'package:shopmixadmin/components/logo/logo.dart';
import 'package:provider/provider.dart';
import 'package:shopmixadmin/image_provider/product_image_provider.dart';
import 'package:shopmixadmin/model_views/category_model_view.dart';
import 'package:shopmixadmin/models/category.dart';

class addCategory extends StatelessWidget {
  late double _deviceHight;
  late double _deviceWidth;

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    _deviceHight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<CategoryModelView>(),
        ),
        ChangeNotifierProvider.value(
          value: GetIt.instance.get<ProductImageProvider>(),
        ),
      ],
      child: Scaffold(
        appBar: AdminAppBar(_deviceHight, _deviceWidth, "ADD Category"),
        drawer: SideBar(context),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _maincolumn(),
          ),
        ),
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
          key: GetIt.instance<ADDCategoryFormController>().keyaddcategory,
          child: Column(
            children: _FormFields(),
          )),
    );
  }

  List<Widget> _FormFields() {
    return [
      _categoryttitle(),
      _category(),
      _submitbuttom(),
    ];
  }

  Widget _categoryttitle() {
    return Container(
      width: _deviceWidth,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: FormFieldComponent(
        _titleValidate,
        GetIt.instance<ADDCategoryFormController>().changeTitle,
        "Category Title",
        const Color(0xFFFFFFFF),
        const Color(0xFFFFFFFF),
        false,
        const Icon(Icons.paste_rounded),
      ),
    );
  }

  String? _titleValidate(String? value) {
    if (value == null || value.isEmpty) {
      return 'Title is required';
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
    return Container(
      width: _deviceWidth * 0.85,
      margin: EdgeInsets.only(
          top: _deviceHight * 0.015,
          left: _deviceWidth * 0.05,
          right: _deviceWidth * 0.05),
      child: DropdownSearch<category>(
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
            labelText: "Parent Category",
            hintText: "Enter a parent category",
          ),
          baseStyle: TextStyle(color: Colors.black),
        ),
        onSaved: (value) {
          print(value?.id.toString());

          GetIt.instance<ADDCategoryFormController>()
              .changeparentid(value?.id.toString());
        },
      ),
    );
  }

  Widget _submitbuttom() {
    return Container(
      margin: EdgeInsets.only(top: _deviceHight * 0.05),
      child: buttonComponent(
        [_deviceWidth * 0.6, _deviceHight * 0.05],
        [0, 0, 0, 0],
        [0, 0, 0, 0],
        "ADD",
        GetIt.instance<ADDCategoryFormController>().onTap,
        const Color(0xFFDB3022),
        20,
        Colors.white,
        _context,
      ),
    );
  }
}
