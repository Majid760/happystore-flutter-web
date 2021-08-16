import 'package:admin/controllers/MenuController.dart';
import 'package:admin/responsive.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../constants.dart';


class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if(!Responsive.isDesktop(context))
        IconButton (icon:Icon(Icons.menu),onPressed:(){ 
          context.read<MenuController>().controlMenu();
          },),
        if(!Responsive.isMobile(context))
        AutoSizeText(
          'Dashboard',
          style: Theme.of(context).textTheme.headline6,
        ),
        if(!Responsive.isMobile(context))
        Spacer(flex:Responsive.isDesktop(context)?2:1),
        Expanded(child: SearchField()),
        ProfileCard()
      ],
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: "Search",
          fillColor: secondaryColor,
          filled: true,
          border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: const BorderRadius.all(Radius.circular(10))),
          suffixIcon: InkWell(
            onTap: () {},
            child: Container(
                margin: EdgeInsets.all(defaultPadding / 2),
                padding: EdgeInsets.all(defaultPadding * 0.75),
                decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: const BorderRadius.all(Radius.circular(10))),
                child: SvgPicture.asset('assets/icons/Search.svg')),
          )),
    );
  }
}

class   ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: defaultPadding),
      padding: EdgeInsets.symmetric(
          horizontal: defaultPadding,
          vertical: defaultPadding / 2),
      decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          border: Border.all(color: Colors.white10)),
      child: Row(
        children: [
          Image.asset(
            'assets/images/profile_pic.png',
            height: 35,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: defaultPadding / 2),
            child: AutoSizeText('Joe Biden', maxLines: 1,),
          ),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }
}
