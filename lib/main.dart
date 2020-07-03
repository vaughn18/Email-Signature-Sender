import 'package:flutter/material.dart';

import './screens/email_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email & Signature Sender',
      theme: ThemeData(
        primaryColor: Colors.purple,
        accentColor: Colors.purpleAccent,
      ),
      home: EmailScreen(),
    );
  }
}
