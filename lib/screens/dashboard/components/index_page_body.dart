import 'package:admin/screens/dashboard/components/product_info_card_comp.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../constants.dart';
import '../../../responsive.dart';
import 'chart_comp.dart';

class IndexPageBody extends StatelessWidget {
  const IndexPageBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 5,
          child: Column(
            children: [
            MyFiles(),
            SizedBox(height: defaultPadding),
            ProductListingSection(),
            if(Responsive.isMobile(context))
            SizedBox(
            height: defaultPadding,
          ),
          if(Responsive.isMobile(context))
            ProductInfoStat(),
            ]
            ),
        ),
        SizedBox(
            width: defaultPadding,
          ),
        // if the screen less than 850 we don't want to show it
         if (!Responsive.isMobile(context))
          SizedBox(
            width: defaultPadding,
          ),
        if (!Responsive.isMobile(context))
          Expanded(flex: 2, child: ProductInfoStat())
      ],
    );
  }
}



class MyFiles extends StatelessWidget {
  const MyFiles({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(children: [
      Row(
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
      ),
      SizedBox(height: defaultPadding),
      Responsive(
      mobile:GridViewCard(crossAxisCount:_size.width < 650 ? 2:4, aspectRatio: _size.width < 650 ? 1.3:1,),
      desktop: GridViewCard(aspectRatio:_size.width < 1400 ? 1.1 : 1.4),
      tablet: GridViewCard()
      ) ,
    ]);
  }
}

class GridViewCard extends StatelessWidget {
  final int crossAxisCount;
  final double aspectRatio;
  const GridViewCard({
    Key key, this.crossAxisCount=4, this.aspectRatio=1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 4,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: aspectRatio,
            crossAxisSpacing: defaultPadding),
        itemBuilder: (context, index) => ProductInfoCard());
  }
}

class ProductListingSection extends StatelessWidget {
  const ProductListingSection({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: secondaryColor, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              'Products',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
                width: double.infinity,
                child: DataTable(
                  // columnSpacing: defaultPadding,
                  columns: [
                    DataColumn(label: Text("Id")),
                    DataColumn(label: Text("Name")),
                    DataColumn(label: Text("Image")),
                    DataColumn(label: Text("Price")),
                    DataColumn(label: Text("Discount")),
                    DataColumn(label: Text("Category")),
                    DataColumn(label: Text("Date")),
                  ],
                  rows: [
                    DataRow(cells: [
                      DataCell(Text('kdkd'), onTap: () {
                        print('your proess 1');
                      }),
                      DataCell(Text('kdkd'), onTap: () {
                        print('your proess 1');
                      }),
                      DataCell(Text('kdkd'), onTap: () {
                        print('your proess 1');
                      }),
                      DataCell(Text('kdkd'), onTap: () {
                        print('your proess 1');
                      }),
                      DataCell(Text('kdkd'), onTap: () {
                        print('your proess 1');
                      }),
                      DataCell(Text('kdkd'), onTap: () {
                        print('your proess 1');
                      }),
                      DataCell(Text('kdkd'), onTap: () {
                        print('your proess 1');
                      })
                    ])
                  ],
                ))
          ],
        ));
  }
}

class ProductInfoStat extends StatelessWidget {
  const ProductInfoStat({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(defaultPadding),
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: Column(
          children: [
            AutoSizeText(
              "Product Details",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: defaultPadding,
            ),
            Chart(),
            StorageInfoCard(
              svg: "assets/icons/Documents.svg",
              title: 'Product Files',
              amountOfFiles: '123 Files',
              numOfFiles: 345.34,
            ),
            StorageInfoCard(
              svg: "assets/icons/media.svg",
              title: 'Media Files',
              amountOfFiles: '123 Files',
              numOfFiles: 3345.34,
            ),
            StorageInfoCard(
              svg: "assets/icons/folder.svg",
              title: 'Others Files',
              amountOfFiles: '123 Files',
              numOfFiles: 3345.34,
            ),
          ],
        ));
  }
}

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