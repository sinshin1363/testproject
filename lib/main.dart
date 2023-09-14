import 'package:calc_application/homescreen.dart';
import 'package:calc_application/models/money.dart';
import 'package:calc_application/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter(); 
  Hive.registerAdapter(MoneyAdapter());
  await Hive.openBox<Money>('Moneybox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
static void getdata() {
  HomeScreen.moneis.clear();
  Box<Money> hiveBox = Hive.box<Money>('moneyBox');
  for (var value in hiveBox.values) { 
    HomeScreen.moneis.add(value);
  }
}
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'اپلیکیشن مدیریت مالی', 
        home: MainScreen(
          
        ),
    );
  }
}
