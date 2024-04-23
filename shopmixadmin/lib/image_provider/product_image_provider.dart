import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProductImageProvider extends ChangeNotifier {
  List<XFile>? imagefileList = [];

  Future<void> addimages(List<XFile> selectedImages) async {
    imagefileList!.addAll(selectedImages);
    imagefileList = List.from(imagefileList!);
    print(imagefileList!.length.toString() + " images");
    notifyListeners();
  }

  Future<void> deleteimage(XFile selectedImages) async {
    imagefileList!.remove(selectedImages);
    imagefileList = List.from(imagefileList!);
    print(imagefileList!.length.toString() + " images");
    notifyListeners();
  }
}
