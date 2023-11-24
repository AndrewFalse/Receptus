import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:receptus/constants/color_constants.dart';
import 'package:receptus/recipies/recipies_list.dart';

import '../models/recipe.dart';
import '../widgets/recipe_page.dart';

class RecipeSearchPage extends StatefulWidget {
  const RecipeSearchPage({super.key});

  @override
  _RecipeSearchPageState createState() => _RecipeSearchPageState();
}

class _RecipeSearchPageState extends State<RecipeSearchPage> {
  List<Recipe> searchResults = [];
  TextEditingController searchController = TextEditingController();

  void searchRecipes(String query) {
    setState(() {
      searchResults = listOfRecipes
          .where((recipe) => recipe.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Поиск рецептов",
                  style: TextStyle(
                      fontFamily: 'RightGrotesk',
                      fontSize: 28.h,
                      fontWeight: FontWeight.w600)),
              TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  labelText: 'Поиск по названию',
                ),
                style: TextStyle(
                  color: primaryColor,
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  searchRecipes(searchController.text);
                },
                child: Text('Поиск', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                ),
              ),
              SizedBox(height: 16),
              if (searchResults.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: searchResults.length,
                    itemBuilder: (context, index) {
                      return recommendedRecipeBlock(searchResults[index]);
                    },
                  ),
                )
              else
                Text("Нет результатов поиска",
                    style: TextStyle(
                        fontFamily: 'RightGrotesk',
                        fontSize: 18.h,
                        fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
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