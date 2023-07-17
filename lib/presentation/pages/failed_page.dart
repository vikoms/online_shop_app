import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';
import 'home/home_page.dart';

class FailedPage extends StatelessWidget {
  static const ROUTE_NAME = '/failed-page';
  const FailedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.of(context)
            .popUntil((route) => route.settings.name == HomePage.ROUTE_NAME);
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/icon_alert.png',
                width: 116,
                height: 116,
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Oh Snap! Order Failed',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w900,
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Looks like something went wrong\nwhile processing your request.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: greyColor,
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: purpleColor,
                    minimumSize: const Size.fromHeight(54),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(27),
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    'PLEASE TRY AGAIN',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).popUntil(
                      (route) => route.settings.name == HomePage.ROUTE_NAME);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.arrow_back_rounded,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Back to home',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
