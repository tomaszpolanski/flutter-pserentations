import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_flutter_merchant/mobile_flutter_merchant.dart';

class GrouponApp extends StatefulWidget {
  @override
  _GrouponAppState createState() => _GrouponAppState();
}

class _GrouponAppState extends State<GrouponApp> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Image(
          image: AssetImage('assets/image32.png'),
          height: 250.0,
        )),
        Expanded(
          child: Center(
            child: Container(
              width: 480,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Groupon(),
            ),
          ),
        ),
      ],
    );
  }
}
