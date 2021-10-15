import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({Key? key}) : super(key: key);
  final User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Profil'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.amber,
                  backgroundImage: NetworkImage(user!.photoURL!),
                  minRadius: 50,
                ),
                Expanded(
                  child: Column(
                    children: [Text(user!.displayName!), Text(user!.email!)],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
