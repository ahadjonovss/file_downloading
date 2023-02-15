import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void showToast(){
  Fluttertoast.showToast(
      msg: "Firstly, you must download",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey,
      textColor: Colors.white,
      fontSize: 16.0
  );
}