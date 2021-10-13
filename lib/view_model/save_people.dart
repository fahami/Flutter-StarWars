import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:starwars/constants/enum.dart';
import 'package:starwars/data/apis/api_service.dart';
import 'package:starwars/helpers/database_helper.dart';
import 'package:starwars/models/people.dart';

class PeopleProvider extends ChangeNotifier {
  PeopleProvider({required this.databaseHelper}) {
    DatabaseHelper();
    initialPeoples();
  }
  List<People> _peopleList = [];
  List<People> get results => _peopleList;

  List<People> _searchResult = [];
  List<People> get searchResults => _searchResult;

  bool isListView = true;

  final DatabaseHelper databaseHelper;

  ResultState _state = ResultState.Loading;
  ResultState get state => _state;

  late bool _isFavorite;
  bool get isFavorite => _isFavorite;

  String _message = '';
  String get message => _message;

  set changeToList(bool grid) {
    isListView = grid;
    print('isListview menjadi $grid');
    notifyListeners();
  }

  Future<void> initialPeoples() async {
    _state = ResultState.Loading;
    ApiService().fetchPeoples().then((peoples) {
      // print(peoples.results);
      try {
        peoples.results!.forEach((people) {
          databaseHelper.savePeople(people);
        });

        getAllPeoples();
      } catch (e) {
        _state = ResultState.Error;
        _message = 'Gagal menyimpan karakter-karakter StarWars';
        notifyListeners();
      }
    });
  }

  Future<void> removeDatabase() async {
    _peopleList.clear();
    notifyListeners();
    return databaseHelper.removeDatabase();
  }

  Future<void> search(String query) async {
    if (_peopleList.length > 0) {
      var result = _peopleList
          .where((people) => people.name!.toLowerCase().contains(query))
          .toList();
      if (result.length == 0) {
        _state = ResultState.NoData;
      }
      _searchResult = result;
      _state = ResultState.HasData;
      notifyListeners();
    }
    _state = ResultState.Error;
    notifyListeners();
  }

  void getAllPeoples() async {
    final peoples = await databaseHelper.getPeoples();
    if (peoples.length <= 0) {
      _state = ResultState.NoData;
      _message = 'Kamu belum menyimpan satupun karakter StarWars';
    } else {
      inspect(peoples);
      _state = ResultState.HasData;
      _peopleList = peoples;
    }
    notifyListeners();
  }

  void removePeople(String id) async {
    try {
      await databaseHelper.deletePeople(id);
      _message = 'Data telah dihapus';
      getAllPeoples();
    } catch (e) {
      _state = ResultState.Error;
      _message = 'Gagal untuk menghapus karakter';
      notifyListeners();
    }
  }

  Future<bool?> checkPeople(String id) async {
    final favorite = await databaseHelper.isExist(id);
    return favorite;
  }
}
