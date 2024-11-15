import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/screens/product_details.dart';
import 'package:food_app/services/service.dart';
import 'package:food_app/widget/widget_support.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final List<Map<String, String>> imagePath = [
  {'name': 'Pizza', 'path': 'assets/images/pizza.png'},
  {'name': 'Burger', 'path': 'assets/images/burger.png'},
  {'name': 'Ice Cream', 'path': 'assets/images/ice-cream.png'},
  {'name': 'Salad', 'path': 'assets/images/salad.png'},
];

final List<Map<String, String>> specialFoodItems = [
  {'name': 'Salad2', 'path': 'assets/images/salad2.png', 'price': '25'},
  {'name': 'Salad3', 'path': 'assets/images/salad3.png', 'price': '29'},
  {'name': 'Salad4', 'path': 'assets/images/salad4.png', 'price': '32'},
];

String selectedCategory = 'Pizza';

class _HomeScreenState extends State<HomeScreen> {
  Stream? productItemStream;

  ontheload() async {
    productItemStream = await DatabaseMethods().getProductItem('Pizza');
    setState(() {});
  }

  @override
  void initState() {
    ontheload();
    super.initState();
  }

  Widget allItemsHorizonatal() {
    return StreamBuilder(
      stream: productItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ProductDetails(image: ds['image'],details: ds['details'],name: ds['name'],price: ds['price'],);
                    },
                  ));
                },
                child: SingleChildScrollView(
                  child: Container(
                    margin: const EdgeInsets.only(
                        left: 5.0, bottom: 10.0, top: 10.0, right: 5.0),
                    child: Material(
                      elevation: 8.0,
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8.0),
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15.0),
                              child: Image.network(
                                ds['image'], // Using the image path from `food`
                                height: 150.0,
                                width: 150.0,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Text(
                              ds['name'] ?? 'Food Name',
                              style: AppWidget.semiBoldTextStyle(),
                            ),
                            const SizedBox(height: 2.0),
                            Text(
                              ds['details'] ?? 'Description',
                              style: AppWidget.lightTextStyle(),
                            ),
                            const SizedBox(height: 2.5),
                            Text(
                              '\$${ds['price'] ?? 'Price'}',
                              style: AppWidget.semiBoldTextStyle(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          // Provide sample data if snapshot has no data
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget allItemsVertical() {
    return StreamBuilder(
      stream: productItemStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) {
                      return ProductDetails(image: ds['image'],details: ds['details'],name: ds['name'],price: ds['price'],);
                      },
                    ));
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(15.0),
                    child: Container(
                      padding: const EdgeInsets.only(
                          top: 10.0, bottom: 5.0, left: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100.0),
                            child: Image.network(
                              ds['image'],
                              width: 110,
                              height: 110.0,
                              fit: BoxFit.fill,
                            ),
                          ),
                          const SizedBox(width: 20.0),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  ds['name'],
                                  style: AppWidget.semiBoldTextStyle(),
                                ),
                                Text(
                                  ds['details'],
                                  style: AppWidget.lightTextStyle(),
                                ),
                                Text(
                                  '\$${ds['price']}',
                                  style: AppWidget.boldTextStyle(),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          // Provide sample data if snapshot has no data
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(
          top: 50.0,
          left: 20.0,
          right: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nabeel N,',
                  style: AppWidget.boldTextStyle(),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.all(3),
                  child: const Icon(
                    Icons.shopping_cart,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 20.0),
            Text(
              'Delicious Food',
              style: AppWidget.headLineTextStyle(),
            ),
            Text(
              'Discover And Get Greate Food',
              style: AppWidget.lightTextStyle(),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: imagePath.map((path) {
                return GestureDetector(
                  onTap: () async {
                    productItemStream = await DatabaseMethods()
                        .getProductItem(path['name'].toString());
                    selectedCategory = path['name'].toString();

                    setState(() {});
                  },
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10.0),
                    child: Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: selectedCategory == path['name']
                            ? Color.fromARGB(255, 244, 133, 54)
                            : Colors.white,
                      ),
                      child: Image.asset(
                        path['path'].toString(),
                        width: 40.0,
                        height: 40.0,
                        fit: BoxFit.cover,
                        color: selectedCategory == path['name']
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 25.0),
            Container(
              height: 270,
              child: allItemsHorizonatal(),
            ),
            const SizedBox(height: 10.0),
            Flexible(
              child: Container(
                height: 270,
                child: allItemsVertical(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
