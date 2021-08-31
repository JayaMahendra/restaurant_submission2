import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sub2/data/api/api_service_restaurant.dart';
import 'package:sub2/data/model/restaurant.dart';

enum ResultState { Loading, NoData, HasData, Error }

class ListProvider extends ChangeNotifier {
  final ApiService apiService;

  ListProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late Welcome _welcome;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Welcome get result => _welcome;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.topHeadlines();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _welcome = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'TERJADI KESALAHAN, SILAHKAN PERIKSA KONEKSI INTERNET ANDA \n\nDetail: \nError --> $e';
    }
  }
}
