import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:flutter/widgets.dart';
class View_image extends StatelessWidget {
  final String? image;
  List<String>? imageURls;
   View_image({super.key,required this.image,required this.imageURls});

  @override
  Widget build(BuildContext context) {
    print('$image');
    return image == null?
        Scaffold(
          body: Center(
            child: Text('null'),
          ),

        ) :
      Scaffold(
      body: Center(
        child: Image.network(image!),
      ),
    );
  }
}
