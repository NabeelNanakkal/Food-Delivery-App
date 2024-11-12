import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/admin/admin_home.dart';
import 'package:food_app/widget/widget_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              // color: Colors.red,
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding:
                  const EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0))),
            ),
            Container(
              margin: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Text(
                        "Let's Start ",
                        style: AppWidget.headLineTextStyle(),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Material(
                        elevation: 8.0,
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          padding: const EdgeInsets.all(30.0),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          child: Column(
                            children: [
                              Text(
                                'Login',
                                style: AppWidget.headLineText3Style(),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                controller: nameController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Admin name';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.person_2_outlined),
                                    hintText: 'Enter Admin Name',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              TextFormField(
                                controller: passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter password';
                                  }
                                  return null;
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon:
                                        const Icon(Icons.password_outlined),
                                    hintText: 'Enter Admin password',
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10))),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  LoginAdmin();
                                },
                                child: Text(
                                  'Login',
                                  style: AppWidget.buttonBoldTextStyle(),
                                ),
                                style: const ButtonStyle(
                                    minimumSize: WidgetStatePropertyAll(
                                        Size(double.maxFinite, 50.0)),
                                    backgroundColor:
                                        WidgetStatePropertyAll(Colors.black),
                                    elevation: WidgetStatePropertyAll(8.0)),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }

  LoginAdmin() async {
    await FirebaseFirestore.instance.collection('Admin').get().then((snapshot) {
      snapshot.docs.forEach((result) {
        if (result.data()['id'] != nameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              backgroundColor: Colors.red,
              content: Text('User Name not match')));
        } else if (result.data()['password'] !=
            passwordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.red,
              content: Text('Password not match')));
        }else{
          Route route = MaterialPageRoute(builder: (context) => AdminHome(),);
          Navigator.of(context).pushReplacement(route);
        }
      });
    });
  }
}
