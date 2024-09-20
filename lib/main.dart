import 'package:flutter/material.dart';
import 'package:onlineshopnina/addproduct.dart';
import 'package:onlineshopnina/allproductlist.dart';
import 'package:onlineshopnina/homepage.dart';
import 'package:onlineshopnina/productdetail.dart';
import 'package:onlineshopnina/productitem.dart';
import 'package:onlineshopnina/spalshscreen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        iconTheme:const  IconThemeData(color: Colors.white ),
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

