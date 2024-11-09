import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/screens/signup.dart';
import 'package:food_app/widget/content_model.dart';
import 'package:food_app/widget/widget_support.dart';

class Onboard extends StatefulWidget {
  const Onboard({super.key});

  @override
  State<Onboard> createState() => _OnboardState();
}

int currentIndex = 0;
late PageController _pageController;

class _OnboardState extends State<Onboard> {
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: content.length,
              onPageChanged: (int index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 40.0),

                      Image.asset(
                        content[i].image,
                        height: 400,
                        width: MediaQuery.of(context).size.width,
                        fit: BoxFit.fill,
                      ),
                      const SizedBox(height: 40.0),
                      Text(
                        content[i].title,
                        style: AppWidget.headLineTextStyle(),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        content[i].description,
                        style: AppWidget.lightTextStyle(),
                      ),
                      // Spacer(),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              content.length,
              (index) => buildDot(index, context),
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
          ElevatedButton(
              style: const ButtonStyle(
                minimumSize: MaterialStatePropertyAll(Size(250,50.0)),
                shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)))),
                  backgroundColor: MaterialStatePropertyAll(
                      Color.fromARGB(255, 244, 133, 54))),
              onPressed: () {
                if (currentIndex == content.length - 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return const SignUp();
                    },
                  ));
                }
                _pageController.nextPage(
                    duration: const Duration(milliseconds: 100),
                    curve: Curves.bounceIn);
              },
              child: Text(
               currentIndex == content.length - 1 ? 'Start' : 'Next',
                style: AppWidget.buttonBoldTextStyle(),
              )),
          const SizedBox(height: 50.0),
        ],
      ),
    );
  }

  Container buildDot(int index, BuildContext context) {
    return Container(
      width: currentIndex == index ? 17.0 : 7.0,
      height: 10.0,
      margin: const EdgeInsets.only(right: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: currentIndex == index
            ? const Color.fromARGB(255, 244, 133, 54)
            : const Color.fromARGB(255, 243, 202, 173),
      ),
    );
  }
}
