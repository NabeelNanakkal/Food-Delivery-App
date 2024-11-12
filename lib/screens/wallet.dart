import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:food_app/services/service.dart';
import 'package:food_app/services/shared_pref.dart';
import 'package:food_app/widget/app_constants.dart';
import 'package:food_app/widget/widget_support.dart';
import 'package:http/http.dart' as http;

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final List<String> moneyList = ['2000', '1000', '750', '500', '250'];
  Map<String, dynamic>? paymentIntent;
  String? selectedMoney;
  String? wallet, id;
  int? add;
  TextEditingController amountController = TextEditingController();

  getTheSharedpreference() async {
    wallet = await SharedPreferenceHelper().getUserWallet();
    id = await SharedPreferenceHelper().getUserId();
    setState(() {});
  }

  onTheLoad() async {
    await getTheSharedpreference();
    setState(() {});
  }

  @override
  void initState() {
    onTheLoad();
    // selectedMoney = moneyList[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: wallet == null
          ? CircularProgressIndicator()
          : Container(
              margin: const EdgeInsets.only(top: 60.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Material(
                      elevation: 2.0,
                      child: Container(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: Center(
                            child: Text('Wallet',
                                style: AppWidget.headLineTextStyle())),
                      )),
                  const SizedBox(height: 30.0),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10.0),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(205, 242, 243, 242)),
                    child: Row(
                      children: [
                        Image.asset('assets/images/wallet.png',
                            width: 60.0, height: 60.0, fit: BoxFit.contain),
                        const SizedBox(width: 40.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Your wallet',
                                style: AppWidget.boldTextStyle()),
                            const SizedBox(height: 5.0),
                            Text("\$" + wallet.toString(),
                                style: AppWidget.semiBoldTextStyle()),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 20.0, bottom: 20.0),
                    child:
                        Text('Add Money', style: AppWidget.headLineTextStyle()),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0, right: 10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: moneyList.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(
                                right: 10.0, left: 10, bottom: 10.0),
                            child: Material(
                              elevation: 4.0,
                              borderRadius: BorderRadius.circular(10.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedMoney = item;
                                  });
                                  makePayment(selectedMoney.toString());
                                },
                                child: Container(
                                  padding: const EdgeInsets.only(
                                      left: 20.0,
                                      right: 20.0,
                                      top: 10.0,
                                      bottom: 10.0),
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(10.0)),
                                    color: selectedMoney == item
                                        ? Color.fromARGB(255, 244, 133, 54)
                                        : Colors.white,
                                  ),
                                  child: Text(
                                    '\$ $item',
                                    style: selectedMoney == item
                                        ? AppWidget.buttonBoldTextStyle()
                                        : AppWidget.semiBoldText2Style(),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50.0),
                  GestureDetector(
                    onTap: () {
                      openEditor();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(horizontal: 25.0),
                      padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                      decoration: const BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 5.0,
                              color: Colors.black26,
                              blurStyle: BlurStyle.solid),
                        ],
                        color: Color.fromARGB(255, 244, 133, 54),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      child: Center(
                          child: Text('Add Money',
                              style: AppWidget.buttonBoldText2Style())),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createPaymentIntent(amount, 'INR');
      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Nabeel',
            ),
          )
          .then((value) {});
      displayPaymentSheet(amount);
    } catch (e) {
      print('Error in makePayment: $e');
    }
  }

  displayPaymentSheet(String amount) async {
    add = int.parse(wallet!) + int.parse(amount);
    await SharedPreferenceHelper().saveUserWallet(add.toString());
    await DatabaseMethods().updateUserWallet(id!, add.toString());
    try {
      await Stripe.instance.presentPaymentSheet().then((value) async {
        // Show success dialog
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.check_circle_rounded,
                  color: Colors.green,
                  size: 28.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Payment Successful!',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Your payment of \$$amount has been successfully completed.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  setState(() {
                    selectedMoney = '';
                  });
                },
                child: Text(
                  'OK',
                  style: TextStyle(color: Colors.orange[600]),
                ),
              ),
            ],
          ),
        );
        await getTheSharedpreference();
        paymentIntent = null; // Reset payment intent after successful payment
      }).onError((error, stackTrace) {
        // Show failure dialog
        print('Error: $error $stackTrace');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            title: Row(
              children: [
                Icon(
                  Icons.cancel_rounded,
                  color: Colors.red,
                  size: 28.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Payment Cancelled',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            content: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Your payment process was canceled. Please try again or contact support.',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[700],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  setState(() {
                    selectedMoney = '';
                  });
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.orange[600]),
                ),
              ),
            ],
          ),
        );
      });
    } catch (e) {
      print('Error presenting payment sheet: $e');
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount).toString(),
        'currency': currency,
        'payment_method_types[]': 'card',
      };

      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        headers: {
          'Authorization': 'Bearer $secretKey',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body,
      );

      print('Payment intent response: ${response.body}');
      return jsonDecode(response.body);
    } catch (e) {
      print('Error creating payment intent: $e');
      return {};
    }
  }

  int calculateAmount(String amount) {
    final calculatedAmount = int.parse(amount) * 100;
    return calculatedAmount;
  }

  Future openEditor() => showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          content: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize:
                    MainAxisSize.min, // Ensures the Column takes minimum space
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Add Money', style: AppWidget.boldTextStyle()),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          amountController.clear();
                        },
                        child: const Icon(Icons.cancel, color: Colors.red),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0), // Moved outside Row for spacing
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black38, width: 2.0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: amountController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter Amount',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          makePayment(amountController.text);
                          amountController.clear();
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                              bottom: 7.0, left: 20.0, right: 20.0, top: 7.0),
                          decoration: const BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              color: Color.fromARGB(255, 242, 151, 85)),
                          child: Text(
                            'Pay',
                            style: AppWidget.buttonBoldTextStyle(),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
}
