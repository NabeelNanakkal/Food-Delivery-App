import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/widget/widget_support.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({super.key});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

int productQty = 1;

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_back)),
            Image.asset(
              'assets/images/salad2.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              fit: BoxFit.fill,
            ),
            const SizedBox(
              height: 15.0,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Food Name Here',
                      style: AppWidget.semiBoldTextStyle(),
                    ),
                    Text(
                      'Food Name Here',
                      style: AppWidget.boldTextStyle(),
                    )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (productQty > 1) {
                        productQty--;
                      }
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 133, 54),
                        borderRadius: BorderRadius.circular(5.0)),
                    child: const Icon(
                      Icons.remove,
                      size: 15.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                Text(
                  productQty.toString(),
                  style: AppWidget.semiBoldTextStyle(),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      productQty++;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 133, 54),
                        borderRadius: BorderRadius.circular(5.0)),
                    child:
                        const Icon(Icons.add, size: 15.0, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text(
              "dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
              style: AppWidget.lightTextStyle(),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text('Delivery Time',style: AppWidget.semiBoldTextStyle(),),
                const SizedBox(width: 30.0,),
                const Icon(Icons.alarm),
                const SizedBox(width: 10.0,),
                Text('30 min',style: AppWidget.semiBoldTextStyle(),)
              ],
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Price',style: AppWidget.semiBoldTextStyle(),),
                    Text('\$ 25.00',style: AppWidget.boldTextStyle(),),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(left: 20.0,right: 20.0,top: 10.0,bottom: 10.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 244, 133, 54),
                    borderRadius: BorderRadius.circular(8.0)
                  ),
                  child: Row(
                    children: [
                      Text('Add To Cart',style: AppWidget.buttonBoldTextStyle(),),
                      const SizedBox(width: 20.0,),
                      Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Color.fromARGB(255, 255, 255, 255)
                        ),
                        child: const Icon(Icons.shopping_cart_outlined,size: 25.0,),
                      )
                    ],
                  ),
                )
              ],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
