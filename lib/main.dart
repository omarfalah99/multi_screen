import 'package:flutter/material.dart';
import 'package:multi_screen/Data/dummy_data.dart';
import 'package:multi_screen/Screen/category_meals.dart';
import 'package:multi_screen/Screen/filter_screen.dart';
import 'package:multi_screen/Screen/meal_detail.dart';

import 'Data/meal.dart';
import 'Screen/tabs_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> filter = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> availableMeals = DUMMY_MEALS;

  void setFilter(Map<String, bool> filterData) {
    setState(() {
      filter = filterData;

      availableMeals = DUMMY_MEALS.where((element) {
        if (filter['gluten']! && !element.isGlutenFree) {
          return false;
        }
        if (filter['lactose']! && !element.isLactoseFree) {
          return false;
        }
        if (filter['vegan']! && !element.isVegan) {
          return false;
        }
        if (filter['vegetarian']! && !element.isVegetarian) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Gloria',
        canvasColor: const Color.fromRGBO(255, 254, 229, 1),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
            .copyWith(secondary: Colors.amber),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const TabsScreen(),
        CategoryMealsScreen.routeName: (context) =>
            CategoryMealsScreen(availableMeals),
        MealDetailScreen.MealDetailScreenName: (context) =>
            const MealDetailScreen(),
        FilterScreen.routeName: (context) => FilterScreen(setFilter),
      },
    );
  }
}
