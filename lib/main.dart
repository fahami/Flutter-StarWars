import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starwars/helpers/database_helper.dart';
import 'package:starwars/login.dart';
import 'package:starwars/view/favorite/favorite.dart';
import 'package:starwars/view/home/home.dart';
import 'package:starwars/view/profile/profile.dart';

import 'view_model/people_provider..dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String initialRoute = '/';
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initialRoute = user != null ? '/' : '/login';
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => PeopleProvider(
            databaseHelper: DatabaseHelper(),
          ),
        )
      ],
      child: MaterialApp(
        theme: ThemeData.light(),
        title: "SWAPI",
        initialRoute: initialRoute,
        routes: {
          '/': (_) => HomeScreen(),
          '/profile': (_) => ProfileScreen(),
          '/favorite': (_) => FavoriteScreen(),
          '/login': (_) => LoginScreen(),
        },
      ),
    );
  }
}
