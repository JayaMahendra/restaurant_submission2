import 'package:flutter/material.dart';
import 'package:sub2/data/model/restaurant.dart';
import 'package:sub2/ui/restaurant_detail.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

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
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                restaurant.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(restaurant.city),
            ],
          ),
          Row(
            children: [
              Text(restaurant.rating.toString()),
            ],
          ),
        ],
      ), 
      onTap: () => Navigator.pushNamed(
        context,
        RestaurantDetail.routeName,
        arguments: restaurant,
      ),
    ));
  }
}
