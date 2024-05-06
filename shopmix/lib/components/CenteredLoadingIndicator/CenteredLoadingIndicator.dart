import 'package:flutter/material.dart';

class CenteredLoadingIndicator extends StatelessWidget {
  final bool isLoading;

  late double deviceWidth;
  late double deviceHeight;

   CenteredLoadingIndicator({Key? key, this.isLoading = true,required this.deviceWidth,required this.deviceHeight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return 
    Visibility(
      visible: isLoading,
      child: Container(
        width: deviceWidth,
        height: deviceHeight,
        
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [CircularProgressIndicator()],),)
    );
  

  }
}