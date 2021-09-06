import 'package:flutter/material.dart';
import 'package:sub2/data/model/restaurant.dart';
import 'package:sub2/data/model/restaurant_search.dart';
import 'package:sub2/ui/home.dart';
import 'package:sub2/ui/restaurant_detail.dart';
import 'package:sub2/ui/search/restaurant_detail_search_page.dart';
import 'ui/search/resto_search.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Resto App Jaya',
      initialRoute: Home.routeName,
      routes: {
        Home.routeName: (context) => Home(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
        RestaurantSearchPage.routeName: (context) => RestaurantSearchPage(
              nameRestaurant:
                  ModalRoute.of(context)?.settings.arguments as String,
            ),
              RestaurantDetailSearchPage.routeName: (context) =>
            RestaurantDetailSearchPage(
              restaurant: ModalRoute.of(context)?.settings.arguments as RestaurantSearch,

            ),
      },
    );
  }
}
