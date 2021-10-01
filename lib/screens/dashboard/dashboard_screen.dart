import 'package:admin/screens/dashboard/components/header_comp.dart';
import 'package:flutter/material.dart';
import '../../constants.dart';
import 'components/index_page_body.dart';

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


