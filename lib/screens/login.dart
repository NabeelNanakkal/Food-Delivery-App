import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/screens/signup.dart';
import 'package:food_app/widget/widget_support.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.topRight,
                      colors: [
                    Color.fromARGB(255, 242, 151, 85),
                    Color.fromARGB(255, 244, 133, 54)
                  ])),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0))),
            ),
            Container(
                margin:
                    const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Halal Foods',
                      style: AppWidget.headLineText2Style(),
                    )),
                    SizedBox(
                      height: 30.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.5,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 30.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Login',
                              style: AppWidget.headLineTextStyle(),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: AppWidget.semiBoldTextStyle(),
                                  prefixIcon: Icon(Icons.email_outlined)),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: AppWidget.semiBoldTextStyle(),
                                  prefixIcon: Icon(Icons.password_outlined)),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Container(
                              alignment: Alignment.topRight,
                              child: Text(
                                'Forgot password?',
                                style: AppWidget.lightTextStyle(),
                              ),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            ElevatedButton(
                              onPressed: () {},
                              child: const Text(
                                'Login',
                              ),
                              style: ButtonStyle(
                                  minimumSize:
                                      MaterialStatePropertyAll(Size(200, 40)),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 244, 133, 54)),
                                  textStyle: MaterialStateProperty.all(
                                      AppWidget.buttonBoldTextStyle()),
                                  elevation: MaterialStateProperty.all(5)),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80.0,
                    ),
                    GestureDetector(
                       onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return SignUp();
                        },
                      ));
                    },
                      child: Text(
                        "Don't have an account? Sign up",
                        style: AppWidget.semiBoldText2Style(),
                      ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
