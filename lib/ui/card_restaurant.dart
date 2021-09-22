import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sub2/data/database/db_helper.dart';
import 'package:sub2/data/model/favourite.dart';
import 'package:sub2/data/model/restaurant.dart';
import 'package:sub2/ui/restaurant_detail.dart';

class CardRestaurant extends StatefulWidget {
  final Restaurant restaurant;

  const CardRestaurant({required this.restaurant});

  @override
  _CardRestaurantState createState() => _CardRestaurantState();
}

class _CardRestaurantState extends State<CardRestaurant> {
  DbHelper dbHelper = DbHelper();
  int count = 0;
  late List<Favorite> itemList;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => updateListView());
    return Material(
        child: ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: widget.restaurant.pictureId,
        child: Image.network(
          'https://restaurant-api.dicoding.dev/images/small/' +
              widget.restaurant.pictureId,
          width: 100,
        ),
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                widget.restaurant.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          Row(
            children: [
              Text(widget.restaurant.city),
            ],
          ),
          Row(
            children: [
              Text(widget.restaurant.rating.toString()),
            ],
          ),
        ],
      ),
      onTap: () => Navigator.pushNamed(
        context,
        RestaurantDetail.routeName,
        arguments: widget.restaurant,
      ),
    ));
  }

  void updateListView() {
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database) {
      Future<List<Favorite>> itemListFuture = dbHelper.getFavoriteList();
      itemListFuture.then((itemList) {
        setState(() {
          this.itemList = itemList;
          this.count = itemList.length;
        });
      });
    });
  }
}
