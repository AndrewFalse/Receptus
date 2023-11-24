import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:receptus/recipies/recipies_list.dart';

import '../constants/color_constants.dart';
import '../constants/list_constants.dart';
import '../models/recipe.dart';

class CreateRecipePage extends StatefulWidget {
  @override
  _CreateRecipePageState createState() => _CreateRecipePageState();
}

class _CreateRecipePageState extends State<CreateRecipePage> {
  final Recipe newRecipe = Recipe();
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> _getImage() async {
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        final File image = File(pickedFile.path);
        final String imagePath = 'assets/images/recipe_photos/${DateTime.now().millisecondsSinceEpoch}.jpg';
        File(imagePath).writeAsBytesSync(image.readAsBytesSync());

        newRecipe.setImage = imagePath;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Добавление рецепта",
                  style: TextStyle(
                      fontFamily: 'RightGrotesk',
                      fontSize: 28,
                      fontWeight: FontWeight.w600)),
              // Название
              TextFormField(
                decoration: InputDecoration(labelText: 'Название рецепта'),
                onChanged: (value) {
                  newRecipe.name = value;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                decoration: InputDecoration(labelText: 'Описание'),
                onChanged: (value) {
                  newRecipe.description = value;
                },
              ),
              SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: newRecipe.category,
                items: categoriesList
                    .map((category) => DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    newRecipe.category = value!;
                  });
                },
                decoration: InputDecoration(labelText: 'Категория'),
              ),
              SizedBox(height: 16),

              // Время приготовления
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Время приготовления (в минутах)'),
                onChanged: (value) {
                  newRecipe.time = value;
                },
              ),
              SizedBox(height: 16),

              // Пошаговое приготовление
              TextFormField(
                maxLines: null, // Многократные строки
                decoration: InputDecoration(labelText: 'Пошаговое приготовление'),
                onChanged: (value) {
                  newRecipe.stepsDescription = value;
                },
              ),
              SizedBox(height: 16),

              // Загрузка фотографии
              ElevatedButton(
                onPressed: _getImage,
                child: Text('Загрузить фотографию'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
              ),
              SizedBox(height: 16),

              // Отображение выбранной фотографии
              if (newRecipe.imageLink != null)
                Image.asset(
                  newRecipe.imageLink,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              SizedBox(height: 16),

              // Кнопка для создания рецепта
              ElevatedButton(
                onPressed: () {
                  listOfRecipes.add(newRecipe);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
                child: Text('Создать рецепт'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}