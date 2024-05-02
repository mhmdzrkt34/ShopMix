
import 'package:shopmix/models/category_model.dart';
import 'package:shopmix/models/chat_model.dart';
import 'package:shopmix/models/image_slider_model.dart';
import 'package:shopmix/models/location_model.dart';
import 'package:shopmix/models/order_items_model.dart';
import 'package:shopmix/models/order_model.dart';
import 'package:shopmix/models/product_image_model.dart';
import 'package:shopmix/models/product_model.dart';
import 'package:shopmix/models/user_model.dart';

class Seeding {

   List<ProductModel> products=[];
   List<CategoryModel> categoris=[];
   UserModel userMod=new UserModel(Email: "Izaraket48@gmail.com",Password: "@Newpassword1",Name: "Mohamad Zaraket",country: "lebanon",id: "1234",phoneNumber: "81734145");

   List<OrderModel> orders=[];
   List<ProductImageModel> images=[];


   List<ChatModel> chats=[];

   List<LocationModel> locations=[];
   List<ImageSliderModel> imageSliders=[];

  Seeding(){
    SeedData();
  }




  void SeedData(){


      images.add(new ProductImageModel(Id: "123", product_id: "1", ImageUrl: "https://www.pngall.com/wp-content/uploads/2016/04/Keyboard-Download-PNG.png"));
    images.add(new ProductImageModel(Id: "1234", product_id: "1",  ImageUrl: "https://pluspng.com/img-png/laptop-png-laptop-notebook-png-image-image-6746-1153.png"));
    images.add(new ProductImageModel(Id: "12345", product_id: "1",  ImageUrl: "https://consoletradein.co.uk/wp-content/uploads/2020/07/PlaySTation-5.png"));
    images.add(new ProductImageModel(Id: "123456", product_id: "1",  ImageUrl: "https://www.vrc.co.nz/wp-content/uploads/2022/06/1-2.png"));
    images.add(new ProductImageModel(Id: "123457", product_id: "1", ImageUrl: "https://www.startech.com.bd/image/cache/catalog/graphics-card/gigabyte/rtx-2060-d6/rtx-2060-d6-01-500x500.jpg"));
    images.add(new ProductImageModel(Id: "123458", product_id: "1",  ImageUrl: "https://www.pny.com/productimages/3855184D-3351-463D-A8B3-ABBA00E498E3/images/5-XLR8-Graphics-Cards-GTX-1660-OC-top-2.png"));


    products.add(new ProductModel(id: "1",  isNew: true, salePercentage: 10, title: "keyboard", price: 250,images: images,description: "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",category_id: "7"));

    products.add(new ProductModel(id: "2",  isNew: false, salePercentage: 20, title: "laptop", price: 500,images: images,description: "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",category_id:"8" ));
    
    products.add(new ProductModel(id: "3", isNew: true, salePercentage: 0, title: "ps5", price: 700,images: images,description: "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",category_id: "22"));

    products.add(new ProductModel(id: "4",isNew: true, salePercentage: 0, title: "rtx 3070", price: 1300,images: images,description: "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",category_id: "22"));
     products.add(new ProductModel(id: "5",isNew: true, salePercentage: 0, title: "rtx 2060", price: 1300,images: images,description: "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",category_id: "22"));
     products.add(new ProductModel(id: "5", isNew: true, salePercentage: 0, title: "gtx 1660", price: 1500,images: images,description: "adssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssssss",category_id: "22"));

    categoris.add(CategoryModel(Id: "1",name: "Accessories",categories:[CategoryModel(Id: "7", name: "keyboards", categories: [CategoryModel(Id: "13", name: "scorpion", categories: [])]),CategoryModel(Id: "19", name: "Headsets", categories: [])] ));
    categoris.add(CategoryModel(Id: "2",name: "laptops",categories:[CategoryModel(Id: "8", name: "laptops", categories: [CategoryModel(Id: "14", name: "lenova", categories: [])]),CategoryModel(Id: "20", name: "legion", categories: [])] ));
    categoris.add(CategoryModel(Id: "3",name: "pc and parts",categories:[CategoryModel(Id: "9", name: "rams", categories: [CategoryModel(Id: "15", name: "cpu", categories: [])]),CategoryModel(Id: "21", name: "monitors", categories: []),CategoryModel(Id: "22", name: "GPUS", categories: [])] ));

    categoris[0].toggleVisibility();
    categoris[1].toggleVisibility();
    categoris[2].toggleVisibility();

   orders.add(new OrderModel(id: "1", user_id: "1", quantity: 4, totalprice: 1950));

   orders.add(new OrderModel(id: "2", user_id: "1", quantity: 4, totalprice: 1950));

   orders[0].items.add(OrderItems(id: "2", product_id: "1", quantity: 2, product: products[0], name: "keyboard"));
   orders[0].items.add(OrderItems(id: "3", product_id: "2", quantity: 1, product: products[1], name: "laptop"));
   orders[0].items.add(OrderItems(id: "4", product_id: "3", quantity: 1,product: products[2], name: "ps5"));

      orders[1].items.add(OrderItems(id: "5", product_id: "1", quantity: 2, product: products[0], name: "keyboard"));
   orders[1].items.add(OrderItems(id: "6", product_id: "2", quantity: 1, product: products[1], name: "laptop"));
   orders[1].items.add(OrderItems(id: "7", product_id: "3", quantity: 1,product: products[2], name: "ps5"));

   
   chats.add(new ChatModel(id: "1", user: userMod, type: "sender", message: "hey", date: DateTime.now()));

   chats.add(new ChatModel(id: "2", user: userMod, type: "sender", message: "how are you", date: DateTime.now()));

   chats.add(new ChatModel(id: "3", user: userMod, type: "reciever", message: "plz help me", date: DateTime.now()));

  
   chats.add(new ChatModel(id: "4", user: userMod, type: "sender", message: "thank you", date: DateTime.now()));
   chats.add(new ChatModel(id: "5", user: userMod, type: "reciever", message: "fine thank you", date: DateTime.now()));

   imageSliders.add(ImageSliderModel(id: "2", imageUrl: "https://cdn11.bigcommerce.com/s-sp9oc95xrw/images/stencil/1920w/carousel/533/c043__24279.png"));
   imageSliders.add(ImageSliderModel(id: "3", imageUrl: "https://cdn11.bigcommerce.com/s-sp9oc95xrw/images/stencil/1920w/carousel/536/C044.png"));

   



    
  }







}