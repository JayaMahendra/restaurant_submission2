import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sub2/data/api/api_service_detail.dart';
import 'package:sub2/data/model/favourite.dart';
import 'package:sub2/data/model/restaurant.dart';
import 'package:sub2/provider/detail_provider.dart';
import 'package:sub2/widgets/platforms_widget.dart';
import 'package:sub2/data/database/db_helper.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/resto_detail';

  final Restaurant restaurant;

  const RestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<DetailProvider>(
        create: (_) => DetailProvider(
            apiServiceDetail: ApiServiceDetail(idDetail: restaurant.id)),
        child: DetailPage(),
      ),
    );
  }
}

class DetailPage extends StatefulWidget {
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int count = 0;

  DbHelper dbHelper = DbHelper();

  late List<Favorite> itemList;

  late final Favorite favorite;

  Widget _buildList() {
    return Consumer<DetailProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          var restaurantDetail = state.result.restaurant;

          return Scaffold(
              appBar: AppBar(
                  title: Text('Detail'), backgroundColor: Color(0xFFFF1744)),
              body: SingleChildScrollView(
                  child: Container(
                padding: EdgeInsets.all(40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(
                        'https://restaurant-api.dicoding.dev/images/medium/' +
                            restaurantDetail.pictureId),
                    Padding(padding: EdgeInsets.all(20)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(restaurantDetail.name,
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        Text(
                          restaurantDetail.rating.toString(),
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          restaurantDetail.city,
                          style: TextStyle(fontSize: 15),
                        ),
                        IconButton(
                          // isSaved ? Icons.favorite : Icons.favorite_border,
                          // color: isSaved ? Colors.red : null,
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                          onPressed: () async {
                            favorite = Favorite(
                              idFavorite: restaurantDetail.id,
                              name: restaurantDetail.name,
                              desc: restaurantDetail.description,
                              urlImage: restaurantDetail.pictureId,
                              city: restaurantDetail.city,
                              rating: restaurantDetail.rating.toString(),
                              foods: restaurantDetail.menus.foods[0].name,
                              drinks: restaurantDetail.menus.drinks[0].name,
                            );
                            int result = await dbHelper.insert(favorite);
                            if (result > 0) {
                              updateListView();
                            }
                          },
                        ),
                      ],
                    ),
                    Text(
                      restaurantDetail.address,
                      style: TextStyle(fontSize: 15),
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    Text('Deskripsi: ',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Padding(padding: EdgeInsets.all(5)),
                    Text(restaurantDetail.description),
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
                                itemCount: restaurantDetail.menus.foods.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text('- ' +
                                      restaurantDetail.menus.foods[index].name);
                                }),
                          ),
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: restaurantDetail.menus.drinks.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Text('- ' +
                                      restaurantDetail
                                          .menus.drinks[index].name);
                                }),
                          ),
                        ]),
                    Column(
                      children: [
                        Padding(padding: EdgeInsets.only(top: 15)),
                        Text(
                          'Customer Review',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Padding(padding: EdgeInsets.all(8)),
                        ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: restaurantDetail.customerReviews.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Name: ' +
                                        restaurantDetail
                                            .customerReviews[index].name,
                                  ),
                                  Text(
                                    'Date: ' +
                                        restaurantDetail
                                            .customerReviews[index].date,
                                  ),
                                  Text(
                                    'Review: ' +
                                        restaurantDetail
                                            .customerReviews[index].review,
                                  ),
                                  const Divider(
                                      thickness: 0.1,
                                      indent: 20,
                                      endIndent: 50,
                                      color: Colors.green),
                                ],
                              );
                            }),
                      ],
                    )
                  ],
                ),
              )));
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _buildList(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Resto App'),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
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
