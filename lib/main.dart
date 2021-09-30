import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/loginPage.dart';
import 'package:admin/screens/main/main_screen.dart';
import 'package:admin/screens/signup.dart';
import 'package:admin/screens/welcomePage.dart';
import 'package:device_preview/device_preview.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';

import 'controllers/AuthController.dart';
import 'controllers/ProgressIndicatorController.dart';
import 'models/Product.dart';
import 'screens/main/product_screen.dart';

void main() async {
  setPathUrlStrategy();
   await Firebase.initializeApp();
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MyApp(), // Wrap your app
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => MenuController()),
      StreamProvider<User>.value(
        initialData: null,
        value: Authentication().onAuthStateChanged,
      ),
      ChangeNotifierProvider(
        create: (context) => ProgressIndicatorController(),
      ),
      StreamProvider<double>(
        create: (context) => Product().stream,
        initialData: 0,
        catchError: (_, error) => error,
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      locale: DevicePreview.locale(context), // Add the locale here
      builder: DevicePreview.appBuilder,
      initialRoute: '/',
      routes: {
        ProductScreen.routeName: (context) => ProductScreen(),
        SignUpPage.routeName:(context) => SignUpPage(),
        LoginPage.routeName:(context) => LoginPage()
      },
      title: 'Happystore Admin Panel',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: bgColor,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.white),
        canvasColor: secondaryColor,
      ),
      home: user == null ? WelcomePage(): MainScreen(),
    );
  }
}

