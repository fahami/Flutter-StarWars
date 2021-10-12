import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
      body: Column(
        children: [
          Text('Starwars'),
          ElevatedButton(
              onPressed: () {
                provider.initialPeoples();
              },
              child: Text('muat data')),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  title: Text("Fahmi"),
                  subtitle: Text('Gans'),
                  leading: CircleAvatar(
                    backgroundColor: Colors.amber,
                    radius: 50,
                  ),
                  onTap: () {
                    print('object');
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
