import 'package:flutter/material.dart';
import 'package:redditsaver/dialog/connectiondialog.dart';

class DialogHelper {
  static exit(context) => showDialog(
        context: context,
        builder: (context) => UnconnectedDialog(),
      );
}
