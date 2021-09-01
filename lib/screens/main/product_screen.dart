import 'dart:io';

import 'package:admin/controllers/FirebaseController.dart';
import 'package:admin/controllers/ProgressIndicatorController.dart';
import 'package:admin/models/Product.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header_comp.dart';
import 'package:admin/services/csv-reader.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import 'components/side_menu.dart';

class ProductScreen extends StatelessWidget {
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
                        'Products',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      SizedBox(
                          width: double.infinity,
                          child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('products')
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (!snapshot.hasError) {
                                  return DataTable(
                                    // columnSpacing: defaultPadding,
                                    columns: [
                                      DataColumn(label: Text("Id")),
                                      DataColumn(label: Text("Name")),
                                      DataColumn(label: Text("Category")),
                                      DataColumn(label: Text("Image")),
                                      DataColumn(label: Text("Original Price")),
                                      DataColumn(label: Text("Sale Price")),
                                      DataColumn(label: Text("Discount")),
                                      DataColumn(label: Text("Commission")),
                                      DataColumn(label: Text("Date")),
                                    ],
                                    rows: _listofRows(snapshot.data),
                                  );
                                } else {
                                  return  Center(
                                      child: Center(
                                          child: Text('Some bad thing happend')));
                                }
                              })),
                    ],
                  ),
                )))
          ],
        )));
  }
}

List<DataRow> _listofRows(snapshotData) {
  // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
  List<DataRow> newList = snapshotData.docs.map((DocumentSnapshot documentSnapshot) {
    Map data = documentSnapshot.data() as Map;
      return DataRow(cells: [
        DataCell(Text(data['ProductID'])),
        DataCell(Text(data['Product Name'])),
        DataCell(Text(data['Category Name'])),
        DataCell(Text(data['Product Image Url'])),
        DataCell(Text(data['originalPrice'])),
        DataCell(Text(data['salePrice'])),
        DataCell(Text(data['Discount'])),
        DataCell(Text(data['Commission Rate'])),
        DataCell(Text(data['Out of Stock Date'])),
      ]);
  }).toList();
  // newList = newList.whereType<DataRow>();

  return newList;
}

// List<DataRow> _createRows(QuerySnapshot snapshot) {
//     List<DataRow> newList =
//         snapshot.docs.map((documentSnapshot) {
//       return new DataRow(
//         cells: [
//             DataCell(Text(documentSnapshot.data()['ProductID'].toString() ?? 'default value')),
//             DataCell(Text(documentSnapshot.data()['Product Name'].toString())),
//             DataCell(Text(documentSnapshot.data()['Category Name'].toString())),
//             DataCell(Text(documentSnapshot.data()['Product Image Url'].toString())),
//             DataCell(Text(documentSnapshot.data()['originalPrice'].toString())),
//             DataCell(Text(documentSnapshot.data()['salePrice'].toString())),
//             DataCell(Text(documentSnapshot.data()['Discount'].toString())),
//             DataCell(Text(documentSnapshot.data()['Commission Rate'].toString())),
//             DataCell(Text(documentSnapshot.data()['Out of Stock Date'].toString())),
//       ]);
//     }).toList();

//     return newList;
//   }
