import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/login.dart';
import 'package:food_app/services/service.dart';
import 'package:food_app/services/shared_pref.dart';
import 'package:food_app/widget/bottom_nav.dart';
import 'package:food_app/widget/widget_support.dart';
import 'package:random_string/random_string.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String name = '';
  String email = '';
  String password = '';

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  registration() async {
    if (password != null) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ScaffoldMessenger.of(context).showSnackBar(
            (SnackBar(content: Text('User Registered Successfully'))));
            String Id = randomAlphaNumeric(10);
            Map<String, dynamic> addUserInfo = {
              'name':nameController.text,
              'email':emailController.text,
              'wallet':'0',
              'Id':Id
            };

            await DatabaseMethods().addUserDetails(addUserInfo, Id);
            await SharedPreferenceHelper().saveUserId(Id);
            await SharedPreferenceHelper().saveUserName(nameController.text);
            await SharedPreferenceHelper().saveUserEmail(emailController.text);
            await SharedPreferenceHelper().saveUserWallet('0');



        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) {
            return const BottomNavigation();
          },
        ));
      } on FirebaseAuthException catch (err) {
        if (err.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
              (SnackBar(content: Text('Password provider is too weak'))));
        } else if (err.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
              (SnackBar(content: Text('Account already exists'))));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height / 3),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(
                        30.0,
                      ),
                      topRight: Radius.circular(30.0))),
            ),
            Container(
              margin:
                  const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
              child: Column(
                children: [
                  Center(
                    child: Text('Halal Foods',
                        style: AppWidget.headLineText2Style()),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Material(
                    borderRadius:
                        const BorderRadius.all(Radius.circular(10.0)),
                    elevation: 5.0,
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 2,
                      margin: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 30.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            Text(
                              'Sign Up',
                              style: AppWidget.headLineTextStyle(),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Name',
                                  hintStyle: AppWidget.semiBoldTextStyle(),
                                  prefixIcon: Icon(Icons.person_outlined)),
                            ),
                           const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: emailController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: AppWidget.semiBoldTextStyle(),
                                  prefixIcon: Icon(Icons.email_outlined)),
                            ),
                            const SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              controller: passwordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: AppWidget.semiBoldTextStyle(),
                                  prefixIcon: Icon(Icons.password_outlined)),
                            ),
                            const SizedBox(
                              height: 50.0,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    email = emailController.text;
                                    name = nameController.text;
                                    password = passwordController.text;
                                  });
                                }
                                registration();
                              },
                              child: const Text(
                                'Sign Up',
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
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const Login();
                        },
                      ));
                    },
                    child: Text(
                      "Already have an account? Login",
                      style: AppWidget.semiBoldText2Style(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
