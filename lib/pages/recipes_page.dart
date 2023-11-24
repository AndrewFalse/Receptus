import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:receptus/constants/color_constants.dart';
import 'package:receptus/constants/list_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:receptus/recipies/recipies_list.dart';

import '../models/recipe.dart';
import '../widgets/recipe_page.dart';

class RecipePage extends StatefulWidget {
  const RecipePage({Key? key}) : super(key: key);

  @override
  State<RecipePage> createState() => _RecipePageState();
}

class _RecipePageState extends State<RecipePage> {
  int selectedCategory = 0;
  List<Recipe> selectedListOfRecipes = listOfRecipes.where((recipe) => recipe.category == 'Обед').toList();
  late List<Recipe> randomRecipes;

  @override
  initState(){
    super.initState();
    List<int> randomIndices = generateRandomIndices(listOfRecipes.length, 2);
    randomRecipes = randomIndices.map((index) => listOfRecipes[index]).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: GestureDetector(
              onTap: () {},
              child: const Icon(Icons.settings, color: secondaryColor),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.0.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Какое блюдо",
                    style: TextStyle(
                        fontFamily: 'RightGrotesk',
                        fontSize: 28.h,
                        fontWeight: FontWeight.w600)),
                Text("приготовишь сегодня?",
                    style: TextStyle(
                        fontFamily: 'RightGrotesk',
                        fontSize: 28.h,
                        fontWeight: FontWeight.w600)),
                StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Column(
                    children: [
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: categoriesList.length,
                          itemBuilder: (context, index) => categoryBlock(index),
                        ),
                      ),
                      SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: selectedListOfRecipes.length,
                          itemBuilder: (context, index) =>
                              recommendedRecipeBlock(selectedListOfRecipes[index]),
                        ),
                      ),
                    ],
                  );
                }),
                Text("Популярные",
                    style: TextStyle(
                        fontFamily: 'RightGrotesk',
                        fontSize: 24.h,
                        fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 180,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: randomRecipes.length,
                    itemBuilder: (context, index) =>
                        popularRecipeBlock(randomRecipes[index]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget categoryBlock(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: GestureDetector(
        onTap: () {
          selectedListOfRecipes = listOfRecipes.where((recipe) => recipe.category == categoriesList[index]).toList();
          setState(() {
            selectedCategory = index;
          });
        },
        child: Container(
          width: 100,
          margin: const EdgeInsets.only(right: 6.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: selectedCategory != index
                ? primaryColor.withOpacity(0.8)
                : primaryColor,
            boxShadow: selectedCategory != index
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 2,
                      offset: Offset(0, 5.h),
                    )
                  ]
                : null,
          ),
          child: Center(
              child: Text(categoriesList[index],
                  style: const TextStyle(
                      fontFamily: 'RightGrotesk',
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.w500))),
        ),
      ),
    );
  }

  Widget recommendedRecipeBlock(Recipe recipe) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: ()=>{Get.to(() => RecipeInfoPage(recipe: recipe))},
          child: Container(
            width: 240,
            margin: const EdgeInsets.only(right: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: primaryColor.withOpacity(0.2), width: 3),
              color: primaryColor.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, 5.h),
                )
              ],
            ),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0)),
                  ),
                  height: 130,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0)),
                    child: Image.asset(
                      recipe.imageLink,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: Row(
                    children: [
                      Text(recipe.name,
                          style: const TextStyle(
                              fontFamily: 'RightGrotesk',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      const Expanded(child: SizedBox()),
                      Column(
                        children: [
                          const Icon(CupertinoIcons.timer, color: Colors.white),
                          Text('${recipe.time} мин',
                              style: const TextStyle(
                                  fontFamily: 'RightGrotesk',
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget popularRecipeBlock(Recipe recipe) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: GestureDetector(
          onTap: ()=>{Get.to(() => RecipeInfoPage(recipe: recipe))},
          child: Container(
            margin: const EdgeInsets.only(right: 6.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: primaryColor.withOpacity(0.2), width: 3),
              color: primaryColor.withOpacity(0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 2,
                  offset: Offset(0, 5.h),
                )
              ],
            ),
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0)),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        topRight: Radius.circular(8.0),
                        topLeft: Radius.circular(8.0)),
                    child: Image.asset(
                      recipe.imageLink,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
                  child: Row(
                    children: [
                      Text(recipe.name,
                          style: const TextStyle(
                              fontFamily: 'RightGrotesk',
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                      const Expanded(child: SizedBox()),
                      Column(
                        children: [
                          const Icon(CupertinoIcons.timer, color: Colors.white),
                          Text('${recipe.time} мин',
                              style: const TextStyle(
                                  fontFamily: 'RightGrotesk',
                                  fontSize: 12,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300))
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  List<int> generateRandomIndices(int maxIndex, int count) {
    List<int> indices = [];
    Random random = Random();

    while (indices.length < count) {
      int index = random.nextInt(maxIndex);
      if (!indices.contains(index)) {
        indices.add(index);
      }
    }

    return indices;
  }
}
