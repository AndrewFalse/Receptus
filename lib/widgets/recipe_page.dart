import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:receptus/constants/color_constants.dart';

import '../models/recipe.dart';

class RecipeInfoPage extends StatefulWidget {
  final Recipe recipe;

  const RecipeInfoPage({super.key, required this.recipe});

  @override
  _RecipeInfoPageState createState() => _RecipeInfoPageState();
}

class _RecipeInfoPageState extends State<RecipeInfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Рецепт",
            style: TextStyle(
                fontFamily: 'RightGrotesk',
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w500)),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(widget.recipe.imageLink),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.recipe.name,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Время готовки: ${widget.recipe.time} мин',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Описание: ${widget.recipe.description}',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RatingBar.builder(
                        initialRating: widget.recipe.rating,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemSize: 30.0,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          widget.recipe.rating = rating;
                        },
                      ),
                      IconButton(
                        icon: Icon(
                          widget.recipe.isLiked ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          // Обработка лайка рецепта
                          setState(() {
                            widget.recipe.isLiked = !widget.recipe.isLiked;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: 200,
                height: 40,
                child: GestureDetector(
                  onTap: () => {Navigator.pop(context)},
                  child: Container(
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12)
                    ),
                    child: const Center(
                      child: Text("Вернуться назад",
                          style: TextStyle(
                              fontFamily: 'RightGrotesk',
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}