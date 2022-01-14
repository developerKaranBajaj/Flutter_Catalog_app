import 'package:first_application/core/store.dart';
import 'package:first_application/pages/cart_page.dart';
import 'package:first_application/pages/home_page.dart';
import 'package:first_application/pages/login_page.dart';
import 'package:first_application/utils/routes.dart';
import 'package:first_application/widgets/theme.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

void main() {
  runApp(VxState(
    store: MyStore(),
    child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme(context),
      darkTheme: MyTheme.darkTheme(context),
      routes: {
        "/" : (context)=> const HomePage(),
        MyRoutes.homePage: (context) => const HomePage(),
        "/Login": (context) => const LoginPage(), 
        MyRoutes.cartRoute: (context) =>  const CartPage(),
        
      },
    );
  }
}
 