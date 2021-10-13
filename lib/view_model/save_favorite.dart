import 'package:starwars/constants/enum.dart';
import 'package:starwars/data/apis/api_service.dart';
import 'package:starwars/helpers/database_helper.dart';
import 'package:starwars/view_model/people_provider..dart';

class SaveToFavorite extends PeopleProvider {
  SaveToFavorite() : super(databaseHelper: DatabaseHelper());

  ResultState _state = ResultState.Loading;
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  Future<void> initialSave() async {
    _state = ResultState.Loading;
    ApiService().fetchPeoples().then((peoples) {
      // print(peoples.results);
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
    });
  }
}
