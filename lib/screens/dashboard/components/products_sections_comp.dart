import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/product_info_card_comp.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class ProductSection extends StatelessWidget {
  const ProductSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    // return Column(
    //   children: [
      return  Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AutoSizeText(
              'Products',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            ElevatedButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        horizontal: defaultPadding * 1.5,
                        vertical: defaultPadding)),
                icon: Icon(Icons.add),
                label: Text("Add new"))
          ],
        );
        // ProductInfoGridView()
        // Expanded(
        //           child: Responsive(
        //       mobile: ProductInfoGridView(
        //         crossAxisCount:_size.width < 650 ? 2 : 4,
        //         childAspectRatio: _size.width < 650 ? 1.3:1,
        //         ),
        //       tablet: ProductInfoGridView(),
        //       desktop: ProductInfoGridView(
        //         childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
        //       )),
        // ),
      // ],
    // );
  }
}

class ProductInfoGridView extends StatelessWidget {
  final int crossAxisCount;
  final double childAspectRatio;
  const ProductInfoGridView({
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
          height:double.infinity,
          child: GridView.builder(
          shrinkWrap: true,
          // physics: NeverScrollableScrollPhysics(),
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: defaultPadding,
              childAspectRatio: childAspectRatio,
              crossAxisSpacing: defaultPadding),
          itemBuilder: (context, index) => ProductInfoCard()),
    );
  }
}
