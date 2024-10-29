import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/home.dart';
import 'package:food_app/screens/order.dart';
import 'package:food_app/screens/profile.dart';
import 'package:food_app/screens/wallet.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({super.key});

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int currentIndex = 0;
  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen home;
  late OrderScreen order;
  late WalletScreen wallet;
  late ProfileScreen profile;

  @override
  void initState() {
    home = HomeScreen();
    order = OrderScreen();
    wallet = WalletScreen();
    profile = ProfileScreen();
    pages = [home, order, wallet, profile];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65.0,
          backgroundColor: Colors.white,
          color: const Color.fromARGB(255, 244, 133, 54),
          animationDuration: const Duration(milliseconds: 500),
          onTap: (int index) => {
                setState(() {
                  currentIndex = index;
                })
              },
          items: const [
            Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
              size: 30.0,

            ),
            Icon(
              Icons.wallet_outlined,
              color: Colors.white,
              size: 30.0,
            ),
            Icon(
              Icons.person_outlined,
              color: Colors.white,
              size: 30.0,
            ),
          ]),
          body: pages[currentIndex],
    );
  }
}
