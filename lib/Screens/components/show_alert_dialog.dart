import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String text, {Widget router}) {
  //设置按钮
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context, null);
      if (router != null) {
        Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => router,
          ),
        );
      }
    },
  );

  //设置对话框
  AlertDialog alert = AlertDialog(
    content: Text(text),
    actions: [
      okButton,
    ],
  );

  //显示对话框
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
