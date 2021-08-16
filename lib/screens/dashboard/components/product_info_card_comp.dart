import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import '../../../constants.dart';
class ProductInfoCard extends StatelessWidget {
  const ProductInfoCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
          color: secondaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(Icons.production_quantity_limits),
                ),
                Icon(Icons.more_vert, color: Colors.white54)
              ],
            ),
            AutoSizeText(
              'Products',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            ProgressLine(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AutoSizeText(
                  'Products',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white70),
                ),
                AutoSizeText(
                  '2343',
                  style: Theme.of(context)
                      .textTheme
                      .caption
                      .copyWith(color: Colors.white70),
                )
              ],
            )
          ],
        ));
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.orange.withOpacity(.1)),
      ),
      LayoutBuilder(
        builder: (context, constraints) => Container(
          width: constraints.maxWidth * 0.5,
          height: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10), color: Colors.orange),
        ),
      )
    ]);
  }
}
