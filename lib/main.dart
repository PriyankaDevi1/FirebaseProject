import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'Screens/HomeScreen/login.dart';
import 'Screens/signin_provider.dart';


Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SignInProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  late SignInProvider signInProvider;

  @override
  Widget build(BuildContext context) {
    signInProvider = context.watch<SignInProvider>();
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            else if(snapshot.hasData){
              return Login();
            }
            else if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong"),
              );
            } else {
              return SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: FlutterLogo(
                              size: 200,
                            )),
                        SizedBox(
                          height: 100,
                        ),
                        Text(
                          "Hey There,\n"
                              "Welcome Back",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Login to your account to continue:",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                        SizedBox(
                          height: 70,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: SizedBox(
                            width: 300,
                            height: 50,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                signInProvider =
                                    Provider.of(context, listen: false);
                                signInProvider.googleLogin();
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.red,
                              ),
                              label: Text(
                                "Sign Up With Google",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 23),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
