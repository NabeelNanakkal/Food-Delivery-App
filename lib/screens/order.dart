import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:food_app/services/service.dart';
import 'package:food_app/services/shared_pref.dart';
import 'package:food_app/widget/widget_support.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  String? id, wallet;
  int total = 0, amount2 = 0;

  void startTimer() {
    Timer(Duration(seconds: 2), () {
      amount2 = total;
      setState(() {});
    });
  }

  gettheSharedPre() async {
    id = await SharedPreferenceHelper().getUserId();
    wallet = await SharedPreferenceHelper().getUserWallet();

    setState(() {});
  }

  onTheLoad() async {
    await gettheSharedPre();
    foodStream = await DatabaseMethods().getProductCart(id!);
    startTimer();
    setState(() {});
  }

  @override
  void initState() {
    onTheLoad();
    super.initState();
  }

  Stream? foodStream;

  Widget cartItems() {
    return StreamBuilder(
      stream: foodStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.docs.isNotEmpty) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data.docs[index];
              total = total + int.parse(ds['totalPrice']);
              return Container(
                margin: EdgeInsets.only(left: 20.0, top: 15.0, right: 20.0),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.circular(15.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          height: 70.0,
                          width: 40.0,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(child: Text(ds['quantity'])),
                        ),
                        const SizedBox(
                          width: 25.0,
                        ),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(
                                MediaQuery.of(context).size.width / 2),
                            child: Image.network(
                              ds['image'],
                              width: 90.0,
                              height: 90.0,
                              fit: BoxFit.fill,
                            )),
                        SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ds['name'],
                              style: AppWidget.boldTextStyle(),
                            ),
                            Text(
                              '\$${ds['totalPrice']}',
                              style: AppWidget.semiBoldTextStyle(),
                            )
                          ],
                        )
                      ],
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
        margin: const EdgeInsets.only(top: 60.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Material(
                elevation: 2.0,
                child: Container(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Center(
                      child: Text('Food Cart',
                          style: AppWidget.headLineTextStyle())),
                )),
            // ..................//
            Container(
              height: MediaQuery.of(context).size.height / 1.7,
              child: cartItems(),
            ),
            const Spacer(),
            const Divider(),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Price',
                    style: AppWidget.headLineText3Style(),
                  ),
                  Text(
                    '\$${total.toString()}',
                    style: AppWidget.headLineText3Style(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 20.0, bottom: 30.0),
              child: ElevatedButton(
                onPressed: () async {
                  int amount = int.parse(wallet!) - amount2;
                  await DatabaseMethods()
                      .updateUserWallet(id!, amount.toString());
                  await SharedPreferenceHelper()
                      .saveUserWallet(amount.toString());
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('CheckOut successfully')),
                  );
                },
                child: Text(
                  'CheckOut',
                  style: AppWidget.buttonBoldTextStyle(),
                ),
                style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                        const Color.fromARGB(255, 244, 133, 54)),
                    minimumSize: WidgetStatePropertyAll(
                        Size(MediaQuery.of(context).size.width, 50))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
