import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../signin_provider.dart';

class Login extends StatelessWidget {
  late SignInProvider signInProvider;

  @override
  Widget build(BuildContext context) {
    signInProvider = context.watch<SignInProvider>();
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Log In"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              signInProvider=Provider.of<SignInProvider>(context,listen: false);
              signInProvider.logout();
            },
            child: const Text("Logout",style: TextStyle(color: Colors.blue),),
          ),
        ],
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            const Text(
              "Profile",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            const SizedBox(height: 10),
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.photoURL!),
            ),
            const SizedBox(height: 10),
            Text(
              "Name:${user.displayName!}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
            Text(
              "Email:${user.email!}",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
