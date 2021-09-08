import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:foofapp/HomePage.dart';
import 'package:foofapp/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:foofapp/login.dart';
import 'package:foofapp/signin.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  // Create the initialization Future outside of `build`:
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  /// The future is part of the state of our widget. We should not call `initializeApp`
  /// directly inside [build].
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return Text("Error");
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    // This is the theme of your application.
                    //
                    // Try running your application with "flutter run". You'll see the
                    // application has a blue toolbar. Then, without quitting the app, try
                    // changing the primarySwatch below to Colors.green and then invoke
                    // "hot reload" (press "r" in the console where you ran "flutter run",
                    // or simply save your changes to "hot reload" in a Flutter IDE).
                    // Notice that the counter didn't reset back to zero; the application
                    // is not restarted.
                    primarySwatch: Colors.blue,
                  ),
                  home: AnimatedSplashScreen(splash: Image(image: AssetImage("images/kitchenlogo.jpg"),),
                  splashTransition: SplashTransition.rotationTransition,
                  splashIconSize: 250,
                  duration: 800,
                  curve: Curves.easeInOutBack,
                  nextScreen: Home())
          );
        }
        // Otherwise, show something whilst waiting for initialization to complete
        return Text("Error");
      },
    );
  }
}
