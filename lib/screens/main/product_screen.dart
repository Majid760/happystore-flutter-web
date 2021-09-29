import 'dart:io';

import 'package:admin/controllers/FirebaseController.dart';
import 'package:admin/controllers/ProgressIndicatorController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header_comp.dart';
import 'package:admin/services/csv-reader.dart';
import 'package:admin/services/image-cache.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/circle.dart';
import 'components/side_menu.dart';

class ProductScreen extends StatelessWidget {
  ProductScreen() {
    // FirebaseController ins = new FirebaseController();
  }
  static const String routeName = "product";
  File file;
  PlatformFile selectedFile;
  Future selectCSVFile(context) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        withData: true,
        type: FileType.custom,
        allowedExtensions: ['csv']);
    if (result != null) {
      selectedFile = result.files.first;
      Future<String> data = selectParseCSV(selectedFile, context);
    } else {
      selectedFile = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    // List tableRows = Product().products_stream.data();
    return Scaffold(
        // key:Provider.of<MenuController>(context).scaffoldKey,
        drawer: SideMenu(),
        body: SafeArea(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (Responsive.isDesktop(context))
              Expanded(
                child: SideMenu(),
              ),
            Expanded(
                flex: 5,
                child: SafeArea(
                    child: SingleChildScrollView(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(),
                      SizedBox(height: defaultPadding),
                      // product page start here
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                flex: 2,
                                child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                AutoSizeText(
                                                  'Upload file (csv or xl)',
                                                  maxLines: 3,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(
                                                      20.0),
                                                  child: IconButton(
                                                    iconSize: 30,
                                                    icon:
                                                        Icon(Icons.file_upload),
                                                    onPressed: () {
                                                      selectCSVFile(context);
                                                    },
                                                  ),
                                                ),
                                                Text(file != null
                                                    ? basename(file.path)
                                                    : 'No file selected')
                                              ]),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Consumer<
                                                        ProgressIndicatorController>(
                                                    builder: (context,
                                                        indicator, _) {
                                                  return Container(
                                                      child:
                                                          CircularPercentIndicator(
                                                    header: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                          'File Reading Progreass'),
                                                    ),
                                                    radius: 100.0,
                                                    lineWidth: 10.0,
                                                    animation: true,
                                                    animationDuration: (indicator
                                                                .progress_indicator *
                                                            100)
                                                        .toInt(),
                                                    percent: indicator
                                                            .progress_indicator /
                                                        100,
                                                    center: AutoSizeText(
                                                        indicator
                                                            .progress_indicator
                                                            .toStringAsFixed(
                                                                2)),
                                                    footer: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                          'Total Entries ${indicator.length_file}'),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Colors.purple,
                                                  ));
                                                }),
                                                Consumer<
                                                        ProgressIndicatorController>(
                                                    builder: (context,
                                                        indicator, _) {
                                                  return Container(
                                                      child:
                                                          CircularPercentIndicator(
                                                    header: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                          'File Reading Progreass'),
                                                    ),
                                                    radius: 100.0,
                                                    lineWidth: 10.0,
                                                    animation: true,
                                                    animationDuration: (indicator
                                                                .progress_indicator *
                                                            100)
                                                        .toInt(),
                                                    percent: indicator
                                                            .progress_indicator /
                                                        100,
                                                    center: AutoSizeText(
                                                        indicator
                                                            .progress_indicator
                                                            .toStringAsFixed(
                                                                2)),
                                                    footer: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                          'Total Entries ${indicator.length_file}'),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Colors.purple,
                                                  ));
                                                }),
                                              ]),
                                        )
                                      ],
                                    ))),
                            Expanded(
                                flex: 2,
                                child: Container(
                                    height: 200,
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                    )))
                          ],
                        ),
                      ),
                      // product listing section

                      AutoSizeText(
                        'List of Products',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: StreamBuilder(
                              stream: FirebaseController().products_stream,
                              builder: (context, snapshot) {
                                if (!snapshot.hasError) {
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: DataTable(
                                        // columnSpacing: defaultPadding,
                                        headingRowColor:
                                            MaterialStateColor.resolveWith(
                                          (states) {
                                            return Colors.cyan.shade900;
                                          },
                                        ),
                                        columns: [
                                          DataColumn(label: Text("Id")),
                                          DataColumn(label: Text("Name")),
                                          DataColumn(label: Text("Category")),
                                          DataColumn(label: Text("Image")),
                                          DataColumn(
                                              label: Text("Original(\$)")),
                                          DataColumn(label: Text("Sale(\$)")),
                                          DataColumn(label: Text("Discount")),
                                          DataColumn(label: Text("Commission")),
                                          DataColumn(label: Text("Date")),
                                          DataColumn(label: Text('Info'))
                                        ],
                                        rows:
                                            _listofRows(snapshot.data, context),
                                      ),
                                    ),
                                  );
                                } else {
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                              })),
                    ],
                  ),
                )))
          ],
        )));
  }
}

