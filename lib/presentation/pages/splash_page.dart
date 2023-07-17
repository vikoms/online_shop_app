import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:online_shop_app/presentation/pages/sign_in/sign_in_page.dart';

import '../../utils/app_styles.dart';
import 'home/home_page.dart';

class SplashPage extends StatefulWidget {
  static const String ROUTE_NAME = '/';
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    checkUserLoggedIn().then((isLoggedIn) {
      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed(HomePage.ROUTE_NAME);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash_background.png"),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(
                  top: 48,
                ),
                child: const Text(
                  "Greeta.",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                ),
                child: Column(
                  children: [
                    const Text(
                      "Create your fashion \n in your own way",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    const Text(
                      "Each men and women has their own style, Geeta help you to create your unique style. ",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, SignInPage.ROUTE_NAME);
                      },
                      child: Container(
                        width: double.infinity,
                        height: 54,
                        margin: EdgeInsets.symmetric(
                          horizontal: 46,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                          borderRadius: BorderRadius.circular(56),
                        ),
                        child: const Center(
                          child: Text(
                            "LOG IN",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 22,
                            height: 1,
                            color: Colors.black,
                            margin: EdgeInsets.only(
                              right: 8,
                            ),
                          ),
                          Text(
                            "OR",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            width: 22,
                            height: 1,
                            color: Colors.black,
                            margin: EdgeInsets.only(
                              left: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 46,
                      ),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: 54,
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: purpleColor,
                            shape: const StadiumBorder(),
                          ),
                          // ignore: prefer_const_constructors
                          child: Text(
                            "Register",
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> checkUserLoggedIn() async {
    User? user = FirebaseAuth.instance.currentUser;
    return user != null;
  }
}
