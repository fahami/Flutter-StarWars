import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/models/people.dart';
import 'package:starwars/view/profile/profile.dart';
import 'package:starwars/view/search.dart';
import 'package:starwars/view_model/save_people.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<PeopleProvider>(context, listen: false);
    provider.initialPeoples();
  }

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
          TextButton(
              onPressed: () {
                provider.initialPeoples();
              },
              child: Text(
                'Load',
                style: TextStyle(color: Colors.white),
              )),
          TextButton(
              onPressed: () {
                provider.removeDatabase();
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  onPressed: () {
                    provider.changeToList = true;
                  },
                  child: Text('List View')),
              ElevatedButton(
                  onPressed: () {
                    provider.changeToList = false;
                  },
                  child: Text('Grid View')),
            ],
          ),
          Consumer<PeopleProvider>(
            builder: (context, val, _) => Expanded(
              child: val.isListView
                  ? ListView.builder(
                      itemCount: val.results.length,
                      itemBuilder: (context, index) {
                        People data = val.results[index];
                        return ListTile(
                          title: Text(data.name!),
                          subtitle: Text(data.height!),
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                            radius: 50,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProfileScreen(
                                  people: data,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    )
                  : GridView.builder(
                      itemCount: val.results.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 5.0,
                        mainAxisSpacing: 5.0,
                      ),
                      itemBuilder: (context, i) {
                        People data = val.results[i];
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
                              builder: (context) => ProfileScreen(
                                people: data,
                              ),
                            ),
                          ),
                        );
                      }),
            ),
          )
        ],
      ),
    );
  }
}