List<DataRow> _listofRows(snapshotData, context) {
  int i = 0;
  List<DataRow> newList =
      snapshotData.docs.map<DataRow>((DocumentSnapshot documentSnapshot) {
    i++;
    Map data = documentSnapshot.data() as Map;
    return DataRow(cells: <DataCell>[
      DataCell(Text(i.toString())),
      DataCell(Text(
        data['Product Name'].substring(0,9)+' ...',
        maxLines: 2,
      )),
      DataCell(Text(data['Category Name'].substring(0,9) + ' ...')),
      DataCell(
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
                height: 100,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: showProductImage(data['Product Image Url']))),
      ),
      DataCell(Text(data['originalPrice'])),
      DataCell(Text(data['salePrice'])),
      DataCell(Text(data['Discount'])),
      DataCell(Text(data['Commission Rate'])),
      DataCell(Text(data['Out of Stock Date'])),
      DataCell(
           Text('Edit'),
           onTap:(){
             _displayDialog(context, data);
           },
          showEditIcon: true
          )
    ]);
  }).toList();

  return newList;
}

_displayDialog(context, data) {
  showDialog(
      context: context,
      builder: (_) => new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0))),
            content: Builder(
              builder: (context) {
                // Get available height and width of the build area of this widget. Make a choice depending on the size.
                var height = MediaQuery.of(context).size.height;
                var width = MediaQuery.of(context).size.width;

                return Container(
                    height: height - 300,
                    width: width - 800,
                    child: productDetailPage(context, data));
              },
            ),
          ));
}

Widget productDetailPage(context, product) {
  List<String> images = product['allImageUrls(5<)'].split(',');
  images[0] = images[0].substring(2);
  images[4] = images[4].substring(0, images[4].length - 1);

  return Scaffold(
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0, top: 5),
        child: Container(
          height: MediaQuery.of(context).size.height * .8,
          child: Column(children: [
            // images section and favoratie and back button
            SizedBox(
              height: MediaQuery.of(context).size.height * .3,
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // back and favorite button

                    Stack(alignment: AlignmentDirectional.center, children: [
                      Column(children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.20,
                            width: MediaQuery.of(context).size.width * .35,
                            child: Center(child: showProductImage(images[0]))),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleWidget(
                                  imageUrl: images[0],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleWidget(
                                  imageUrl: images[1],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleWidget(
                                  imageUrl: images[2],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleWidget(
                                  imageUrl: images[3],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: CircleWidget(
                                  imageUrl: "${images[4]}",
                                ),
                              )
                            ]),
                      ])
                    ]),
                  ],
                ),
              ),
            ),

            // product name ,color, size and rating sections
            Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AutoSizeText(
                  '${product['Product Name']}',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                  maxLines: 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Discount",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('${product['Discount']}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Sale Price",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('\$${product['salePrice']}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Original Price",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text('\$${product['originalPrice']}',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.white))
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancle')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: Text('Submit')),
                    ],
                  ),
                ),
              ],
            )),
          ]),
        ),
      ),
    ),
  );
}

class CircleWidget extends StatelessWidget {
  final String imageUrl;

  const CircleWidget({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleComp(
      height: 50,
      width: 50,
      radius: 10,
      borderSize: 1,
      wiget: Container(
        height: 40,
        width: 40,
        child: showProductImage(this.imageUrl.trim()),
      ),
    );
  }
}
