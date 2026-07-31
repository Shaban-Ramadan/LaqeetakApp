import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:laqeetak/feature/view/auth/sign_in.dart';
import 'package:laqeetak/feature/view/home/home_view.dart';

class AuthGate extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {

        // لسه بيحمّل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // مفيش يوزر → Login
        if (!snapshot.hasData) {
          return SignInView();
        }

        // فيه يوزر → Home
        return HomeView();
      },
    );
  }
}
