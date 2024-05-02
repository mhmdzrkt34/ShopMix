import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shopmix/components/appBarComponent/app_bar_component.dart';
import 'package:shopmix/designs/colors_design.dart';
import 'package:shopmix/modelViews/locations_model_view.dart';

import 'package:shopmix/modelViews/profile_model_view.dart';
import 'package:shopmix/models/location_model.dart';
import 'package:shopmix/providers/dark_mode_provider.dart';
import 'package:shopmix/views/location_map_view.dart';


class LocationsView extends StatelessWidget {
  late double _deviceWidth;

  late double _deviceHeight;
  late BuildContext _context;

  
  @override
  Widget build(BuildContext context) {
    _deviceWidth=MediaQuery.of(context).size.width;
    _deviceHeight=MediaQuery.of(context).size.height;
    _context=context;

    return MultiProvider(providers: [
      ChangeNotifierProvider.value(value: GetIt.instance.get<LocationsModelView>()),
      ChangeNotifierProvider.value(value: GetIt.instance.get<darkModeProvider>()),
      

    ],
    child: ScaffoldSelector()
    );

  }

          Selector<darkModeProvider,bool> ScaffoldSelector(){
    return Selector<darkModeProvider,bool>(selector: (context,provider)=>provider.isDark,
    shouldRebuild: (previous,next)=>!identical(previous,next),
    builder: (context, value, child){

      return Scaffold(

      backgroundColor:value?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
      body: SingleChildScrollView(child: Column(children: [LocationsWidgetSelector(),AddLocationButton()],),),
      appBar: AppBarComponent(height: _deviceHeight*0.1,backtickenabled: true,actionsColors: GetIt.instance.get<ColorsDesign>().light[1],backgroundColor:GetIt.instance.get<ColorsDesign>().light[0] ,deviceWidth: _deviceWidth,threeTapEnable: false,searchVisible: false,filter: Filter,),
    );
      



    }
    );
}




Widget AddLocationButton(){
  return       Container(
        margin: EdgeInsets.all(20),
   
    width: _deviceWidth,
     
  
  child: MaterialButton(
    color: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[2]:GetIt.instance.get<ColorsDesign>().light[2],
    textColor: GetIt.instance.get<ColorsDesign>().isDark?GetIt.instance.get<ColorsDesign>().dark[0]:GetIt.instance.get<ColorsDesign>().light[0],
    
    
    
    onPressed: (){
      //Navigator.pushNamed(currentcontext, "/orderMethodView");
      Navigator.pushNamed(_context, "/locationSelectionView");




    },
  child: Text("Add Location"),),) ;
}

Selector<LocationsModelView,List<LocationModel>> LocationsWidgetSelector(){


  return  Selector<LocationsModelView,List<LocationModel>>(selector: (context,provider)=>provider.locations,
  
  shouldRebuild: (previous,next)=>!identical(previous, next),

  builder: (context,value,child){
    return LocationsWidget(value);

  



  },
  );
}

Widget LocationsWidget(List<LocationModel> locations){

  if(locations.length==0){

    return Center(child: Text("T here isNo locations"),);
  }

  return Column(children: locations.map<Widget>((e){
    return LocationComponent(e);


  }).toList(),);
  
}


Widget LocationComponent(LocationModel location){


   return Container(
      margin: EdgeInsets.all(20),
      width:_deviceWidth, // Use full device width
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
        GestureDetector(
          onTap: (){
                      Navigator.push(
            _context,
            MaterialPageRoute(
              builder: (context) => LocationMapView(location: location),
            ),
          );
          },
          child:   Row(
            children: [
              Icon(Icons.location_on),
              SizedBox(width: 8.0), // Add spacing between icon and text
              Text(
                '${location.latitude.toStringAsFixed(2)} ${location.langitude.toStringAsFixed(2)}',
                style: TextStyle( // Add styling if desired
                  fontSize: 16.0,
                ),
              ),
            ],
          ),),
          PopupMenuButton<String>(
            onSelected: (value) {
              if (value == 'set_default') {
                // Handle setting location as default
                location.defaultLocation = true;
              } else if (value == 'remove_default') {
                // Handle removing default location
                location.defaultLocation = false;
              } else if (value == 'remove_location') {
                // Call the callback function to remove the location
              
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: location.defaultLocation ? 'remove_default' : 'set_default',
                child: GestureDetector(
                  onTap: (){
                    GetIt.instance.get<LocationsModelView>().changeDefault(location.id);
                       Navigator.pop(context);

                  },
                  child: Row(
                  children: [
                    Icon(
                      location.defaultLocation ? Icons.remove_circle : Icons.add_circle,
                      color: location.defaultLocation ? Colors.red : Colors.green,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      location.defaultLocation ? 'Remove Default' : 'Set Default',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),)
              ),
              PopupMenuItem(
                value: 'remove_location',
                child: GestureDetector(
                  onTap: (){


                    GetIt.instance.get<LocationsModelView>().removeLocation(location.id);
                    Navigator.pop(context);
                  },
                  child: Row(
                  children: [
                    Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    SizedBox(width: 8.0),
                    Text(
                      'Remove Location',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ],
                ),),
              ),
            ],
          ),
        ],
      ),
    );
}
void Filter(String value){

  print(value);
}

  
}