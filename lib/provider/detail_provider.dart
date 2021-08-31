import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sub2/data/api/api_service_detail.dart';
import 'package:sub2/data/model/restaurant_detail.dart';

enum ResultState { Loading, NoData, HasData, Error }

class DetailProvider extends ChangeNotifier {
  final ApiServiceDetail apiServiceDetail;

  DetailProvider({required this.apiServiceDetail}) {
    _fetchDetailRestaurant();
  }

  late Detail _detail;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  Detail get result => _detail;

  ResultState get state => _state;

  Future<dynamic> _fetchDetailRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiServiceDetail.topDetaillines();
      if (restaurant.restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _detail = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message =
          'TERJADI KESALAHAN, SILAHKAN PERIKSA KONEKSI INTERNET ANDA \n\nDetail: \nError --> $e';
    }
  }
}
