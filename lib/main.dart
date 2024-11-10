import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:food_app/screens/home.dart';
// import 'package:food_app/screens/login.dart';
import 'package:food_app/screens/onboard.dart';
import 'package:food_app/widget/app_constants.dart';
import 'firebase_options.dart';
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = apiPublishableKey;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);  // Initializes Firebase
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      theme: ThemeData( 
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Onboard(),
    );
  }
}
