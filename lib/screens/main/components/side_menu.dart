import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset('assets/images/logo.png'),
            ),
            DrawerListTile(
                title: "Dashboard",
                svgSrc: "assets/icons/menu_dashbord.svg",
                press: () {}),
            DrawerListTile(
                title: "Products",
                svgSrc: "assets/icons/menu_doc.svg",
                press: () {}),
            DrawerListTile(
                title: "Users",
                svgSrc: "assets/icons/menu_profile.svg",
                press: () {}),
            DrawerListTile(
                title: "Stores",
                svgSrc: "assets/icons/menu_store.svg",
                press: () {}),
            DrawerListTile(
                title: "Transactions",
                svgSrc: "assets/icons/menu_tran.svg",
                press: () {}),
            DrawerListTile(
                title: "Notifications",
                svgSrc: "assets/icons/menu_notification.svg",
                press: () {}),
            DrawerListTile(
                title: "Setting",
                svgSrc: "assets/icons/menu_setting.svg",
                press: () {}),
          ],
        ),
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final String title, svgSrc;
  final VoidCallback press;
  const DrawerListTile({
    Key key,
    @required this.title,
    @required this.svgSrc,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        horizontalTitleGap: 0.0,
        onTap: press,
        leading: SvgPicture.asset(svgSrc, color: Colors.white54, height: 16),
        title: AutoSizeText(
          title,
          style: TextStyle(fontSize: 16.0),
          maxLines: 1,
        ));
  }
}
