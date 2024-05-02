import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';


class MapView extends StatelessWidget{

    late double _deviceHeigt;
    late double _deviceTopPadding;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build


    _deviceTopPadding=MediaQuery.of(context).padding.top;
    _deviceHeigt=MediaQuery.of(context).size.height;



    return Scaffold(

      body: SafeArea(child: Column(children: [

           Container(
            height: _deviceHeigt-_deviceTopPadding,
            
             child: FlutterMap(
                 options: MapOptions(
                  
                   initialCenter: LatLng(51.509364, -0.128928),
                   initialZoom: 9.2,
                 ),
                 children: [
                   TileLayer(
                     urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                     userAgentPackageName: 'com.example.app',
                   ),
                   MarkerLayer(markers: [Marker(
                    child: Icon(Icons.arrow_drop_down,
                          color: Colors.blue,
                          size: 100,),

                    width: 40,
                    height: 40,
                    point:LatLng(51.509364, -0.128928) ,
                   ),]),
                   RichAttributionWidget(
                     attributions: [
                       TextSourceAttribution(
              'OpenStreetMap contributors',
              onTap: (){
                
              },
              
                       ),
                     ],
                   ),
                 ],
               ),
           )
      ],),)
    );

  }

}