import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:starwars/constants/enum.dart';
import 'package:starwars/data/apis/api_service.dart';
import 'package:starwars/helpers/database_helper.dart';
import 'package:starwars/models/people.dart';

class PeopleProvider extends ChangeNotifier {
  PeopleProvider({required this.databaseHelper}) {
    DatabaseHelper();
    initialSave();
  }
  List<People> _peopleList = [];
  List<People> get results => _peopleList;

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

  bool aToZ = false;

  set changeAsc(bool change) {
    change
        ? _peopleList.sort((a, b) => a.name!.compareTo(b.name!))
        : _peopleList.sort((a, b) => b.name!.compareTo(a.name!));
    aToZ = change ? true : false;
    notifyListeners();
  }

  Future<void> initialSave() async {
    _state = ResultState.Loading;
    databaseHelper.removeDatabase();
    ApiService().fetchPeoples().then(
      (peoples) {
        try {
          peoples.results!.forEach((people) {
            databaseHelper.savePeople(people);
          });
          getFromDB();
        } catch (e) {
          _state = ResultState.Error;
          _message = 'Gagal menyimpan karakter-karakter StarWars';
          notifyListeners();
        }
      },
    );
  }

  Future<void> getFromDB() async {
    _state = ResultState.Loading;
    final peoples = await databaseHelper.getPeoples();
    inspect(peoples);
    if (peoples.length <= 0) {
      _state = ResultState.NoData;
      _message = 'Kamu belum menyimpan satupun karakter StarWars';
    } else {
      _state = ResultState.HasData;
      _peopleList = peoples;
    }
    notifyListeners();
  }

  Future<void> removeDatabase() async {
    _peopleList.clear();
    notifyListeners();
    return databaseHelper.removeDatabase();
  }

  List<People> _searchResult = [];
  List<People> get searchResults => _searchResult;

  Future<void> search(String query) async {
    _state = ResultState.Loading;
    await databaseHelper.searchPeople(query).then((response) {
      print(response);
      if (response.length == 0) {
        _state = ResultState.NoData;
        notifyListeners();
      }
      _searchResult = response;
      _state = ResultState.HasData;
      notifyListeners();
    });
  }

  Future<void> updateProfile(People people, String url) async {
    await databaseHelper.updatePeople(people, url);
    _state = ResultState.HasData;
    getFromDB();
    notifyListeners();
  }

  Future<void> setFavorite(bool favorite, String url) async {
    await databaseHelper.setFavorite(favorite, url);
    _state = ResultState.HasData;
    getFromDB();
    notifyListeners();
  }

  void removePeople(String id) async {
    try {
      await databaseHelper.deletePeople(id);
      _message = 'Data telah dihapus';
      getFromDB();
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
