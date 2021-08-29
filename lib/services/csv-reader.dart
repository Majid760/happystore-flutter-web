
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

try{
     String s = new String.fromCharCodes(selectedCSVFile.bytes);
     ProgressIndicatorController proIndi = Provider.of<ProgressIndicatorController>(context);
     

        // Get the UTF8 decode as a Uint8List
        var outputAsUint8List = new Uint8List.fromList(s.codeUnits);
        // split the Uint8List by newline characters to get the csv file rows
        csvFileContentList = utf8.decode(outputAsUint8List).split('\n');
        print('Selected CSV File contents: ');
        // print(csvFileContentList);
  
 // Check the column titles and sequence - is the CSV file in the correct template format?
        // if (csvFileContentList[0].toString().trim().hashCode !=
        //     csvFileHeaderRowColumnTitles.hashCode) {
        //   // CSV file is not in correct format
        //   print('CSV file does not seem to have a valid format');
        //   return 'Error: The CSV file does not seem to have a valid format.';
        // }
 
// Check the column titles and sequence - is the CSV file in the correct template format?
        // if (csvFileContentList[0].toString().trim().hashCode !=
        //     csvFileHeaderRowColumnTitles.hashCode) {
          // CSV file is not in correct format
          // print('CSV file does not seem to have a valid format');
          // return 'Error: The CSV file does not seem to have a valid format.';
        // }

// check if CSV file has any content - content length > 0?
        if (csvFileContentList.length == 0 ||
            csvFileContentList[1].length == 0) {
          // CSV file does not have content
          print('CSV file has no content');
          return 'Error: The CSV file has no content.';
        }
        // // CSV file seems to have a valid format
        // print(
        //     'CSV file has a valid format and has contents, hence proceed to parse...');

// Current First row of the CSV file has column headers - remove it

        // print(csvFileContentList[1]);
        print('Selected CSV File contents after removing the Column Headers: ');

        Map<String,String> product = new Map();  
        List<Map> productList = [];
        List<dynamic> firstRow = csvFileContentList[0].split(',');
        print('headers');
        firstRow.forEach((item)=>{
          print(item)

        });
        List<String> images = [];
          // fetch the each row from csv file and it gives the entire row in string form except fire row of column header 
        for(int i=1; i<csvFileContentList.length-1; i++){
          proIndi.setProgressValue(i);

          // convert the row(string) into list
          List<String> rowList = csvFileContentList[i].split(',');
           List<String> newrowList = [];
          if(rowList.length>14){
            // print(rowList.indexOf("\""));
            for(int x=5; x<rowList.indexOf("\""); x++){
              images.add(rowList[x]);
            }
            newrowList = rowList.sublist(0,5);
            newrowList.addAll(rowList.sublist(rowList.indexOf("\"")));
            int indexOf = newrowList.indexOf("\"");
            newrowList[indexOf] = images.toString();
            images.clear();
          }else{
            newrowList = rowList;
            newrowList.removeWhere((element) => element=="\"");
          }
          
          for(int j=0; j<newrowList.length; j++){
            product[firstRow[j]] = newrowList[j];
          }
          newrowList.clear();
          rowList.clear();
          // print(product);
          productList.add(product);
        }
        Product().setProductListToFirebase(productList);
        
        // print(productList);
        // print(productList.length);
        
// Remove Duplicate Rows from the CSV File
    //     csvList = csvFileContentList.toSet().toList();
    //     print('CSV file contents after deduplication / removal of duplicates');
    //  //CSV Files in Array  
    //  print(csvList);

//Array to class module
// csvList.forEach((csvRow) {
//  if (csvRow != null && csvRow.trim().isNotEmpty) {
//             // current row has content and is not null or empty
// CsvModuleList.add(CsvModuleList.followedBy(csvRow.split(',')));
// }
// });


}catch (e) {
        print(e.toString());

        return 'Error: ' + e.toString();
 }

// CsvModuleList.forEach((data){
//     print(data.toList());
//     print(data.toJson());
// });

}