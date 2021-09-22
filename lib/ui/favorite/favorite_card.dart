import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sub2/data/database/db_helper.dart';
import 'package:sub2/data/model/favourite.dart';
import 'package:sub2/ui/favorite/detail_faovorite.dart';

class FavoriteCard extends StatefulWidget {
  static const String favoriteTitle = 'Favorite List';

  @override
  _FavoriteCardState createState() => _FavoriteCardState();
}

class _FavoriteCardState extends State<FavoriteCard> {
  DbHelper dbHelper = DbHelper();
  late List<Favorite> itemList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) => updateListView());
    return Scaffold(
        appBar: AppBar(
          title: Text(FavoriteCard.favoriteTitle),backgroundColor: Color(0xFFFF1744)
        ),
        body: ListView.builder(
            itemCount: count,
            itemBuilder: (BuildContext context, int index) {
              final favorite = itemList[index];
              return Material(
                  child: ListTile(
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                leading: Hero(
                  tag: favorite.urlImage!,
                  child: Image.network(
                    'https://restaurant-api.dicoding.dev/images/small/' +
                        favorite.urlImage!,
                    width: 100,
                  ),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          favorite.name!,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(favorite.city!),
                      ],
                    ),
                    Row(
                      children: [
                        Text(favorite.rating.toString()),
                      ],
                    ),
                  ],
                ),
                onTap: () => Navigator.pushNamed(
                  context,
                  DetailFavorite.routeName,
                  arguments: favorite,
                ),
              ));
            }));
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
