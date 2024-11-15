import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/services/service.dart';
import 'package:food_app/services/shared_pref.dart';
import 'package:food_app/widget/widget_support.dart';

class ProductDetails extends StatefulWidget {
  String name, image, details, price;
  ProductDetails(
      {super.key,
      required this.image,
      required this.details,
      required this.name,
      required this.price});

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  int productQty = 1, totalPrice = 0;
  String? id;

  gettheSharedPre() async {
    id = await SharedPreferenceHelper().getUserId();

    setState(() {});
  }

  ontheload() async {
    await gettheSharedPre();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    totalPrice = int.parse(widget.price);
    ontheload();
  }

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
            ClipRRect(
              borderRadius: BorderRadius.circular(
                MediaQuery.of(context).size.width / 2,
              ),
              child: Image.network(
                widget.image,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2.5,
                fit: BoxFit.fill,
              ),
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
                      widget.name,
                      style: AppWidget.semiBoldTextStyle(),
                    ),
                    // Text(
                    //   'Food Name Here',
                    //   style: AppWidget.boldTextStyle(),
                    // )
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      if (productQty > 1) {
                        productQty--;
                        totalPrice = totalPrice - int.parse(widget.price);
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
                      totalPrice = totalPrice + int.parse(widget.price);
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
              widget.details,
              style: AppWidget.lightTextStyle(),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: [
                Text(
                  'Delivery Time',
                  style: AppWidget.semiBoldTextStyle(),
                ),
                const SizedBox(
                  width: 30.0,
                ),
                const Icon(Icons.alarm),
                const SizedBox(
                  width: 10.0,
                ),
                Text(
                  '30 min',
                  style: AppWidget.semiBoldTextStyle(),
                )
              ],
            ),
            Spacer(),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Price',
                      style: AppWidget.semiBoldTextStyle(),
                    ),
                    Text(
                      '\$ ${totalPrice}',
                      style: AppWidget.boldTextStyle(),
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () async {
                    Map<String, String> cartItem = {
                      'name': widget.name,
                      'image': widget.image,
                      'quantity': productQty.toString(),
                      'totalPrice': totalPrice.toString()
                    };
                    await DatabaseMethods()
                        .addUserCart(cartItem, id.toString());
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Product added to cart successfully')),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 133, 54),
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Row(
                      children: [
                        Text(
                          'Add To Cart',
                          style: AppWidget.buttonBoldTextStyle(),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: Color.fromARGB(255, 255, 255, 255)),
                          child: const Icon(
                            Icons.shopping_cart_outlined,
                            size: 25.0,
                          ),
                        )
                      ],
                    ),
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
