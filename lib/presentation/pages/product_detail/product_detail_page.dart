import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/app_styles.dart';
import '../../widgets/image_network_widget.dart';
import '../../widgets/loading_widget.dart';
import '../cart_page.dart';
import 'bloc/product_detail_bloc.dart';
import '../../widgets/error_widget.dart' as error_widget;

class ProductDetailPage extends StatefulWidget {
  static const String ROUTE_NAME = "/product-detail";
  final int id;
  const ProductDetailPage({
    super.key,
    required this.id,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  void didChangeDependencies() {
    context.read<ProductDetailBloc>().add(GetProductEvent(widget.id));
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
        actions: [
          BlocBuilder<ProductDetailBloc, ProductDetailState>(
            builder: (context, state) {
              return IconButton(
                onPressed: () {
                  if (state is ProductDetailLoaded) {
                    state.isWishlist
                        ? context
                            .read<ProductDetailBloc>()
                            .add(RemoveWishlistEvent(widget.id))
                        : context
                            .read<ProductDetailBloc>()
                            .add(AddWishlistEvent());
                  }
                },
                icon: Icon(state is ProductDetailLoaded
                    ? (state.isWishlist
                        ? Icons.favorite
                        : Icons.favorite_border)
                    : Icons.favorite_border),
              );
            },
          )
        ],
      ),
      backgroundColor: productBg,
      body: BlocBuilder<ProductDetailBloc, ProductDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case ProductDetailLoading:
              return LoadingWidget();
            case ProductDetailLoaded:
              return _buildBody(context, state as ProductDetailLoaded);
            case ProductDetailError:
              return error_widget.ErrorWidget(
                (state as ProductDetailError).error,
              );
            default:
              return error_widget.ErrorWidget(
                'Oopss.. Something wrong, please try again later !',
              );
          }
        },
      ),
    );
  }

  SingleChildScrollView _buildBody(
      BuildContext context, ProductDetailLoaded state) {
    final product = state.product;
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: ImageNetworkWidget(
              height: 225,
              imageUrl: product.imageUrl,
              width: 125,
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: 25,
            ),
            padding: EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product.category,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            product.title,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Expanded(
                          child: Text(
                        "\$${product.price}",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      )),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 82,
                      padding: EdgeInsets.symmetric(
                        vertical: 2,
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
                    ),
                    Container(
                      width: 60,
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: dividerColor,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Image.asset(
                        "assets/images/icon_upload.png",
                        fit: BoxFit.contain,
                        width: 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 26,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "DESCRIPTION",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: product.description,
                        style: TextStyle(
                          color: greyColor,
                          fontWeight: FontWeight.w500,
                        ),
                        children: [
                          TextSpan(
                            text: "detail",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              decoration: TextDecoration.underline,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SELECT",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    Container(
                      height: 64,
                      margin: EdgeInsets.only(top: 14),
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: state.sizes
                            .map((size) =>
                                _buildSizeBox(size == state.selectedSize, size))
                            .toList(),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(CartPage.ROUTE_NAME);
                      },
                      splashColor: greyColor,
                      child: Container(
                        margin: EdgeInsets.only(
                          top: 65,
                          bottom: 22,
                        ),
                        height: 64,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.circular(56),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_bag_outlined,
                              size: 24,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "ADD TO CART",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSizeBox(bool isSelected, String size) {
    return GestureDetector(
      onTap: () => context.read<ProductDetailBloc>().add(SelectSizeEvent(size)),
      child: Container(
        width: 62,
        height: 62,
        padding: EdgeInsets.all(18),
        margin: EdgeInsets.only(
          left: isSelected ? 0 : 12,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? purpleColor : dividerColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          size,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}
