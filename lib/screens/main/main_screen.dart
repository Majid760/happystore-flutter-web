import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'components/side_menu.dart';
import 'package:provider/provider.dart';
class MainScreen extends StatelessWidget {
  static const String routeName = 'home';
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key:Provider.of<MenuController>(context).scaffoldKey,
      drawer: SideMenu(),
        body: SafeArea(
            child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(Responsive.isDesktop(context))
        Expanded( 
          child: SideMenu(),
        ),
        Expanded(
          flex: 5,
          child: DashboardScreen(),
        )
      ],
    )));
  }
}
