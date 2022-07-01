// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:redditsaver/Pages/MainPage.dart';

class DownLoadPage extends StatefulWidget {
  const DownLoadPage({Key? key}) : super(key: key);

  @override
  State<DownLoadPage> createState() => _DownLoadPageState();
}

class _DownLoadPageState extends State<DownLoadPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.orange.shade900,
        elevation: 0,
      ),
    );
  }
}
