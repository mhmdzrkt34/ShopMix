import 'package:get_it/get_it.dart';
import 'package:shopmix/Seeding/seeding.dart';
import 'package:shopmix/models/order_model.dart';
import 'package:shopmix/repositories/orderRepository/IOrderRepository.dart';

class OrderApi extends IOrderRepository {
  @override
  Future<List<OrderModel>> getorders() async{

    //return GetIt.instance.get<Seeding>().orders;

    return [];

  }


}