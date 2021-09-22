import 'package:flutter/material.dart';
import 'package:sub2/data/model/favourite.dart';

class DetailFavorite extends StatelessWidget {
  static const routeName = '/detail_favorite';
  final Favorite favorite;
  const DetailFavorite({Key? key, required this.favorite});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text('Detail Favorite'), backgroundColor: Color(0xFFFF1744)),
        body: SingleChildScrollView(
            child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                          'https://restaurant-api.dicoding.dev/images/medium/' +
                              favorite.urlImage!),
                      Padding(padding: EdgeInsets.all(20)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(favorite.name!,
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold)),
                          Text(
                            favorite.rating.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            favorite.city!,
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(10)),
                      Text('Menu: ',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Padding(padding: EdgeInsets.all(5)),
                      Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: favorite.foods!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text('- ' + favorite.foods!);
                                  }),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: favorite.drinks!.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Text('- ' + favorite.drinks!);
                                  }),
                            ),
                          ]),
                      Column(children: [
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Text(
                          'Customer Review',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                      ])
                    ]))));
  }
}
