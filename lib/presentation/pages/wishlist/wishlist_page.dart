import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop_app/presentation/pages/product_detail/product_detail_page.dart';
import 'package:online_shop_app/presentation/widgets/image_network_widget.dart';
import 'package:online_shop_app/presentation/widgets/loading_widget.dart';
import 'package:online_shop_app/utils/app_styles.dart';

import '../../../domain/entities/wistlist.dart';
import '../../widgets/error_widget.dart' as error_widget;
import '../credit_card_page.dart';
import '../failed_page.dart';
import '../success_page.dart';
import 'bloc/wishlist_bloc.dart';

class WishlistPage extends StatefulWidget {
  static const ROUTE_NAME = "/favorite-page";
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  @override
  void didChangeDependencies() {
    context.read<WishlistBloc>().add(OnGetWishlistEvent());
    super.didChangeDependencies();
  }

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
          "Favorite",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: BlocBuilder<WishlistBloc, WishlistState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case WishlistLoading:
                return LoadingWidget();
              case WishlistLoaded:
                final wishlist = (state as WishlistLoaded).wishlist;
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return _buildCard(
                            wishlist[index],
                            context,
                          );
                        },
                        itemCount: wishlist.length,
                      ),
                    ),
                    _buildCheckoutButton(context),
                  ],
                );
              case WishlistError:
                return error_widget.ErrorWidget(
                    (state as WishlistError).message);
              default:
                return error_widget.ErrorWidget(
                    "Ooppss... Something wrong, please try again later!");
            }
          },
        ),
      ),
    );
  }

  ElevatedButton _buildCheckoutButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: purpleColor,
        minimumSize: const Size.fromHeight(54),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(27),
        ),
      ),
      onPressed: () {
        openModalBottomSheet(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.shopping_bag_outlined,
            size: 24,
            color: Colors.white,
          ),
          SizedBox(
            width: 14,
          ),
          Text(
            'ADD ALL TO CART',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w900,
            ),
          ),
        ],
      ),
    );
  }

  void openModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        backgroundColor: productBg,
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: 42,
                bottom: 30,
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      bottom: 24,
                      left: 24,
                      right: 24,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Checkout",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close,
                            color: greyColor,
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    color: dividerColorGrey,
                    height: 1,
                  ),
                  _buildList(context),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 22,
                    ),
                    child: Text(
                      "By placing an order you agree to our \nTerms And Conditions.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: greyColor,
                        fontSize: 11,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24,
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: purpleColor,
                        minimumSize: const Size.fromHeight(54),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(27),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SuccessPage.ROUTE_NAME);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fire_truck,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 14,
                          ),
                          Text(
                            'PLACE ORDER',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Padding _buildList(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 26),
      child: Column(
        children: [
          _buildBottomsheetListTile(
            "Delivery",
            () {
              final payment =
                  Navigator.of(context).pushNamed(CreditCardPage.ROUTE_NAME);
            },
            subtitle: "Select Method",
          ),
          _buildBottomsheetListTile(
            "Payment",
            () {
              Navigator.pop(context);
            },
            imageSource: "assets/images/icon_mastercard.png",
          ),
          _buildBottomsheetListTile(
            "Promo Code",
            () {
              Navigator.pop(context);
            },
            subtitle: "Pick discount",
          ),
          _buildBottomsheetListTile(
            "Total Cost",
            () {
              Navigator.pop(context);
            },
            subtitle: "\$135.96",
          ),
        ],
      ),
    );
  }

  Widget _buildBottomsheetListTile(
    String title,
    VoidCallback onClick, {
    String? subtitle,
    String? imageSource,
  }) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 21),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Row(
                  children: [
                    subtitle != null
                        ? Text(
                            subtitle,
                            style: TextStyle(
                              color: purpleColor,
                              fontWeight: FontWeight.w900,
                            ),
                          )
                        : Image.asset(
                            imageSource ?? "",
                            width: 21,
                            height: 16,
                          ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: purpleColor,
                    ),
                  ],
                )
              ],
            ),
            SizedBox(
              height: 24,
            ),
            Divider(
              color: dividerColorGrey,
              height: 1,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(Wishlist wishlist, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailPage.ROUTE_NAME,
          arguments: wishlist.id,
        );
      },
      child: Container(
        padding: EdgeInsets.all(22),
        margin: EdgeInsets.only(top: 14),
        decoration: BoxDecoration(
          color: dividerColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageNetworkWidget(
                    imageUrl: wishlist.photo,
                    width: 88,
                    height: 78,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          wishlist.name,
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
                            letterSpacing: 2,
                          ),
                        ),
                        SizedBox(
                          height: 24,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$${wishlist.price} USD",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_right_alt_sharp),
          ],
        ),
      ),
    );
  }
}
