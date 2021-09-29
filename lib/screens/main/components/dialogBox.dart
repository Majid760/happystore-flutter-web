import 'package:flutter/material.dart';
import 'package:awesome_dialog/awesome_dialog.dart';




AwesomeDialog msgDialog(BuildContext context, [String message]){
  return AwesomeDialog(
            context: context,
            animType: AnimType.SCALE,
            dialogType: DialogType.INFO,
            body: Center(child: Text(message,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),),
            // title: '',
            desc:   message,
            btnOkOnPress: () {},
            )..show();


}
