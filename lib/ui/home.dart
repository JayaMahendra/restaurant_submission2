import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sub2/data/api/api_service_restaurant.dart';
import 'package:sub2/provider/restaurant_provider.dart';
import 'package:sub2/ui/search/resto_search.dart';
import 'package:sub2/widgets/card_restaurant.dart';
import 'package:sub2/widgets/platforms_widget.dart';

class Home extends StatefulWidget {
  static const routeName = '/home_page';

  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider<ListProvider>(
        create: (_) => ListProvider(apiService: ApiService()),
        child: DataRestaurant(),
      ),
    );
  }
}

class DataRestaurant extends StatelessWidget {
  TextEditingController searchController = new TextEditingController();
  String nameResto = 'namaRestaurant';
  Widget _buildList() {
    return Consumer<ListProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return Container(
              padding: EdgeInsets.only(top: 60, left: 20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Hello,',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text('What you want eat today?',
                        style: TextStyle(fontSize: 20)),
                    Container(
                       padding: EdgeInsets.only(top: 20, left: 20, right: 40),
                      child: TextField(
                          controller: searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            labelText: 'Find a Restaurant...',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                          nameResto = searchController.text;
                          Navigator.pushNamed(
                            context,
                            RestaurantSearchPage.routeName,
                            arguments: nameResto,
                          );
                        },
                        icon: const Icon(Icons.search)),
                       
                    Expanded(
                      child: Column(
                        children: <Widget>[
                           Container(
                          padding: EdgeInsets.only(top: 20),
                        ),
                          Row(
                            children: [
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                              Expanded(
                                flex: 5,
                                child: SizedBox(
                                  width: 1,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: state.result.restaurants.length,
                                itemBuilder: (context, index) {
                                  var restaurant =
                                      state.result.restaurants[index];
                                  return CardRestaurant(restaurant: restaurant);
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]));
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
