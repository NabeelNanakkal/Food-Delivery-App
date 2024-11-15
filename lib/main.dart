import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/admin/add_food.dart';
import 'package:food_app/admin/admin_home.dart';
import 'package:food_app/admin/admin_login.dart';
import 'package:food_app/screens/home.dart';
import 'package:food_app/screens/login.dart';
import 'package:food_app/screens/onboard.dart';
import 'package:food_app/screens/product_details.dart';
import 'package:food_app/services/shared_pref.dart';
import 'package:food_app/widget/app_constants.dart';
import 'package:food_app/widget/bottom_nav.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; // Supabase import
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Stripe
  Stripe.publishableKey = apiPublishableKey;

  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Supabase
  await Supabase.initialize(
    url:
        'https://wivotzeveidgrhybtcbx.supabase.co', // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Indpdm90emV2ZWlkZ3JoeWJ0Y2J4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzE1NDAzNTUsImV4cCI6MjA0NzExNjM1NX0.W8mrJ8djyGiiOdnhfamyDf2jyoPh4pAkEqAzwkU-WME', // Replace with your Supabase anon key
  );

  runApp(const MyApp());
}

// Reference to Supabase client
final supabase = Supabase.instance.client;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? id;
  getTheSharedPref() async {
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onLoad() async {
   await getTheSharedPref();
  }

  @override
  void initState() {
    onLoad();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Food Delivery App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: id == null ?Onboard() : Login(), // Set your initial screen
    );
  }
}
