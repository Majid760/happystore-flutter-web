import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controllers/ProgressIndicatorController.dart';
import 'screens/main/product_screen.dart';

void main() {
  setPathUrlStrategy();
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MenuController()),
      ChangeNotifierProvider(
        create: (context) => ProgressIndicatorController(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      initialRoute: MainScreen.routeName,
      routes: {
        ProductScreen.routeName: (context) => ProductScreen(),
        // ProductDetail.routeName: (context) => ProductDetail(),
        // Home.routeName: (context) => Home(),
        // CardProducts.routeName: (context) => CardProducts(),
      },
      title: 'Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home:Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var route = ModalRoute.of(context);
    if (route != null) {
      switch (route.settings.name) {
        case MainScreen.routeName:
          return MainScreen();
          break;
        case ProductScreen.routeName:
          return ProductScreen();
          break;
        default:
          return MainScreen();
      }
    }
  }
}
