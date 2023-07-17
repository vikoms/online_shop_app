import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../utils/app_styles.dart';

class CartPage extends StatelessWidget {
  static const ROUTE_NAME = '/cart-page';
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "My Cart",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  _buildCard(context),
                  _buildCard(context),
                  _buildCard(context),
                  _buildCard(context),
                  _buildCard(context),
                  _buildCard(context),
                  _buildCard(context),
                  _buildCard(context),
                ],
              ),
            ),
            _buildCheckoutButton(context),
          ],
        ),
      ),
    );
  }

  Container _buildCard(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(22),
      margin: EdgeInsets.only(top: 14),
      decoration: BoxDecoration(
        color: dividerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Icon(
            Icons.close,
            color: greyColor,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/image_product_2.png",
                  width: 88,
                  height: 78,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Leather Jacket",
                        style: TextStyle(
                          color: purpleColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "GREETA COLLECTION",
                        style: TextStyle(
                          color: greyColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          letterSpacing: 3,
                        ),
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "\$28.00 USD",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          _buildPlusMinusButton()
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPlusMinusButton() {
    return Container(
      width: 82,
      padding: EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "-",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "1",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: 18,
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            "+",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ],
      ),
    );
  }

  InkWell _buildCheckoutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CartPage.ROUTE_NAME);
      },
      splashColor: greyColor,
      child: Container(
        margin: EdgeInsets.only(
          top: 12,
        ),
        height: 64,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: purpleColor,
          borderRadius: BorderRadius.circular(56),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/icon_checkout.png",
                  width: 24,
                  height: 24,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "GO TO CHECKOUT",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: darkPurpleColor,
                borderRadius: BorderRadius.circular(4),
              ),
              padding: EdgeInsets.all(4),
              child: Text(
                "\$135.96",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
