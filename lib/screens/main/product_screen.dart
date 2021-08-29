import 'dart:io';

import 'package:admin/controllers/ProgressIndicatorController.dart';
import 'package:admin/responsive.dart';
import 'package:admin/screens/dashboard/components/header_comp.dart';
import 'package:admin/services/csv-reader.dart';
import 'package:auto_size_text/auto_size_text.dart';
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
      Future<String> data = selectParseCSV(selectedFile,context);
    } else {
      selectedFile = null;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                                  MainAxisAlignment
                                                      .spaceEvenly,
                                              children: [
                                                AutoSizeText(
                                                  'Upload file (csv or xl)',
                                                  maxLines: 3,
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(20.0),
                                                  child: IconButton(
                                                    iconSize: 30,
                                                    icon: Icon(Icons.file_upload),
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
                                                Container(
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
                                                    percent: 0.7,
                                                    center: Consumer<ProgressIndicatorController>(
                                                      builder: (context,indicator,_){
                                                      return AutoSizeText(indicator.progress_indicator.toStringAsFixed(3));
                                                    }, ),
                                                    footer: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                          'Total Entries'),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Colors.purple,
                                                  ),
                                                ),
                                                Container(
                                                  child:
                                                      CircularPercentIndicator(
                                                    header: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                          'File Uploading Progreass'),
                                                    ),
                                                    radius: 100.0,
                                                    lineWidth: 10.0,
                                                    animation: true,
                                                    percent: 0.4,
                                                    center: AutoSizeText('49%'),
                                                    footer: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: AutoSizeText(
                                                          'Total Entries'),
                                                    ),
                                                    circularStrokeCap:
                                                        CircularStrokeCap.round,
                                                    progressColor:
                                                        Colors.purple,
                                                  ),
                                                ),
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
                    ],
                  ),
                )))
          ],
        )));
  }
}
