import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserDetails(Map<String, dynamic> userInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .set(userInfoMap);
  }

  Future updateUserWallet(String id, String amount) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'wallet': amount});
  }

  Future updateUserProfile(String id, String profile) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .update({'profile': profile});
  }

  Future addProductItem(Map<String, dynamic> productInfoMap, String name) async {
    return await FirebaseFirestore.instance.collection(name).add(productInfoMap);
  }

  Future<Stream<QuerySnapshot>> getProductItem(String name)async{
    return await FirebaseFirestore.instance.collection(name).snapshots();
  }

   Future addUserCart(Map<String, dynamic> userCartInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .collection('cart')
        .add(userCartInfoMap);
  }

   Future<Stream<QuerySnapshot>> getProductCart(String id)async{
    return await FirebaseFirestore.instance.collection('users').doc(id).collection('cart').snapshots();
  }
}
