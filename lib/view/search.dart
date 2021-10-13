import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/people.dart';
import 'package:starwars/view_model/save_people.dart';

import 'profile/profile.dart';

class Search extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Cari karakter Star Wars';
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () => query = '',
        icon: Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () => Navigator.pop(context),
      icon: Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    var provider = Provider.of<PeopleProvider>(context, listen: false);
    return FutureBuilder(
      future: provider.search(query),
      builder: (context, snapshot) => Consumer<PeopleProvider>(
        builder: (context, val, _) {
          List<People> result = val.searchResults;
          return ListView.builder(
            itemCount: result.length,
            itemBuilder: (context, i) {
              return ListTile(
                title: Text(result[i].name!),
                subtitle: Text(result[i].gender!),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfileScreen(
                      people: result[i],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var provider = Provider.of<PeopleProvider>(context, listen: false);
    List<People> result = provider.searchResults
        .where((people) => people.name!.toLowerCase().contains(query))
        .toList();
    return ListView.builder(
      itemCount: result.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(result[i].name!),
          subtitle: Text(result[i].gender!),
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileScreen(
                people: result[i],
              ),
            ),
          ),
        );
      },
    );
  }
}
