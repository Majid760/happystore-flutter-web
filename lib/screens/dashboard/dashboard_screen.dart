import 'package:admin/screens/dashboard/components/header_comp.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../constants.dart';
import 'components/chart_comp.dart';
import 'components/index_page_body.dart';
import 'components/product_info_card_comp.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      padding: EdgeInsets.all(defaultPadding),
      child: Column(
        children: [
          Header(), 
          SizedBox(height: defaultPadding), 
          IndexPageBody()],
      ),
    ));
  }
}


