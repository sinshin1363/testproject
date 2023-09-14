


import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main()  {
  
  runApp(const MyApp4SanckBar());
}
 class MyApp4SanckBar extends StatelessWidget {
  const MyApp4SanckBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text('check'),),
        body: Container(
          width: Get.width,
          color: Colors.red,

        )
      ),

    );
  }
}