import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:meet_ups/Pages/Signin.dart';
import 'package:page_transition/page_transition.dart';

class AlertErrorDialog extends StatelessWidget {
  final String message;

  const AlertErrorDialog({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message),
      actions: <Widget>[
        RaisedButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                PageTransition(child: Signin(), type: PageTransitionType.fade));
          },
          child: Center(
            child: Text('OK'),
          ),
        )
      ],
    );
  }
}
