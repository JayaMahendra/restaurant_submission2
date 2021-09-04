import 'package:flutter/material.dart';
import 'package:sub2/data/model/restaurant_search.dart';
import 'package:sub2/ui/search/restaurant_detail_search_page.dart';

class CardSearch extends StatelessWidget {
  final RestaurantSearch restaurant;

  const CardSearch({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
          tag: restaurant.pictureId,
          child: Image.network(
            'https://restaurant-api.dicoding.dev/images/small/' +
                restaurant.pictureId,
            width: 100,
          ),
        ),
        title: Text(
          restaurant.name,
        ),
        subtitle: Column(
          children: [
            Row(
              children: [
                Text(
                  restaurant.city,
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  restaurant.rating.toString(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ],
            ),
          ],
        ),
        onTap: () => Navigator.pushNamed(
          context,
          RestaurantDetailSearchPage.routeName,
          arguments: restaurant,
        ),
      ),
    );
  }
}
