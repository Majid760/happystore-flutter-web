import 'dart:async';
import 'dart:convert';
import 'dart:js_util';
import 'dart:typed_data';

import 'package:admin/controllers/ProgressIndicatorController.dart';
import 'package:admin/models/Product.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

List csvList;
List csvFileContentList = [];
List CsvModuleList = [];

// Select and Parse the CSV File
Future<String> selectParseCSV(selectedCSVFile, context) async {
//Optional for CSV Validation
  String csvFileHeaderRowColumnTitles =
      'Category Name,CategoryID,Product Name,ProductID,Product Image Url,allImageUrls(5<),Product Url,originalPrice(\\U+0024),salePrice(\\U+0024),Commission Rate,Out of Stock Date,Discount,Click url';

  try {
    String s = new String.fromCharCodes(selectedCSVFile.bytes);
    ProgressIndicatorController proIndi =
        Provider.of<ProgressIndicatorController>(context,listen: false);

    // Get the UTF8 decode as a Uint8List
    var outputAsUint8List = new Uint8List.fromList(s.codeUnits);
    // split the Uint8List by newline characters to get the csv file rows
    csvFileContentList = utf8.decode(outputAsUint8List).split('\n');

    // check if CSV file has any content - content length > 0?
    if (csvFileContentList.length == 0 || csvFileContentList[1].length == 0) {
      // CSV file does not have content
      print('CSV file has no content');
      return 'Error: The CSV file has no content.';
    }

    // Remove Duplicate Rows from the CSV File
    // csvList = csvFileContentList.toSet().toList();
    // proIndi.setLength(csvList.length);

    // Current First row of the CSV file has column headers - remove it
    Map<String, String> product = new Map();
    List<Map> productList = [];
    List<dynamic> firstRow = csvFileContentList[0].split(',');
    int IndexOfSign = firstRow.indexOf("salePrice(\$)");
    firstRow[IndexOfSign] = "salePrice";
    IndexOfSign = firstRow.indexOf("originalPrice(\$)");
    firstRow[IndexOfSign] = "originalPrice";
    
    List<String> images = [];
    // removing the duplicate row/record
    csvList = csvFileContentList.toSet().toList();
    // fetch the each row from csv file and it gives the entire row in string form except fire row of column header
    for (int i = 1; i < csvList.length - 1; i++) {
      proIndi.setProgressValue(i,csvList.length);

      // convert the row(string) into list
      List<String> rowList = csvList[i].split(',');
      

      List<String> newrowList = [];
      if (rowList.length > 14) {
        // print(rowList.indexOf("\""));
        for (int x = 5; x < rowList.indexOf("\""); x++) {
          images.add(rowList[x]);
        }
        newrowList = rowList.sublist(0, 5);
        newrowList.addAll(rowList.sublist(rowList.indexOf("\"")));
        int indexOf = newrowList.indexOf("\"");
        newrowList[indexOf] = images.toString();
        images.clear();
      } else {
        newrowList = rowList;
        newrowList.removeWhere((element) => element == "\"");
      }

      for (int j = 0; j < newrowList.length; j++) {
        product[firstRow[j]] = newrowList[j];
      }
      newrowList.clear();
      rowList.clear();
      productList.add(product);
    }
    Product().setProductListToFirebase(productList);

//Array to class module
// csvList.forEach((csvRow) {
//  if (csvRow != null && csvRow.trim().isNotEmpty) {
//             // current row has content and is not null or empty
// CsvModuleList.add(CsvModuleList.followedBy(csvRow.split(',')));
// }
// });

  } catch (e) {
    print(e.toString());

    return 'Error: ' + e.toString();
  }

// CsvModuleList.forEach((data){
//     print(data.toList());
//     print(data.toJson());
// });
}
