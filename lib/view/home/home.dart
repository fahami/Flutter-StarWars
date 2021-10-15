import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/people.dart';
import 'package:starwars/view/person/person.dart';
import 'package:starwars/view/search.dart';
import 'package:starwars/view_model/people_provider..dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PeopleProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Star Wars'),
        actions: [
          IconButton(
              onPressed: () {
                showSearch(context: context, delegate: Search());
              },
              icon: Icon(Icons.search)),
          IconButton(
              onPressed: () => Navigator.pushNamed(context, '/profile'),
              icon: Icon(
                Icons.person,
                color: Colors.white,
              )),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => getData(context),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                    onPressed: () {
                      provider.changeToList = false;
                    },
                    icon: Icon(Icons.grid_on),
                    label: Text('Grid')),
                ElevatedButton.icon(
                    onPressed: () {
                      provider.changeToList = true;
                    },
                    icon: Icon(Icons.list),
                    label: Text('List')),
                ElevatedButton.icon(
                    onPressed: () {
                      provider.changeAsc = !provider.aToZ;
                    },
                    icon: Icon(Icons.sort_by_alpha),
                    label: Text('Sort')),
              ],
            ),
            Consumer<PeopleProvider>(
              builder: (context, peoples, _) => Expanded(
                child: peoples.isListView
                    ? ListView.builder(
                        itemCount: peoples.results.length,
                        itemBuilder: (context, index) {
                          People data = peoples.results[index];
                          return ListTile(
                            title: Text(data.name!),
                            subtitle: Text(data.height!),
                            trailing: Icon(Icons.person_outline),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PersonScreen(
                                    people: data,
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      )
                    : GridView.builder(
                        itemCount: peoples.results.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 5.0,
                          mainAxisSpacing: 5.0,
                        ),
                        itemBuilder: (context, i) {
                          People data = peoples.results[i];
                          return InkWell(
                            child: Container(
                              color: Colors.blue.withAlpha(50),
                              child: Center(
                                child: Text(data.name!),
                              ),
                            ),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PersonScreen(
                                  people: data,
                                ),
                              ),
                            ),
                          );
                        }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> getData(BuildContext context) async {
  var provider = Provider.of<PeopleProvider>(context, listen: false);
  provider.getFromDB();
}
