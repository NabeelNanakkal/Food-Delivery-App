import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/forgotpassword.dart';
import 'package:food_app/screens/signup.dart';
import 'package:food_app/widget/bottom_nav.dart';
import 'package:food_app/widget/widget_support.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {

  String email='';
  String password='';
  final _formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  userLogin() async{
   try{
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Login Successfully')));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return BottomNavigation();
      },));
   }on FirebaseAuthException catch(e){
    if(e.code == 'user-not-found'){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('No user found')));
    }else if(e.code == 'wrong-password'){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('invalid password')));
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
                margin: const EdgeInsets.only(top: 80.0, left: 30.0, right: 30.0),
                child: Column(
                  children: [
                    Center(
                        child: Text(
                      'Halal Foods',
                      style: AppWidget.headLineText2Style(),
                    )),
                    const SizedBox(
                      height: 30.0,
                    ),
                    Material(
                      elevation: 5.0,
                      borderRadius: const BorderRadius.all(Radius.circular(10.0)),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 2.2,
                        margin: const EdgeInsets.only(
                            left: 30.0, right: 30.0, top: 30.0),
                        decoration: const BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Text(
                                  'Login',
                                  style: AppWidget.headLineTextStyle(),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: emailController,
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
                                      return 'Please Enter your email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle: AppWidget.semiBoldTextStyle(),
                                      prefixIcon: const Icon(Icons.email_outlined)),
                                ),
                                const SizedBox(
                                  height: 20.0,
                                ),
                                TextFormField(
                                  controller: passwordController,
                                  validator: (value) {
                                    if(value == null || value.isEmpty){
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
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                                      return ForgotPassword();
                                    },));
                                  },
                                  child: Container(
                                    alignment: Alignment.topRight,
                                    child: Text(
                                      'Forgot password?',
                                      style: AppWidget.lightTextStyle(),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 50.0,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()){
                                      setState(() {
                                        email = emailController.text;
                                        password = passwordController.text;
                                      });
                                    }
                                    userLogin();
                                  },
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
                      ),
                    ),
                    const SizedBox(
                      height: 80.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) {
                            return const SignUp();
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
