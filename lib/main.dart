import 'package:flutter/material.dart';
import 'package:resmobile/models/categories_model.dart';
import 'package:resmobile/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MekDhea',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
          categoriesModel: CategoriesModel()), // Pass your actual data here
    );
  }
}
