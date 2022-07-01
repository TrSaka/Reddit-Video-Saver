// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:redditsaver/Pages/MainPage.dart';
import 'package:redditsaver/main.dart';

class UnconnectedDialog extends StatelessWidget {
  const UnconnectedDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }

  _buildChild(BuildContext context) => Container(
        height: 320,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Icon(
                Icons.wifi_rounded,
                size: 144,
                color: Colors.red,
              ),
            ),
            Text(
              "Oh No !",
              style: TextStyle(
                color: Colors.black54,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "No internet connection found.",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 15,
              ),
            ),
            Text(
              "Check your connection and try again.",
              style: TextStyle(
                color: Colors.black45,
                fontSize: 15,
              ),
            ),
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: (() {}),
              child: Text("Try Again", style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                elevation: 5,
                primary: Colors.red,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ),
              ),
            )
          ],
        ),
      );
}
