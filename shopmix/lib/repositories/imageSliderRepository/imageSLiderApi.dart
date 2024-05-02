import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/models/image_slider_model.dart';
import 'package:shopmix/repositories/imageSliderRepository/IImageSliderRepository.dart';

class ImageSliderApi extends IImageSliderRepository {
  @override
  Future<List<ImageSliderModel>?> getImageSliders() async{

    try {
      return GetIt.instance.get<Seeding>().imageSliders;

    }catch(e){
      print("hey");

      return null;
    }
  
  }


}