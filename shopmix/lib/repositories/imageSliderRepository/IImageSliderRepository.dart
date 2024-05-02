import 'package:shopmix/models/image_slider_model.dart';

abstract class IImageSliderRepository {


  Future<List <ImageSliderModel>?>  getImageSliders();

}