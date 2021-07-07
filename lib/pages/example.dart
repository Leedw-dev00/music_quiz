import 'package:flutter/material.dart';

class Example extends StatelessWidget{




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:SafeArea(child: FlatButton(child: Text('Next'), onPressed: (){},),)
    );
  }
}