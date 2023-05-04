import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:venmo_payment/venmo_payment.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _venmoResponse = "";

  @override
  void initState() {
    super.initState();
    VenmoPayment.initialize(appId: "", secret: "", name: "");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Venmo Plugin example app'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Center(
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.lightBlue)
                ),
                onPressed: () async {
                  _venmoResponse = (await VenmoPayment.createPayment(
                    recipientUsername: 'cj-lang',
                    fineAmount: 1,
                    description: 'Testing Venmo from Plugin',
                  )).toString();
                  setState(() => _venmoResponse = _venmoResponse);
                },
                child: const Text(
                  "Go To Venmo",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Text("Venmo Response: $_venmoResponse"),
          ],
        ),
      ),
    );
  }
}
