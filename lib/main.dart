import 'package:admin/constants.dart';
import 'package:admin/controllers/MenuController.dart';
import 'package:admin/screens/main/main_screen.dart';
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

void main() async{
  setPathUrlStrategy();
  FirebaseApp defaultApp = await Firebase.initializeApp();
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
      StreamProvider<double>(create: (context)=>Product().stream, initialData:0,
      catchError: (_, error) => error,
      )
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(value: Authentication().onAuthStateChanged,),
      
      ],
      child:MaterialApp(
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
      home:WelcomePage(),
      )
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Authentication().onAuthStateChanged;
    var route = ModalRoute.of(context);
    if (route != null) {
      switch (route.settings.name) {
        case WelcomePage.routeName:
        return (user == null) ? WelcomePage() : MainScreen();
        break;
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
