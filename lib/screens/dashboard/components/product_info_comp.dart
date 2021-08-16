
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../constants.dart';


class StorageInfoCard extends StatelessWidget {
  final String title, svg, amountOfFiles;
  final double numOfFiles;
  const StorageInfoCard(
      {Key key,
      @required this.title,
      @required this.svg,
      @required this.amountOfFiles,
      @required this.numOfFiles})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: defaultPadding),
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            border: Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: BorderRadius.circular(defaultPadding)),
        child: Row(
          children: [
            SizedBox(height: 20, width: 20, child: SvgPicture.asset(svg)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    AutoSizeText(amountOfFiles,
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            .copyWith(color: Colors.white70))
                  ],
                ),
              ),
            ),
            AutoSizeText("$numOfFiles")
          ],
        ));
  }
}
