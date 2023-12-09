import 'package:flutter/material.dart';
import 'package:resmobile/models/categories_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoriesModel categoriesModel = CategoriesModel();

    return MaterialApp(
      title: 'Meal Categories',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: HomePage(categoriesModel: categoriesModel),
    );
  }
}

class HomePage extends StatelessWidget {
  final CategoriesModel categoriesModel;

  const HomePage({required this.categoriesModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meal Categories'),
      ),
      body: ListView.builder(
        itemCount: categoriesModel.categories?.length ?? 0,
        itemBuilder: (context, index) {
          final category = categoriesModel.categories![index];
          return ListTile(
            title: Text(category.strCategory ?? ''),
            subtitle: Text(category.strCategoryDescription ?? ''),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(category.strCategoryThumb ?? ''),
            ),
            onTap: () {
              // Handle category tap
            },
          );
        },
      ),
    );
  }
}
