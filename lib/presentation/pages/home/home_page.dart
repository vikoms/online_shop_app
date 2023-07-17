import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop_app/domain/entities/product.dart';
import 'package:online_shop_app/presentation/pages/product_detail/product_detail_page.dart';
import 'package:online_shop_app/utils/app_styles.dart';
import '../../../domain/entities/category.dart';
import '../../../utils/request_state.dart';
import '../../widgets/error_widget.dart' as errorWidget;

import '../../widgets/image_network_widget.dart';
import '../../widgets/loading_widget.dart';
import '../wishlist/wishlist_page.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {
  static const String ROUTE_NAME = "/home-page";
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(OnGetProductEvent(''));
    context.read<HomeBloc>().add(OnGetCategoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context, _scaffoldKey),
      endDrawer: Drawer(
        child: Container(
          padding: EdgeInsets.only(
            top: 24,
            left: 24,
            right: 24,
            bottom: 48,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF7F77FE),
                Color(0xFFA573FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: 34,
              ),
              Row(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image:
                            AssetImage('assets/images/image_dummy_person.png'),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Viko Muhammad S',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Viko@mail.com',
                        style: TextStyle(
                          color: textFieldBorderColor,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    icon: Image.asset(
                      'assets/images/icon_pencil_white.png',
                      width: 15,
                      height: 15,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(
                height: 50,
              ),
              Expanded(
                child: ListView(
                  children: [
                    _buildListTileDrawer('order', 'Orders'),
                    _buildListTileDrawer('wishlist', 'Wishlist'),
                    _buildListTileDrawer('delivery', 'Delivery Address'),
                    _buildListTileDrawer('payment', 'Payment Method'),
                    _buildListTileDrawer('promo', 'Promo Card'),
                    _buildListTileDrawer('notification', 'Notifications'),
                    _buildListTileDrawer('help', 'Help'),
                    _buildListTileDrawer('about', 'About'),
                  ],
                ),
              ),
              _buildListTileDrawer('logout', 'Logout'),
            ],
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(
          top: 50,
        ),
        child: Column(
          children: [
            _buildCategories(context),
            SizedBox(
              height: 48,
            ),
            Expanded(
              child: BlocBuilder<HomeBloc, HomeState>(
                builder: (context, state) {
                  switch (state.productState) {
                    case RequestState.Loading:
                      return LoadingWidget();
                    case RequestState.Loaded:
                      final products = state.products;
                      return Padding(
                        padding: const EdgeInsets.all(31),
                        child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.55,
                            crossAxisSpacing: 14,
                          ),
                          itemCount: products.length,
                          itemBuilder: (ctx, index) {
                            return _buildProductItem(context, products[index]);
                          },
                        ),
                      );
                    case RequestState.Error:
                      return errorWidget.ErrorWidget(state.productError);
                    default:
                      return errorWidget.ErrorWidget(
                        "Oops... Something wrong, please try again later!",
                      );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListTile _buildListTileDrawer(
    String image,
    String title,
  ) {
    return ListTile(
      leading: Image.asset(
        'assets/images/icon_${image}_white.png',
        width: 24,
      ),
      contentPadding: EdgeInsets.all(0),
      horizontalTitleGap: 0,
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }

  Widget _buildProductItem(BuildContext context, Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          ProductDetailPage.ROUTE_NAME,
          arguments: product.id,
        );
      },
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 24,
            ),
            decoration: BoxDecoration(
              color: productBg,
              borderRadius: BorderRadius.circular(15),
            ),
            child: ImageNetworkWidget(
              height: 100,
              width: 100,
              imageUrl: product.imageUrl,
            ),
          ),
          SizedBox(
            height: 18,
          ),
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "\$${product.price} ",
              style: TextStyle(
                fontSize: 18,
                color: greyColor,
                fontWeight: FontWeight.w900,
              ),
              children: [
                TextSpan(
                  text: "USD",
                  style: TextStyle(
                    fontSize: 12,
                    color: greyColor,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Column _buildCategories(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              switch (state.categoryState) {
                case RequestState.Loading:
                  return LoadingWidget();
                case RequestState.Loaded:
                  final categories = state.categories;
                  return _buildListCategories(categories);
                case RequestState.Error:
                  return errorWidget.ErrorWidget(
                    state.categoryError,
                  );
                default:
                  return errorWidget.ErrorWidget("Error...");
              }
            },
          ),
        ),
        Container(
          height: 1,
          margin: EdgeInsets.symmetric(
            horizontal: 32,
          ),
          color: dividerColor,
          width: MediaQuery.of(context).size.width,
        ),
      ],
    );
  }

  AppBar _buildAppBar(
      BuildContext context, GlobalKey<ScaffoldState> scaffoldKey) {
    return AppBar(
      title: Image.asset(
        'assets/images/icon_logo.png',
        width: 70,
        height: 68,
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 23,
          ),
          child: Image.asset(
            'assets/images/icon_notification.png',
            width: 24,
            height: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 23,
          ),
          child: Image.asset(
            'assets/images/icon_cart.png',
            width: 24,
            height: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 23,
          ),
          child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(WishlistPage.ROUTE_NAME);
            },
            borderRadius: BorderRadius.circular(12),
            splashColor: dividerColor,
            child: Image.asset(
              'assets/images/icon_favorite.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 23,
          ),
          child: Image.asset(
            'assets/images/icon_search.png',
            width: 24,
            height: 24,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            right: 23,
          ),
          child: IconButton(
            onPressed: () {
              scaffoldKey.currentState?.openEndDrawer();
            },
            icon: Image.asset(
              'assets/images/icon_menu.png',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }

  ListView _buildListCategories(List<Category> categories) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: categories.map((category) {
        return GestureDetector(
          onTap: () => context
              .read<HomeBloc>()
              .add(OnSelectedCategoryEvent(category.name)),
          child: Padding(
            padding: EdgeInsets.only(
              left: 30,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: TextStyle(
                    color: category.isSelected ? purpleColor : greyColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                category.isSelected
                    ? Container(
                        height: 5,
                        width: 24,
                        decoration: BoxDecoration(
                          color: purpleColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      )
                    : SizedBox.shrink(),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
