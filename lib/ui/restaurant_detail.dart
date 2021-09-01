import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub2/data/api/api_service_detail.dart';
import 'package:sub2/data/model/restaurant.dart';
import 'package:sub2/provider/detail_provider.dart';
import 'package:sub2/widgets/platforms_widget.dart';

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

class DetailPage extends StatelessWidget {
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
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                                Text(
                                  restaurantDetail.rating.toString(),
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ],
                            ),
                            Text(
                              restaurantDetail.city,
                              style: TextStyle(fontSize: 15),
                            ),
                            Padding(padding: EdgeInsets.all(10)),
                            Text('Deskripsi: '),
                            Padding(padding: EdgeInsets.all(5)),
                            Text(restaurantDetail.description),
                            Padding(padding: EdgeInsets.all(10)),
                            Text('Menu: '),
                            Padding(padding: EdgeInsets.all(5)),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          restaurantDetail.menus.foods.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Text('- ' +
                                            restaurantDetail
                                                .menus.foods[index].name);
                                      }),
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          restaurantDetail.menus.drinks.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return Text('- ' +
                                            restaurantDetail
                                                .menus.drinks[index].name);
                                      }),
                                ),
                              ],
                            )
                          ]))));
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
}