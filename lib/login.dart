import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'constants/enum.dart';
import 'utils/firebase.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ResultState _state = ResultState.NoData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _state == ResultState.Loading
            ? CircularProgressIndicator()
            : Column(
                children: [
                  SignInButton(
                    Buttons.Google,
                    text: 'Lanjutkan dengan Google',
                    onPressed: () async {
                      setState(() => _state = ResultState.Loading);
                      try {
                        await FirebaseUtils().signInWithGoogle().then(
                              (_) => Navigator.pushNamedAndRemoveUntil(
                                context,
                                '/',
                                (route) => false,
                              ),
                            );
                      } on FirebaseAuthException catch (e) {
                        final snackBar = SnackBar(
                          content: Text(e.message ??
                              'Pastikan informasi anda telah benar'),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        setState(() => _state = ResultState.Error);
                      }
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
