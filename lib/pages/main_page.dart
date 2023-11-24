import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:receptus/pages/recipes_page.dart';
import 'package:receptus/pages/saved_page.dart';
import 'package:receptus/pages/search_page.dart';

import '../constants/color_constants.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  var padding = const EdgeInsets.symmetric(horizontal: 18, vertical: 5);
  double gap = 8;
  int _selectedIndex = 0;

  void _navigationBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget setPage(int index) {
    if (index == 0) return const RecipePage();
    if (index == 1) return const RecipeSearchPage();
    if (index == 2) return const SavedRecipesPage();
    return const Text("Error");
  }

  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: setPage(_selectedIndex),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: bottomNavigationBar(),
      ),
    );
  }

  Widget bottomNavigationBar() {
    return BottomAppBar(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        bottomNavigationIcon(
            CupertinoIcons.house, CupertinoIcons.house_fill, 0),
        bottomNavigationIcon(CupertinoIcons.book, CupertinoIcons.book_fill, 1),
        bottomNavigationIcon(
            CupertinoIcons.bookmark, CupertinoIcons.bookmark_fill, 2)
      ],
    ));
  }

  Widget bottomNavigationIcon(
      IconData disableIcon, IconData enableIcon, int pageIndex) {
    double iconSize = 23;
    IconData icon = _selectedIndex == pageIndex ? enableIcon : disableIcon;
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: GestureDetector(
            onTap: () {
              _navigationBottomBar(pageIndex);
            },
            onTapDown: (TapDownDetails details) {
              iconSize = 21.5;
              icon = enableIcon;
              setState(() {});
            },
            onTapCancel: () {
              iconSize = 23;
              icon = disableIcon;
              setState(() {});
            },
            child: Icon(icon, color: primaryColor, size: iconSize)
        )
      );
    });
  }
}
