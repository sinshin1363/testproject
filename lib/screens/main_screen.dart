import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:calc_application/homescreen.dart';
import 'package:calc_application/info_screen.dart';
import 'package:flutter/material.dart';
// ignore: camel_case_types
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _mainscrenState();
}

// ignore: camel_case_types
class _mainscrenState extends State<MainScreen> {
  int currentindex =0;
  Widget body = HomeScreen();


  @override
  Widget build(BuildContext context) {
        
 
    return Scaffold(
  

      backgroundColor: const Color.fromARGB(255, 248, 204, 244),
   bottomNavigationBar: AnimatedBottomNavigationBar(
    inactiveColor: Colors.black54,

      icons:const [Icons.home, Icons.info],
      activeIndex: currentindex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.smoothEdge,
      onTap: (index) {

        if (index == 0) {
        body = HomeScreen();

        }else {
          body = const InfoScreen();

        }
        setState(() {
          currentindex = index;
        });
        

      },
      //other params
   ),
    body: body,
);

  }
}