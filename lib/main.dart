import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:online_shop_app/presentation/pages/cart_page.dart';
import 'package:online_shop_app/presentation/pages/failed_page.dart';
import 'package:online_shop_app/presentation/pages/home/bloc/home_bloc.dart';
import 'package:online_shop_app/presentation/pages/home/home_page.dart';
import 'package:online_shop_app/presentation/pages/product_detail/bloc/product_detail_bloc.dart';
import 'package:online_shop_app/presentation/pages/product_detail/product_detail_page.dart';
import 'package:online_shop_app/presentation/pages/sign_in/bloc/sign_in_bloc.dart';
import 'package:online_shop_app/presentation/pages/sign_in/sign_in_page.dart';
import 'package:online_shop_app/presentation/pages/splash_page.dart';
import 'package:online_shop_app/presentation/pages/wishlist/bloc/wishlist_bloc.dart';
import 'package:online_shop_app/utils/route_observer.dart';

import 'presentation/pages/credit_card_page.dart';
import 'presentation/pages/wishlist/wishlist_page.dart';
import 'presentation/pages/success_page.dart';

import 'di/injection.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<HomeBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SignInBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<ProductDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<WishlistBloc>(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Lato',
          primarySwatch: Colors.blue,
        ),
        debugShowCheckedModeBanner: false,
        home: Material(
          child: SplashPage(),
        ),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case SplashPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SplashPage());
            case HomePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomePage());
            case SignInPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SignInPage());
            case CartPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => CartPage());
            case WishlistPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WishlistPage());
            case CreditCardPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => CreditCardPage());
            case SuccessPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SuccessPage());
            case FailedPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => FailedPage());
            case ProductDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => ProductDetailPage(
                  id: id,
                ),
              );
          }
        },
      ),
    );
  }
}
