import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/signup.dart';
import 'package:food_app/widget/widget_support.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  String email = '';
  final _formKey = GlobalKey<FormState>();

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email has been sent')));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Enter your valid email')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const SizedBox(
              height: 70.0,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                'Password Recovery',
                style: AppWidget.headLineTextStyle(),
              ),
            ),
            const SizedBox(
              height: 10.0,
            ),
            Text(
              'Enter your email',
              style: AppWidget.semiBoldTextStyle(),
            ),
            Expanded(
                child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: EdgeInsets.only(left: 20.0, right: 20.0),
                      child: ListView(
                        children: [
                          TextFormField(
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Enter your email',
                                prefixIcon: Icon(
                                  Icons.person_outlined,
                                  size: 30.0,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(10.0)))),
                          ),
                          const SizedBox(
                            height: 30.0,
                          ),
                          ElevatedButton(
                              style: const ButtonStyle(
                                  elevation: WidgetStatePropertyAll(10.0),
                                  padding: WidgetStatePropertyAll(
                                      EdgeInsets.only(top: 15.0, bottom: 15.0)),
                                  backgroundColor: WidgetStatePropertyAll(
                                      Color.fromARGB(255, 244, 133, 54))),
                              onPressed: () {
                                if(_formKey.currentState!.validate()){
                                  setState(() {
                                    email = emailController.text;
                                  });
                                }
                                resetPassword();
                              },
                              child: Text(
                                'Confirm',
                                style: AppWidget.buttonBoldTextStyle(),
                              )),
                          const SizedBox(
                            height: 40.0,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) {
                                  return const SignUp();
                                },
                              ));
                            },
                            child: Center(
                                child: Text(
                              "Don't have an account? Create",
                              style: AppWidget.semiBoldText2Style(),
                            )),
                          )
                        ],
                      ),
                    )))
          ],
        ),
      ),
    );
  }
}
